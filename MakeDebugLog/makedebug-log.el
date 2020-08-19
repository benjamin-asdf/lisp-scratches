











(team/setup-dev-scratch)





(find-file (concat (file-name-as-directory cos-dir) (car files-to-check)))

(with-sample-file
 (while (re-search-forward
         "\\([[:blank:]]+?Debug.\\(Log\\)(.+?);\\) // disable BEST033"
         nil t)
   (goto-char (point-at-bol))
   (re-search-forward "Debug\." (point-at-eol))
   (forward-char 3)
   (insert "Warning")
   (skip-chars-forward "^;" (point-at-eol))
   (forward-char 1)
   (kill-line)))










(with-file)










(--map

 (team/with-file
  (concat (file-name-as-directory cos-dir) it)
  (while (re-search-forward
          "\\([[:blank:]]+?Debug.\\(Log\\)(.+?);\\) // disable BEST033"
          nil t)
    (goto-char (point-at-bol))
    (re-search-forward "Debug\." (point-at-eol))
    (forward-char 3)
    (insert "Warning")
    (skip-chars-forward "^;" (point-at-eol))
    (forward-char 1)
    (kill-line))
  )

files-to-check
 )
