(team/setup-dev-scratch)








(with-sample-file
 (team/while-reg
  "if (!(\\(!.+?\\)))) {"
  (replace-match
   (format "if (%s) {" (match-string-no-properties 1)))
  ))


(team/--each-file
 absolute-files
 (team/while-reg
  "if (!(\\(!.+?\\)))) {"
  (replace-match
   (format "if (%s) {" (match-string-no-properties 1)))
  )
 )


(with-sample-file
 (team/while-reg
  "if (!(false)) {"
  (let ((indent (current-indentation)))
    (goto-char (line-beginning-position))
    (kill-line 1)
    (forward-line)
    (kill-line 1)
    (forward-line -1)
    (indent-line-to indent)
    )))


(team/--each-file
 absolute-files
 (team/while-reg
  "if (!(false)) {"
  (let ((indent (current-indentation)))
    (goto-char (line-beginning-position))
    (kill-line 1)
    (forward-line)
    (kill-line 1)
    (forward-line -1)
    (indent-line-to indent))))



(setq absolute-files (--map (concat (file-name-as-directory cos-dir) it) files-to-check))
