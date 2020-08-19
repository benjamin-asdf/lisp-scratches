























(defclass handle ()
  ((resource :initarg :resource :initform nil)))


(defun dispoce (obj)
  nil)

(defmethod dispose ((obj handle)))
(cl-defgeneric dispose () )

(cl-defmethod dispose ((this handle))
  (message "disposing %s" (oref this resource)))

(dispose (make-instance 'handle :resource "allo"))





(defun test ()
  (let ((x (make-instance 'handle :resource "allo")))
    (unwind-protect
        (progn (print "lots of work happening")))
    (dispose x)))


(defun gen-using-code (var form body)
  `(let ((,var ,form))
    (unwind-protect
        (progn ,@body))
    (dispose ,var)))


(gen-using-code 'x (make-instance 'handle :resource "allo") '(print "working"))


(defmacro using (var form &rest body)
  `(let ((,var ,form))
     (unwind-protect
         (progn ,@body))
     (dispose ,var)))




(defun test (arg)
  (using x (make-instance 'handle :resource arg)
         (setq x (make-instance 'handle :resource "something else"))
         (print "lots of work happening")))


(test "woo")

(using x (make-instance 'handle :resource "allo")
        1
        2
        (print "lots of work happening"))

(macroexpand `(using x (make-instance 'handle :resource "allo") 1 2 3))



(macroexpand `(using x (make-instance 'handle :resource "allo")
                     1
                     2
                     (print "lots of work happening")))




(defmacro using (var form &rest body)
  (let ((var-name (gensym)))
    `(let* ((,var-name ,form)
            (,var ,form))
       (unwind-protect
           (progn ,@body))
       (dispose ,var-name))))






(defun test (arg)
  (using x (make-instance 'handle :resource arg)
         (setq x (make-instance 'handle :resource "something else"))
         (setq tmp (make-instance 'handle :resource "something  else again"))
         (print "lots of work happening")))































(lambda (x)
  (cl-labels (((this (x &optional accum))
               (if (<= x 0)
                   accum
                 (baz (- x 1) (* (or accum 1) x)))))
    (this x)))





(defun baz (x &optional accum)
  (if (<= x 0)
      accum
    (baz (- x 1) (* (or accum 1) x))))


(rlambda
 (x &optional accum)
 (if (<= x 0)
     accum
   (this (- x 1) (* (or accum 1) x))))



;; my attemp
(defmacro rlambda (arglist &rest body)
  (let ((tmp (gensym)))
    `(let* ((l (lambda ,arglist ,@body))
            (this ,l))
       (funcall #'l))))

;; correct
(defmacro rlambda (args &rest body)
  `(cl-labels
       ((this (,@args) ,@body))
    #'this))



(funcall (lambda (x)
   (cl-labels ((best-name (arg) (message "%d" arg)))
     (funcall #'best-name arg))) 10)

(defun test-best ()
  (funcall (rlambda
            (x &optional accum)
            (if (<= x 0)
                accum
              (this (- x 1) (* (or accum 1) x))))
           4))


(macroexpand '(rlambda
   (x &optional accum)
   (if (<= x 0)
       accum
     (this (- x 1) (* (or accum 1) x)))))



(cl-labels ((this (x &optional accum)
                  (if
                      (<= x 0) accum
                    (this
                     (- x 1)
                     (*
                      (or accum 1)
                      x)))))
  (funcall #'this 4))

(funcall
 4)





(defmacro rm (args &rest body)
  `,@args
  )

(rm 1 2 3)
(m 1)

(defmacro m (args)
  )

(m '(1 23 3))





(symbol-macrolet ((x 10)) (message "%d" x))

(defun test3 (key ht)
  (symbol-macrolet ((x (+ (gethash key ht)))
                    (list x x x))))


(defun test5 (obj)
  (with-slots (resource) obj
    (print resource)
    (setf resource "yay!")
    (print resource))
  obj)

(test5 (make-instance 'handle :resource "best"))














(defun my-add (x y)
  (+ x y))

(defmacro my-add (x y)
  (+ x y))

(my-add a x)

;; (define-compiler-macro )




















(let ((file-name "/tmp/kappa"))
  (set-process-filter (start-process "name" "*my-ls*" "ls" "-a" "-h" )
                      ))


(defmacro build-filter (file-name)
  `(lambda (proc  string) (append-to-file string nil ,file-name)))




(setq my-filter
 (make-local-variable ((file-name "/tmp/kappa3"))
   (build-filter file-name)))

(set-process-filter
 (start-process "name" "*my-ls*" "ls" "-a" "-h")
 my-filter
 )


(advice-add (process-filter
             (start-process "name" "*my-ls*" "ls" "-a" "-h"))
            :after (lambda (&rest res)
                                                                                      (append-to-file (cdr res) nil "/tmp/kappa2" )))
