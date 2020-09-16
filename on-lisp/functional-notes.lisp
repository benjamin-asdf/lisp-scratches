
;; (proclaim  '(optimize speed))
;; no work is done after the recursive function call
;; this is tail recursive
(defun best-lenght (lst-in)
  (labels ((cnt (lst acc)
                (if (null lst)
                    acc
                  (cnt (cdr lst) (+ 1 acc)))))
    (cnt lst-in 0)))

(best-lenght '(1 2))

(defun good-rev (lst)
  (labels ((rev (lst acc)
                (if (null lst)
                    acc
                  (rev
                   (cdr lst)
                   `(,(car lst) ,@acc)))))
    (rev lst '())))

(defun good-rev-simle (lst)
  (labels ((rev (lst acc)
                (if (null lst)
                    acc
                  (rev (cdr lst)
                       ;; cuz acc is nil in the first iteration it becomes a well formed list
                       (cons (car lst) acc)))))
    (rev lst '())))

(good-rev '(1 2 3))
(good-rev-simle '(1 2 3))
(cons 3 (cons 2 (cons 1 nil)))
(cons 3 (list 2 1))
(list 3 (list 2 1))































;; treat these as if there is a tax on them
'(set  setq setf psetf psetq incf defc push pop pushnew rplaca rplacd rotatef shiftf remf remprop remhash)








(remprop )

(multiple-value-bind (elm rst) (truncate 1.23444 )
  (print (list elm rst)))


(defun fun (x)
  (list 'a (expt (car x) 1)))




(nconc)


(defun exclaim (expression)
  (append expression '(oh my)))
(nconc (exclaim '(lions tigers and eagles))  '(goodness))
(exclaim '(he hu))


(defun exclaim (expression)
  (append expression (list 'oh 'my)))




(defmacro till (test &body body)
  `(do ()
      (,test)
    ,@body))

(let ((x 0))
  (till (> (setq x (1+ x)) 3)
    (print x)))













;; utilities









(setq towns )

(defun bookshops (town)
  (member town '("second" "third") :test 'equalp))

(bookshops "second")

(let ((towns '("first"  "second" "third")))
  (let ((town (find-if #'bookshops towns)))
   (values town (bookshops town))))

(defun firsts (fn list)
  (labels ((firsts (fn curr &rest rest)
             (print curr)
             (let ((val (funcall fn curr)))
               (if val
                   (values curr val)
                   (unless (null rest)
                     (firsts fn (car rest) (cdr rest)))))))

    (firsts fn (car list) (cdr list))))

(let ((towns '("first"  "second" "third")))
  (firsts #'bookshops towns))

(defun firsts (fn hi)
  (labels ((firsts (fn curr &rest rest)
             (print curr)
            (if (funcall fn curr)
                (progn (print curr) curr)
                (when (not (null rest))
                  (firsts fn (car rest) (cdr rest))))))
   (firsts fn hi)))


(defun firsts (fn list)
  (if (null list)
      nil
      (let ((val (find-if fn list)))
        (if val
            (values val ))

        )
      )
  )

(defun firsts (fn list)
  (if (null list)
      nil
      (let ((val (funcall fn (car list))))
        (if val
            (values val (car list))
            (firsts fn (cdr list))))))


(let ((towns '("first"  "second" "third")))
  (firsts #'bookshops towns))
