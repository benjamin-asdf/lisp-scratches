(format nil "foo")

;; to std out
(format t "foo")

(format t "~a" 10)

(format nil "~a" '(:a ham foo 10))

(format nil "hello=~{~a~}" '(:a ham foo 10))

(format nil "hello=~{~a, ~}" '(:a ham foo 10))

(format nil "hello=~{~a~^, ~}" '(:a ham foo 10))



;; aesthetic and standard
;; print and prin1
(format nil "test

(format nil "test=~s" :foo)

(format nil "test=~s" "foo")

(format nil "test=~a" "foo")



;; conditionsal
(format nil "test~@[=~a~]" "foo")
(format nil "test~@[=~a~]" nil)


