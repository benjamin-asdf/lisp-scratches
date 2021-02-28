















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






;; never destructivly change &rest parms, they are shared somewhere in the program

;; ,@ is equivalent to append rather than an nconc (so save)




;;  leave alone all list args to macros

(defmacro crazy (expr) (nconc expr (list t)))

(defun foo () (crazy (list)))



;; recursion

(nth 2 '(0 1 2 3))

(defmacro wrong-nth )


;;  this doesn't compile because it recurses infinitej
(defmacro my-nth (n lst)
  (let ((n-var (gensym))
        (list-var (gensym)))
    `(let ((,n-var ,n))
       (if (= ,n-var 0)
           (car ,list-var)
           (my-nth (- ,n-var 1) (cdr ,list-var))))))

(my-nth 2 '(0 1 2 3))

;; you can use that iterative version
;; use a combination of macro of func, can use labels


(defmacro ora (&reset args)
  (or-expand (args)))

(defun or-expand (args)
  (if (null args)
      nil
      (let ((sym (gensym)))
        `(let ((,sym ,(car args)))
           (if ,sym
               ,sym
               ,(or-expand (cdr args)))))))

;; classic macros

;; create context

(defmacro our-let (binds &body body)
  `((lambda ,(mapcar #'(lambda (x)
                       (if (consp x) (car x) x))
              binds)
      ,@body)
    ,@(mapcar #'(lambda (x)
                  (if (consp x) (cadr x) nil))
              binds)))


(mapcar (lambda (x) (if (consp x) (car x) x)) '(1 2))

(defmacro with-gensyms (syms &body body)
  `(let ,(mapcar #'(lambda (s) `(,s (gensym))) syms)
     ,@body))

(defmacro foo (&body body)
  (with-gensyms (ab ba)
    (print (list ab 'foo))))

(foo )


(defun test (&rest args)
  (print (apply #'+ args)))

(defun hello ()
  (test 1 2 3))
