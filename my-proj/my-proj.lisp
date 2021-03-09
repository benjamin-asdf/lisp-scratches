;;;; my-proj.lisp

(in-package #:my-proj)

(defvar *buf-stream* nil)
(defvar *gpu-arr* nil)
(defvar *viewport* nil)
(defvar *light-pos* (v! 0 30 -5))

(defclass camera ()
  ((pos :initform (v! 0 0 0)  :accessor pos)
   (rot :initform (q:identity) :accessor rot)))

(defclass thing ()
  ((pos :initform (v! 0 0 0)  :accessor pos)
   (rot :initform (q:identity) :accessor rot)))

(defvar *camera1* (make-instance 'camera))
(defvar *camera* (make-instance 'camera))




(defun-g some-vert-stage ((vert g-pnt)
                          &uniform (now :float)
                          (model->world :mat4)
                          (world->view :mat4)
                          (view->clip :mat4))
  (let* ((pos (pos vert))
         (now (+ now gl-instance-id))

         (normal (norm vert))
         (model-pos (v! pos 1))
         ;;  position the vertex
         (world-pos (* model->world model-pos))
         (world-norm (* (m4:to-mat3 model->world)
                        normal))
         ;; world space to view space
         (view-pos (* world->view world-pos))
         ;; view space to clip space
         (clip-pos (* view->clip view-pos)))
    (values
     clip-pos
     (s~ world-pos :xyz)
     world-norm)))


;; (:smooth color)

(defun-g some-frag-stage
    ((frag-pos :vec3)
     (frag-normal :vec3)
     &uniform (light-pos :vec3))
  (let* ((object-color (v! 1 0 0 0))
         (ambient 0.1)
         (vec-to-light (- light-pos frag-pos))
         (dir-to-light (normalize vec-to-light))
         (diffuse (dot dir-to-light frag-normal))
         (light-amount (+ ambient diffuse)))
    (* object-color light-amount)))

(setf (depth-test-function (cepl-context)) nil)
(setf (depth-test-function (cepl-context)) #'<)

(defpipeline-g some-pipeline ()
  (some-vert-stage g-pnt)
  (some-frag-stage :vec3 :vec3))

(defun world-to-view-space (camera)
  (m4:*
   (m4:translation (v3:negate (pos camera)))
   (q:to-mat4 (q:inverse (rot camera)))))

(defun get-model-to-world-space (thing)
  (m4:* (m4:translation (pos thing))
        (q:to-mat4 (rot thing))))

(defun now ()
  (/ (float (get-internal-real-time))
     1000))



(defvar *things*
  (loop for i below 40 collect
                       (make-instance 'thing)))

(defun update-thing (thing)
  (with-slots (pos) thing
    (setf (y pos) (mod (- (y pos) 0.1) 40))))



(defun draw ()
  (step-host)
  (clear)
  (setf (resolution (current-viewport))
        (surface-resolution (current-surface (cepl-context))))


  (loop for thing in *things* do
    (update-thing thing)
    (map-g #'some-pipeline *buf-stream*
           :light-pos *light-pos*
           :now (now)
           :model->world (get-model-to-world-space thing)
           :world->view (world-to-view-space *camera*)
           :view->clip
           (let ((res (resolution (current-viewport))))
             (rtg-math.projection:perspective (x res) (y res) 0.1 30f0 60f0))))
  (swap))

(defun init ()
  ;; (setf *viewport* (make-viewport '(400 400)))
  (unless *buf-stream*
    (destructuring-bind
        (vert index)
        (nineveh.mesh.data.primitives:cube-gpu-arrays)
      (setf *buf-stream* (make-buffer-stream  vert :index-array index))
      (setf *gpu-arr* (first (buffer-stream-gpu-arrays *buf-stream*)))))
  (loop for thing in *things* do (setf (pos thing) (v3:+ (v! 0 0 -25)
                                                         (v! (random 20)
                                                             (random 20)
                                                             (random 20)))))

  (loop for thing in *things* do (setf (rot thing) (q:from-fixed-angles-v3
                                                    (v3:+ (v! (- (random 20f0) 10)
                                                              (random 20)
                                                              (- (random 20f0) 10))))))
  (setf (pos *camera*) (v! 10 10 -4)))


(define-simple-main-loop play (:on-start #'init)
    (draw))
