

(defconstant handle-dir "/tmp/team-cmds-handles/")
(defconstant team/cmds-collect-tests "Assets/Editor/TeamCommands/team-get-tests")

(require 'asdf)



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



(defun main (&rest args)
  "Use rg to collect all test names in FILE, which should be the first and only argument.
Expect the current directory to be the IdleGame project root.
FILE: path to a test file relative to the IdleGame project root."
  (setq args (or args (uiop:command-line-arguments)))
  (unwind-protect
       (let ((out-file  (team/temp-path-name "tests-out"))
             (report-file (team/temp-path-name "tests-report")))
         (for it in '(out-file report-file)
              (when (uiop/filesystem:file-exists-p it)
                (delete-file it)))
         (team-cmds/create
          "IdleGame"
          "refresh-and"
          "run-tests"
          "-o"
          out-file
          (multiple-value-bind
                (tests errc)
              (team/program-output
               team/cmds-collect-tests
               (car args))
            (when (> errc 0)
              (error "Error getting tests from file ~S" (car args)))
            (format t "Running ~D tests..~%"  (count #\lf tests))
            tests))
         (unless
             (catch 'done
               (team/when-file-last-line
                   out-file
                   "FINISHED"
                   (* 60 2)
                 (write (team/file-string out-file))
                 (throw 'done t)))
           (write-line "Timed out waiting for test results"))
         (quit :recklessly-p t))
    (quit :recklessly-p t :unix-status 1)))
