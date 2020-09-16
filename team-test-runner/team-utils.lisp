
(require 'asdf)


;; files

(defmacro team/a-file-lines (file-name &body body)
  "Loop over lines in FILLE-NAME, BODY with anaphoric line."
  `(with-open-file (s ,file-name)
     (loop for line = (read-line s nil)
           while line do ,@body)))

(defun team/file-string (file-name)
  (with-output-to-string (out)
    (team/a-file-lines
        file-name
      (format out "~a~%" line))
    out))

(defun team/write-lines-to-file (file &rest lines)
  (when (and (stringp file)
             (every 'stringp lines))
    (with-open-file
        (s file
           :direction :output
           :if-does-not-exist :create
           :if-exists :supersede)
      (dolist (item lines)
        (write-line item s)))))

(defun team/file-created-cb (file cb timeout)
  "Sit until either FILE is created or TMEOUT is seconds passed,
call CB with a single arg. Non nil signals success, nil signals timout."
  (loop for ms-passed below (* 1000 timeout) by 250
        with it = (uiop/filesystem:file-exists-p file)
        until it
        finally (funcall cb it)))


;; procs

(defun team/program-output (program &rest args)
  "Run PROGRAM with ARGS, first return value is the outputstring, second is the exit code."
  (let ((exit-code))
    (values
     (with-output-to-string (s)
       (setf exit-code
             (process-exit-code
              (run-program
               program
               args
               :output s)))
       s)
     exit-code)))
