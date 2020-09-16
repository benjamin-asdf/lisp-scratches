
;; (uiop:temporary-directory)

(defun team/file-created-cb (file cb timeout)
  "Sit until FILE is created and run CB,
timout after TIMEOUT seconds passed."
  (loop :while (> (setq timeout (- timeout 0.20)) 0)
        :do (when (uiop/filesystem:file-exists-p file)
           (funcall cb)
           (return))
         (sleep 0.20)))


(defun team/when-file-created (file timeout &rest body)
  "Sit unitl FILE is created, then eval BODY.
If TIMEOUT seconds pass instead, do not do anything."
  (loop for ms-passed below (* 1000 timeout)
        until (uiop:/f)
        do (when )
        )


  (loop :while (> (setq timeout (- timeout 0.20)) 0)
        :do (when (uiop/filesystem:file-exists-p file)
              ,@body)
            (sleep 0.20)))

(loop repeat 10 do (print "hi"))

(loop for i below 10 by 3
  until (> i 5)
      collect i)





(uiop/filesystem:file-exists-p
 (let ((*default-pathname-defaults* (uiop:temporary-directory)))
   (merge-pathnames (make-pathname :name "best"))
   ))
