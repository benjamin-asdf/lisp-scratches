










(team/setup-dev-scratch)


(team/with-file
 "example.cs"

 (let ((markers
        (mapcar (// (e)
                    (line-> e)
                    (goto-char (point-at-eol))
                    (point-marker))
                '(1 2))))


   (line->$ 1)
   (insert (make-string ?\n 10))

   (goto-char (cadr markers))


   (insert (concat "  " "what used to be the second line"))


   ))
