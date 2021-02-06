;;;; my-proj.lisp

(in-package #:my-proj)


(with-gpu-array-as-c-array )

(with-gpu-array-as-c-array (foo garr)
  (aref-c foo 1))

;;  gl data
;;uffers, -> handle them with gpu arrs
;; textures -> data structure holding images, another flavor of gpu arr

;; buffers <- buffer stream
;; textures <- sampler

;;  -> pipeline -> fbo



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
