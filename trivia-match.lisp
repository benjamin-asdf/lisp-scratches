


(ql:quickload "trivia")

(use-package :trivia)



(match '(1 2 3)
  ((cons x y)
   (print x)
   (print y)))


(match '(something #(0 1 2))
  ((list a (vector 0 _ b))
   (values a b)))



(match '(1 2 . 3)
  ((list* _ _ x)
   x))


(match "banana"
  ((string "banan" x)
   x)
  )

(match "banana"
  ((string* _ _ _ x)
   x))



(match '(1 2)
  ((list _ b _) (print b))
  ((list a _) (print a)))



(defstruct foo bar baz)
(defvar *x* (make-foo :bar 0 :baz 1))

(with-slots ((a baz))
    *x*
  a)

(match *x*
  ;; make-instance style
  ((foo :bar a :baz b)
   (values a b)))
