

(let*  ((it 0)
        (cnt #'(lambda () (+ 1 it))))
  (print (cnt)))

(let ((cnt #'(lambda () 10)))
  (print (funcall cnt))
  )


(defun hi ()
    (let*  ((it 0)
         (cnt #'(lambda () (setq it (+ 1 it)))))
   (loop while (< (funcall cnt) 8)
         do (print (funcall cnt)))))

()
