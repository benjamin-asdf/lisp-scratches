(defconstant handle-dir "/tmp/team-cmds-handles/")
(defconstant team/cmds-collect-tests "Assets/Editor/TeamCommands/team-get-tests")

(require 'asdf)


(defmacro team/when-file-last-line (file-name line-string timeout &body body)
  "Sit until the file FILE-NAME has the last line LINE-STRING,
then execute BODY. TIMEOUT is the timeout in seconds"
  (let ((secs-var (gensym)))
    `(let ((,secs-var ,timeout))
       (loop while (> (setq ,secs-var (- ,secs-var 0.2)) 0)
             do (when (uiop/filesystem:file-exists-p ,file-name)
                  (let ((last))
                    (team/a-file-lines
                        ,file-name
                      (setf last line))
                    (if
                     (string-equal last ,line-string)
                     (progn
                       ,@body
                       (return)))))
                (sleep 0.2)))))


(defun team-cmds/create (project cmd &rest args)
  "Create a team-cmd handle file.
PROJECT is the project name of the unity to act upon.
CMD is one of the defined team cmds, see `TeamCommandExecutor.cs'.
ARGS are optional string arguments to the cmd."
  (apply
   #'team/write-lines-to-file
   `(,(concatenate 'string handle-dir project)
    ,cmd
    ,@args)))



(defun main (&optional args)
  "Use rg to collect all test names in FILE, wich should be the first and only argument.
Expect the current directory to be the IdleGame project root.
FILE: path to a test file relative to the IdleGame project root."
  (let ((out-file "/tmp/team-unity-tests-out"))
    (when (uiop/filesystem:file-exists-p out-file)
      (delete-file out-file))
    (team-cmds/create
    "IdleGame"
    "refresh-and"
    "run-tests"
    "-o"
    out-file
    (multiple-value-bind
          (tests errc)
        (team/program-to-string
         team/cmds-collect-tests
         (car args))
      (when (> errc 0)
        (error "Error getting tests from file ~A" (car args)))
      (format t "Running ~D tests..~%"  (count #\lf tests))
      ;; (print (list tests errc))
      ))))
    ;; (unless
    ;;     (catch 'done
    ;;       (team/when-file-last-line
    ;;           out-file
    ;;           "FINISHED"
    ;;           (* 60 2)
    ;;         (write (team/file-string out-file))
    ;;         (throw 'done t)))
    ;;   (write-line "Timed out waiting for test results"))
