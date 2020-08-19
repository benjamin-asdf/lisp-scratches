

(when (string-match-p
       "*scratch"
       (buffer-name))
  (benj-backups--file-name (string-trim (buffer-name) "*" "*")))












(keywordp :hello)








(benj-charp-el)

(benj-csharp-electric-string-mode)



(re-search-forward "\\(?:.*\n.*\\)" )


"ff a

 "





(define-minor-mode benj-csharp-electric-string-mode
  "This mode adds chsarp syntax to strings when you put them on multiple lines."
  :group 'electricity
  (if benj-csharp-electric-string-mode
      (progn
	      (add-hook 'post-self-insert-hook
                  #'benj-csharp/electric-string-post-self-insert-function
        )

    )))

(defun benj-csharp/electric-string-post-self-insert-function ()
  ;; (when (and benj-csharp-electric-string-mode)
  ;;   (eq last-command-event ?\n)
  ;;   (let ((after-insert-point (point)))
  ;;     (save-excursion
  ;;       (forward-line -1)
  ;;       ;; (re-search-forward "\"")
  ;;       (when (looking-at-p
  ;;              ;; "\".+\n.+\""
  ;;              ;; "\".+\n.+\""
  ;;              ;; "\\(.+\\)?\""
  ;;              "^.+?\"[^\"]+?\n.+?\""
  ;;              )
  ;;         (message "jo")
  ;;         )
  ;;       ;; (when (re-search-forward
  ;;       ;;        ;; "^.*\".*\n\.*\""
  ;;       ;;        "^.*\".*\n"
  ;;       ;;                          after-insert-point
  ;;       ;;                          t
  ;;       ;;                          1)
  ;;       ;;   (message "hi"))
  ;;       )
  ;;     )
  ;;   )


  )

(benj-csharp-electric-mode )

(looking-at ".*Console.WriteLine();\\(\$?\".*\"\\);$") Console.WriteLine();"sfsdf";
(looking-at ".*Console.WriteLine();") Console.WriteLine();"sfsdf";

(define-minor-mode benj-csharp-electric-mode
  "This mode adds chsarp syntax to strings when you put them on multiple lines."
  :group 'electricity
  (if benj-csharp-electric-mode
      (progn
	      (add-hook 'post-self-insert-hook
                  #'benj-csharp-electric-mode-post-self-insert-function))
    (remove-hook 'post-self-insert-hook
              #'benj-csharp-electric-mode-post-self-insert-function)))

(defun benj-csharp-electric-mode-post-self-insert-function ()
  (when benj-csharp-electric-mode
    (when
        (and
         (looking-back "if\s*\(.*\)\s*{")
         (looking-at "[[:blank:]]?+[^\s;]+;"))
      (let ((indent (current-indentation)))
        (kill-line)
        (open-line 1)
        (forward-line 1)
        (yank)
        (open-line 1)
        (forward-line 1)
        (indent-to-column indent)
        (insert "}")
        ))

    ;; (save-excursion
    ;;   ;; make marker
    ;;   (goto-char (point-at-bol))
    ;;   ;; TODO log methods lookup
    ;;   ;; (when (looking-at "^\\(.*\\)Console.WriteLine();\\(\$?\".*\"\\);$")
    ;;   ;;   (replace-match (format "%sConsole.WriteLine(%s);" (match-string 1) (match-string 2)))))

    ;;   ;;
    ;;   ;; (when ))

  ))

(defface
  idlegame-mode-entitas-matchers-face
  '((t (:foreground "Purple")))
  "Entitas Matchers face"
  :group 'idlegame-mode
  )


(progn (re-search-forward "\\bMatcher\.\\(AllOf\\|AnyOf|NoneOf\\)<\\(.*\\)>()" nil t)
       (message (match-string-no-properties 2)))

Matcher.AllOf<SpecialDealsManagerC>()

(defconst idlegame-mode-font-keywords
  '(("\\bMatcher\.\\(AllOf\\|AnyOf|NoneOf\\)<\\(.*\\)>()" 2 'idlegame-mode-entitas-matchers-face)))




(define-minor-mode idlegame-electric-mode
  "This mode adds chsarp syntax to strings when you put them on multiple lines."
  :group 'electricity
  (if idlegame-electric-mode
      (progn
	      (add-hook 'post-self-insert-hook
                  #'idlegame-electric-mode-post-self-insert-function
                  100
                  )

        (font-lock-add-keywords nil idlegame-mode-font-keywords)
        (if (fboundp 'font-lock-flush)
            (font-lock-flush)
          (when font-lock-mode
            (with-no-warnings (font-lock-fontify-buffer))))


        )
    (remove-hook 'post-self-insert-hook
                 #'idlegame-electric-mode-post-self-insert-function
                 )))

(defun idlegame-electric-mode-post-self-insert-function ()
  (when idlegame-electric-mode
    ;; (when (looking-back ))


    (when (looking-back "Get<\\w+>\(")
      (forward-char 1)
      (insert "value"))))

(defun idlegame-electric-mode-post-self-insert-function ())

(idlegame-electric-mode 1)




(defun benj-csharp-electric-mode-post-self-insert-function ())
