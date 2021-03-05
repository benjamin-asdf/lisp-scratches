;;;; my-proj.lisp

(in-package #:my-proj)


(defvar *buf-stream* nil)
(defvar *gpu-arr* nil)
(defvar *viewport* nil)

(defclass camera ()
  ((pos :initform (v! 0 0 0)  :accessor pos)
   (rot :initform (q:identity) :accessor rot)))

(defvar *camera* (make-instance 'camera))

(defun-g some-vert-stage ((vert g-pnt)
                          &uniform (now :float)
                          (world->view :mat4)
                          (view->clip :mat4))
  (let* ((pos (pos vert))
         (now (+ now gl-instance-id))
         (color (+ pos (v! 0.5 0.5 0.5)))

         ;;  position the vertex
         (pos (+ pos (v! (* (sin now) 2)
                         (* (cos now) 1)
                         (+ -6 (sin (* 5 now))))))
         (pos (v! pos 1))
         ;; world space to view space
         (pos (* world->view pos)))
    (values
     ;; view space to clip space
     (* view->clip pos)
     (:smooth color))))

(defun-g some-frag-stage ((color :vec3))
  color)

(setf (depth-test-function (cepl-context)) nil)
(setf (depth-test-function (cepl-context)) #'<)

(defpipeline-g some-pipeline ()
  (some-vert-stage g-pnt)
  (some-frag-stage :vec3))

(defun world-to-view-space (camera)
  (m4:*
   (m4:translation (v3:negate (pos camera)))
   (q:to-mat4 (q:inverse (rot camera)))))

(defun now ()
  (/ (float (get-internal-real-time))
     500))

(defun draw ()
  (step-host)
  (clear)
  (setf (resolution (current-viewport))
        (surface-resolution (current-surface (cepl-context))))

  (with-instances
      10
    (map-g #'some-pipeline *buf-stream*
           :now (now)
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
      (setf *gpu-arr* (first (buffer-stream-gpu-arrays *buf-stream*))))))


(define-simple-main-loop play (:on-start #'init)
    (draw))

