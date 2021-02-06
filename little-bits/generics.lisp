


(defun s-repeat (s times)
  (with-output-to-string (o)
    (dotimes (x times)
        (format o "~a" s))))

(defgeneric foo (ham))

(defmethod foo ((ham number))
  (* 10 ham))


(defmethod foo ((ham string))
  (s-repeat ham 3))

























(defun ding-dong (left right)
  "Return a lambda that will call LEFT on the first call, RIGHT on the second, then left again and so on."
  (let ((ding))
    (lambda ()
      (funcall
       (if ding
           left
           right)

       ))))
