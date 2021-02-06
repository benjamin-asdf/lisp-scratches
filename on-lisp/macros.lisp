















(defmacro !nil (symbol &rest symbols)
  (when symbol
    `(progn (setq ,symbol nil))
    (!nil (cdr symbols))))

(defmacro !nil (symb)
  `(setq ,symb nil))


(defmacro !nil (var)
  (list 'setq var nil))

(let ((x 10))
  (!nil x)
  x)


`(a b c)

(let ((b 10))
  `(a (,b c)))

(defvar a)
(defvar b)
(defvar c)
(defun b (a) "foo")
(setq a 1 b 2 c 3)
`(,a ,(b `,c))


(let ((b '(1 2 3)))
  `(,@b)
  ;; `,@b => this is not a well formed backquote expression
  )

(let ((b '(1 2 3)))
  `(1 ,@3))

(let ((b '(1 2 3)))
  `(1 ,@3 0))


(defmacro memq (elm list)
  `(member ,elm ,list :test #'eq))

(memq 1 '(1 2 3))
(memq "foo" '("foo"))
(member "foo" '("foo") :test #'equal)



(defmacro while (test &body rest)
  )


(defmacro when-bind ((var expr) &body body)
  `(let ((,var ,expr))
     (when ,var
       ,@body)))

(when-bind (x "foo") (print x))




(defmacro our-expander (name) `(get ,name 'expander))


(defmacro our-defmacro (name parms &body body)
  (let ((g (gensym)))
    `(progn
       (setf (our-expander ',name)
             #'(lambda (,g)
                 (block ,name
                   (destructuring-bind ,parms (cdr ,g)
                     ,@body))))
       ',name)))


(defun our-macroexpand-1 (expr)
  (if (and (consp expr) (our-expander (car expr)))
      (funcall (our-expander (car expr)) expr)
      expr))


(our-defmacro foo-macro (arg1)
  `(print ,arg1))

(our-macroexpand-1 '(foo-macro ("hi")))

(do ((w 3 (+ 1 w))
     (x 0))
    ((> w 10)
     (print w)))

(let ((x))
  (tagbody
     (setq x 0)
   0 (unless (< x 5)
       end)

     ))



(defmacro our-do (bindforms (test &rest result) &body body)
  (let ((label (gensym)))
    `(prog ,(make-initforms bindforms)
        ,label
        (if ,test
            (return (progn ,@result)))
        ,@body
        (psetq ,@(make-stepforms bindforms))
        (go ,label))))


(defun make-initforms (bindforms)
  (mapcar #'(lambda (b)
              (if (consp b)
                  (list (car b) (cadr b))
                  (list b nil)))
          bindforms))

(defun make-stepforms (bindforms)
  (mapcan
   #'(lambda (b)
       (if (and (consp b) (third b))
           (list (car b) (third b))
           nil))
   bindforms))


(mapcan #'(lambda (b) (list 10 b)) '(1 2 3))
(mapcar #'(lambda (b) (list 10 b)) '(1 2 3))

(nconc '(1 2) '(3))
(cons '(1 2) '(3))

(make-stepforms '((x 10 (1+ x))))






;;  macro code: style over speed
;;  exapnded macro: speed over style





;;  symbol macrocs



(symbol-macrolet ((hi (progn (print "howdy") 1)))
  (+ hi 2))



;; when to use macros


;;  default: functions

;;  transformation like setf

;; binding
















