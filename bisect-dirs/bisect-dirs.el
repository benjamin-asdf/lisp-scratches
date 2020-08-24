







(defun team/make-dir-by-dir-commits ()
  (let ((dirs)
        (default-directory cos-dir))
    (with-temp-buffer
      (insert (mapconcat 'identity (magit-changed-files "develop") "\n"))
      (goto-char (point-min))
      (team/while-reg "IdleGame/Assets/#/Sources/\\(\\w+\\)"
                      (pushnew (match-string-no-properties 0) dirs :test 'string-equal)))
    (--map
     (shell-command
      (format "git checkout develop -- %s && git commit -m 'checking %s' " it (concat "dir..  " (subseq it 26))))
     dirs)))
