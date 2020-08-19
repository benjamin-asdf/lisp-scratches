























(process-filter (magit-run-git-async "status"))


(format "%3s" "u")



(let* ((proc (start-process "name" "*ls-buff*" "du" "-h"))

       ))

(internal-default-process-filter)


;; do you remember the issue I had a while back with passing a list of strings, instead of strings?
;; when using &rest
;; I figured something out (I started getting into macros and backquotes):

(defun f (&rest args)
  (eval `(start-process "name" "*ls-buff*" "ls" ,@args)))
(f "-l" "-a")

(mapconcat 'identity (process-command (get-process "name")) " ")



(defun list-processes--refresh ()
  "Recompute the list of processes for the Process List buffer.
Also, delete any process that is exited or signaled."
  (setq tabulated-list-entries nil)
  (dolist (p (process-list))
    (cond ((memq (process-status p) '(exit signal closed))
	   (delete-process p))
	  ((or (not process-menu-query-only)
	       (process-query-on-exit-flag p))
	   (let* ((buf (process-buffer p))
		  (type (process-type p))
		  (pid  (if (process-id p) (format "%d" (process-id p)) "--"))
		  (name (process-name p))
		  (status (symbol-name (process-status p)))
		  (buf-label (if (buffer-live-p buf)
				 `(,(buffer-name buf)
				   face link
				   help-echo ,(format-message
					       "Visit buffer `%s'"
					       (buffer-name buf))
				   follow-link t
				   process-buffer ,buf
				   action process-menu-visit-buffer)
			       "--"))
		  (tty (or (process-tty-name p) "--"))
		  (thread
                   (cond
                    ((or
                      (null (process-thread p))
                      (not (fboundp 'thread-name))) "--")
                    ((eq (process-thread p) main-thread) "Main")
		    ((thread-name (process-thread p)))
		    (t "--")))
		  (cmd
		   (if (memq type '(network serial))
		       (let ((contact (process-contact p t t)))
			 (if (eq type 'network)
			     (format "(%s %s)"
				     (if (plist-get contact :type)
					 "datagram"
				       "network")
				     (if (plist-get contact :server)
					 (format
                                          "server on %s"
					  (if (plist-get contact :host)
                                              (format "%s:%s"
						      (plist-get contact :host)
                                                      (plist-get
                                                       contact :service))
					    (plist-get contact :local)))
				       (format "connection to %s:%s"
					       (plist-get contact :host)
					       (plist-get contact :service))))
			   (format "(serial port %s%s)"
				   (or (plist-get contact :port) "?")
				   (let ((speed (plist-get contact :speed)))
				     (if speed
					 (format " at %s b/s" speed)
				       "")))))
		     (mapconcat 'identity (-flatten (process-command p)) " "))))
	     (push (list p (vector name pid status buf-label tty thread cmd))
		   tabulated-list-entries)))))
  (tabulated-list-init-header))
