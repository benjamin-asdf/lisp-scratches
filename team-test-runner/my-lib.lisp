
(defpackage my-lib (:use cl)
            (:export "my-lib")
            (:nicknames mypkg)
            (:export "MY-FUN"))


(defun my-fun ()
  (write-line "hello from my lib."))
