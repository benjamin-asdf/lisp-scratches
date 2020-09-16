

























(defvar omni-data-best)
(defun test-omni ()
  (interactive)
  (omnisharp--cs-inspect-buffer #'(lambda (elements)
                                    (print "hi")
                                    (setq omni-data-best elements))))


(omnisharp--cs-filter-resursively
 #'(lambda (el)
     (-let* (((&alist 'Kind kind
                      'Properties properties) el))
       (print kind)
       nil)
     )
 omni-data-best
 )

(car omni-data-best)

(defvar some-method )
(defun test-omni2 ()
  (interactive)
  (omnisharp--cs-element-stack-at-point
   (lambda (stack)
     (let* ((element-on-point (car (last stack)))
            )
       )
     (setq some-method (car (last stack)))
  )))

(-let* (((&alist 'Kind kind
                 'Proper
                 ))))
