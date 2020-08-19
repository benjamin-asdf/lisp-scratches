(eval (team/setup-dev-scratch))



font-lock-defaults



(define-minor-mode test/minor-mode
  "doc"
  :group 'electricity
  (if test/minor-mode
      (font-lock-add-keywords
       'csharp-mode '("\\(Matcher\\)\\.AllOf" (1 'info-single-quote 1))
                              )
    (font-lock-fontify-buffer)
    ))

(defun add-keywords ()
(interactive)
(font-lock-add-keywords
 'csharp-mode '("\\(Matcher\\)\\.AllOf" (1 'info-single-quote t))
 'add))



(font-lock-add-keywords
 'chsarp-mode '("\\(Matcher\\)\\.AllOf" 2 'info-single-quote t)
 'add)
