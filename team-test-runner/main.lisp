(require 'asdf)

(defun main (&rest args)
  (print args)
  (print (uiop:command-line-arguments))
  (print sb-ext:*posix-argv*))
