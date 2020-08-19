














(progn (re-search-forward "File=\"\\(.+?\\)\".+?Line=\"\\([0-9]+\\)\"")
       (message (match-string-no-properties 2))
       )


(setq reg "File=\"\\(.+?\\)\".+?Line=\"\\([0-9]+\\)\"")

<Issue TypeId="ConstantNullCoalescingCondition" File="Assets/#/Sources/Currency/CurrencyExtensions.cs" Offset="77301-77333" Line="1706" Message="'??' left operand is never null"/>

(string-match-p "\\w+"  "hhe/ff")



(defun jump ()
  (interactive)
  (when
      (let ((file)
            (line))
        (save-excursion
          (goto-char (point-at-bol))
          (re-search-forward reg (point-at-eol) t 1))
        (setq file (concat idlegame-project-root (match-string-no-properties 1)))
        (setq line (string-to-number (match-string-no-properties 2)))
        (find-file file)
        (goto-char (point-min))
        (forward-line (- line 1)))))


;; TODO introduce a jumper alist
;; it should also be able to be a function that sets the match data
;; and returns non nil
;; else it is a regex and numbers for file,line,coll



(defvar team-jumpers-alist
  nil
  "Add to this list like (MATCHER . MATCH-GROUP1 2 3)
matcher is a regex on the current line. Groups are the match groups that yield file, line and coll.
Nil ommitts them.
matcher

"


  ("")

  )


(kill-new idlegame-sln-path)










(defun benj-jump (reg &rest jump-matches)
  "Search line with REG JUMP-MATCHES should have the length 3.
This is the match data to use for file,line and coll to jump.
Nil means don't handle."

  (when (save-excursion
          (goto-char (point-at-bol))
          (re-search-forward reg (point-at-eol) t 1))
    (cl-destructuring-bind
        (file-match line-match coll-match jump-matches)
        (let ((file-name (match-string-no-properties file-match))
              (line-name (match-string-no-properties line-match)))


          )

        )
    )
  )


(defun f (&rest list)


  (bind a b list)
  )



(cl-destructuring-bind (a b) '("sf" "fs")
  (message a))



(cl-destructuring-bind )






(benj-rolsyn-tools/jump-line

 )


(defun test()
  (interactive)
  (re-search-forward "Offset=\\(\"\\[[0-9]+-\\)" nil))



(defun jump ()
  (interactive)
  (and (re-search-forward "Line=\"\\([0-9]+\\)\"" (point-at-eol) t)
       (find-file (match-string-no-properties 1))
       (goto-char (point-min))
       (forward-line (string-to-number (match-string-no-properties 1)))

       )

  )



;;



(assoc-default 'jj '((jjl . "ff")))


(defvar team/jump-matchers '())


(defun team/add-jump-matcher (regex &rest groups)
  (add-to-list
   'team/jump-matchers
   `(,regex


     ))
  )



(macroexpand `(team/add-jump-matcher "ff" '(ff . 1) '(fa . 2)))
(-clone)
