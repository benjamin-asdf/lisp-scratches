




























(defun fun (&key (ham ham-provided))
  (print (list ham ham-provided)))

(fun :ham "foo")
