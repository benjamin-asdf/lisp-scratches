(defmacro team/setup-dev-scratch ()

  (defmacro in-here (&rest body)
    (declare (debug body))
    `(let ((default-directory ,(file-name-directory buffer-file-name)))
       ,@body))

  (defmacro with-sample-file (&rest body)
    `(team/with-file
      "example"
      ,@body))


  `(prog
    (defun diff-with-back ()
      (interactive)
      (in-here
       (ediff-files "example-bak" "example")))

    (defun restore-backup ()
      (interactive)
      (in-here
       (copy-file "example-bak" "example" t)))

    (spacemacs/set-leader-keys "otr" 'restore-backup)
    (spacemacs/set-leader-keys "otd" 'diff-with-back)

    (defun ii () (insert "|")))

  (in-here (write-region "" nil "example-bak")))


(defconst team/lisp-scratches-dir "~/repos/lisp/scratches/")
(defun team/new-lisp-scratch (name)
  "Create a scratch in "
  (interactive "sName for new lisp scratch: ")
  (let ((dir (concat team/lisp-scratches-dir name)))
    (unless (file-exists-p dir))
    (make-directory dir)
    (find-file (concat team/lisp-scratches-dir (file-name-as-directory name) name ".el")))
  ;; insert a snippet

  ;; pop the buffers
  (delete-other-windows)

  (split-window-right-and-focus)
  (find-file "example-bak")
  (save-buffer)
  ;; (window--resize-this-window )
  (read-only-mode)
  (split-window-below-and-focus)
  ;; this should not be .cs I want to customize that
  (find-file "example")
  (save-buffer)
  (read-only-mode)

  )
