;;;; my-proj.lisp

(in-package #:my-proj)

;;  gl data
;;uffers, -> handle them with gpu arrs
;; textures -> data structure holding images, another flavor of gpu arr

;; buffers <- buffer stream
;; textures <- sampler

;;  -> pipeline -> fbo

(defvar *gpu-verts-arr* nil)
(defvar *gpu-index-arr* nil)
(defvar *vert-stream* nil)
(defvar *viewport* nil)
(defparameter *running* nil)

(defun-g draw-verts-vert-stage ((vert :vec2))
  (v! vert 0 1))

(defun-g draw-verts-frag-stage ()
  (v! 0 1 0.5 0))

(defpipeline-g draw-verts-pipeline ()
  (draw-verts-vert-stage :vec2)
  (draw-verts-frag-stage))

(defun draw ()
  (step-host)
  (update-repl-link)
  (with-viewport *viewport*
    (clear)
    (map-g #'draw-verts-pipeline *vert-stream*)
    (swap)))

(defun init ()
  (when *gpu-verts-arr*
    (free *gpu-verts-arr*))

  (when *gpu-index-arr*
    (free *gpu-index-arr*))

  (setf *viewport*
        (make-viewport '(400 400)))

  ;; (when *vert-stream* ||#
  ;;   (free *vert-stream* )) ||#

  (setf *gpu-verts-arr*
        (make-gpu-array
         (list (v! -0.5 0.5)
               (v! -0.5 -0.5)
               (v! 0.5 -0.5)
               (v! 0.5 0.5))
         :element-type :vec2))

  (setf *gpu-index-arr*
        (make-gpu-array
         (list 0 1 2 0 2 3)
         :element-type :uint))

  (setf *vert-stream*
        (make-buffer-stream *gpu-verts-arr*
                            :index-array *gpu-index-arr*)))


(defun run-loop ()
  (setf *running* t)
  (loop :while (and *running* (not (shutting-down-p))) :do
    (continuable (draw))))
(defun stop-loop ()
  (setf *running* nil))

;; save model files, lib like cons pack, fast dot or sth

;; same gl buffer
;; (make-gpu-arrays ) ||#



;; (defstruct-g pos-col
;;   (position :vec3 :accessor pos)
;;   (color :vec4 :accessor col))

;; (defun-g tri-vert ((vert pos-col))
;;   (values (v! (pos vert) 1.0)
;;           (col vert)))

;; (defun-g tri-frag ((color :vec4))
;;   color)

;; (defpipeline-g prog-1 ()
;;   (tri-vert pos-col)
;;   (tri-frag :vec4))


;; (let ((arr)
;;       (stream))
;;   (defun step-game ()
;;     (when
;;         (cepl.skitter.sdl2:key-down-p
;;          14)

;;       (unless arr
;;         (setf
;;          arr
;;          (make-gpu-array (list (list (v!  0.5 -0.36 0) (v! 0 1 0 1))
;;                                (list (v!    0   0.5 0) (v! 1 0 0 1))
;;                                (list (v! -0.5 -0.36 0) (v! 0 0 1 1)))
;;                          :element-type 'pos-col))
;;         stream (make-buffer-stream arr)))
;;     (when (and arr stream)
;;       (map-g #'prog-1 stream))))

;; (let ((running))
;;   (defun my-proj-run-loop ()
;;     (setf running t)
;;     (loop
;;       :while
;;       running
;;       :do
;;          (continuable
;;            (step-host)
;;            (update-repl-link)
;;            (clear)
;;            (step-game)
;;            (swap))))

;;   (defun my-stop-loop ()
;;     (setf running nil)))
