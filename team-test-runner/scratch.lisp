(mapcar fn
        (do*  ((x (1+ x))))


        )
%make-simd-pack-256-double


(do* ((x (1+ x))
      (result (list x) (push x result)))
     ((= x 10) (nreverse result))
  )




(do* ((x 3 (1+ x)))
     ((> x 10))
     (print x))


(my/for y 3 10
     (print y))


(defmacro my/for (x a b &body body)
  `(do* ((,x ,a (1+ ,x)))
       ((> ,x ,b))
     ,@body))


(apply #'+ 1 '(2))

(mapcar
 #'+
 '(3 5 3)
 '(10 200)
 )



(< 3 20 0)
(apply #'< (sort '(3 20 4 10) #'<))

(setf (get 'dog 'behaviour)
      #'(lambda ()
          (print "dog behaviour")))
(funcall (get 'dog 'behaviour))


























(defvar x 10)
(defvar y 20)

(defun foo ()
  (+ x y))

(defun bar  (x y)
  (+ (foo) x y))

(foo)
(bar 2 3)
