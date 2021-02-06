(defun joiner (obj)
  (typecase obj
    (cons #'append)
    (number #'+)))


(defun join (&rest args)
  (apply (joiner (car args)) args))



(defvar *!equivs* (make-hash-table))

(defun ! (fn)
  (or (gethash fn *!EQUIVS*) fn))

(defun def! (fn fn!)
  (setf (gethash fn *!EQUIVS*) fn!))

;; you couuld define the desctructive counterpart funcs
;; you would make the code more clear







;; keep a cache of return values
(defun memoize (fn)
  (let ((cache (make-hash-table :test #'equal)))
    #'(lambda (&rest args)
        (multiple-value-bind (val win) (gethash args cache)
          (if win
              val
              (setf (gethash args cache)
                    (apply fn args)))))))


(defvar answer '())
(setq
 answer
 (memoize #'(lambda (p)
              (print "expensive work..")
              (print p)
              (sleep 0.2)
              42)))





;; composition

(defun compose (&rest fns)
  (let ((fn1 (car (last fns)))
        (fns (butlast fns)))

    (compose fns)
    )

  )

(reduce  )
