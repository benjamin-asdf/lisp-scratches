



(loop for x in '(1 2 3)
      do (print x))



(loop for x in '(1 2 3)
      collect (* x 10))




(ql:quickload :iterate)
(use-package :iterate)



(display-iterate-clauses '(for))




(ql:quickload :for)

(for:for ((x over '(1 2 3 4)))

         (print x))


(mapcar (lambda (it) (+ it 10)) '(1 2 3))


(map 'vector (lambda (it) (+ it 10)) '(1 2 3))

(vectorp #(1 2 3))

(map 'string (lambda (it) (code-char it)) '#(97 98 99))

;; (map 'string #'identity '("af" "bb" "c"))
;; => needs a character

(loop for i in '(1 2 3)
      when (> i 1)
        return i)




(dotimes (n 10)
  (print n))

(dotimes (i 10)
  (if (> i 3)
      (return i)
      (print i)))

(loop repeat 10
      do (format t "Hello!~%"))

(loop repeat 10 collect (random 10))


(iterate ((n (scan-range :below 10)))
  (print n))

(iterate )

(defmacro m (&body body)
  `(print .,body))

(defmacro m (&body body)
  `(print ,@body))

(m '("hi" "ff"))
