;;;; my-proj.lisp

(in-package #:my-proj)

;;  gl data
;;uffers, -> handle them with gpu arrs
;; textures -> data structure holding images, another flavor of gpu arr

;; buffers <- buffer stream
;; textures <- sampler

;;  -> pipeline -> fbo

;; make struct with fields
;; ubo uniform buffer object
;; (make-ubo )

(defvar *gpu-verts-arr* nil)
(defvar *gpu-index-arr* nil)
(defvar *vert-stream* nil)
(defvar *viewport* nil)
(defvar *leaf-tex1* nil)
(defvar *leaf-sampler* nil)
(defvar *fbo-tex* nil)
(defvar *fbo* nil)
(defvar *fbo-tex-sampler* nil)
(defparameter *running* nil)

(defstruct-g our-vert
  (pos :vec2)
  (uv :vec2)) ;common name for tex coords|#h

(defun-g draw-verts-vert-stage ((vert our-vert) &uniform (offset :vec2))
  (values
   (v! (+ (our-vert-pos vert) offset) 0 1)
   (our-vert-uv vert)))

(defun-g draw-verts-frag-stage ((uv :vec2)  &uniform (sam :sampler-2d))
  ;; (v! 1 1 1 0)
  (texture sam (* 2 uv))
  )

(defpipeline-g draw-verts-pipeline ()
  (draw-verts-vert-stage our-vert)
  (draw-verts-frag-stage :vec2))

(defun draw ()
  (step-host)
  (update-repl-link)
  (with-viewport *viewport*
    (clear)
    (map-g #'draw-verts-pipeline *vert-stream*
           :offset (v!
                    0 0
                    ;; (sin (get-universal-time)) ||#
                    ;; (sin (get-universal-time)) ||#
                    )
           :sam ;; *leaf-sampler*
           *fbo-tex-sampler*

           )
    (swap)))

;; (defun draw ()
;;   (step-host)
;;   (update-repl-link)

;;   (progn ;; with-viewport *viewport*

;;     (with-fbo-bound (*fbo*)
;;       (clear)
;;       (map-g #'draw-verts-pipeline *vert-stream*
;;              :offset (v!
;;                       0 0
;;                       ;; (sin (get-universal-time)) ||#
;;                       ;; (sin (get-universal-time)) ||#
;;                       )
;;              :sam *leaf-sampler*)
;;       (swap))))

(defun init ()
  (when *gpu-verts-arr*
    (free *gpu-verts-arr*))
  (when *gpu-index-arr*
    (free *gpu-index-arr*))
  (when *leaf-tex1*
    (free *leaf-tex1*))

  (setf *viewport*
        (make-viewport '(400 400)))

  ;; (when *vert-stream* ||#
  ;;   (free *vert-stream* )) ||#

  (setf *leaf-tex1*
        (dirt:load-image-to-texture
         ;; "/home/benj/repos/lisp/scratches/my-proj/assets/kenney-foliage/png/flat/sprite_0021.png"
         "assets/kenney-foliage/png/flat/sprite_0021.png"
         ))

  (setf *leaf-sampler*
        (sample *leaf-tex1*))

  (setf *gpu-verts-arr*
        (make-gpu-array
         (list (list (v! -0.5 0.5) (v! 0 1))
               (list (v! -0.5 -0.5) (v! 0 0))
               (list (v! 0.5 -0.5) (v! 1 0))
               (list (v! 0.5 0.5) (v! 1 1)))
         :element-type 'our-vert))

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


;; (with-viewport *viewport* (make-fbo 0))
;; (setf *fbo* *)
;;  texture based fbo
;; (attachment *fbo* 0)
;; (gpu-array-texture *)
;; (setf *fbo-tex* *)
;; (setf *fbo-tex* (gpu-array-texture (attachment *fbo* 0)))



;; save model files, lib like cons pack, fast dot or sth

;; same gl buffer
;; (make-gpu-arrays ) ||#


;;     (when
;;         (cepl.skitter.sdl2:key-down-p
;;          14)


;; 780 -> 453
;;
