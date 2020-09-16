














(defun teamel/open-rider-dwm ()
  "Open some rider sln."
  (interactive)
  (let ((sln
         (--first
          (string-match-p "sln$" (funcall it))
          (list #'teamel/last-yank
                #'(lambda ()
                    (benj-dotnet--read-near-proj nil nil))))))
    (unless sln (user-error "failed to get a sln"))
    (shell-command "rider %s" sln)))






















(helm
 e123 gh
 )



(helm-build-in-buffer-source
    "this-buff-source"
  :init


    )

(defun ->gg ()
  (goto-char (point-min)))

(defun teamel/feature-sys-place-candidates ()
  (let ((res))
    (save-excursion
      (->gg)
      (team/while-reg
       "public class \\w+ : Feature"
       (skip-chars-forward "}")
       (push (point) res)))
    res))

(defun teamel/feature-sys-select-place ()
  (interactive)
  (let ((iter
         (helm-iter-circular (teamel/feature-sys-place-candidates)))
        it)
    (catch 'done
      (catch 'done
        (while t
          (goto-char (setq it (funcall iter)))
          (forward-line -1)
          (when
              (momentary-string-display
               (with-temp-buffer
                 (yas-minor-mode)
                 (yas-expand-snippet
                  (yas-lookup-snippet
                   "feature-sys"
                   'csharp-mode)
                  nil
                  nil
                  '((sys-name "SystemName")
                    (contexts "contexts")))
                 (put-text-property
                  (point-min)
                  (point-max)
                  'face
                  'whitespace-line)
                 (buffer-string))
               (point)
               nil
               "Type spc to select this position")
            (throw 'done "hehe")))))))



(setq best (read-key))
(single-key-description "j")
(eq (read-key) ?j)

(eq ?j (momentary-string-display
  (with-temp-buffer
    (yas-minor-mode)
    (yas-expand-snippet
     (yas-lookup-snippet
      "feature-sys"
      'csharp-mode)
     nil
     nil
     '((sys-name "SystemName")
       (contexts "contexts")))
    (put-text-property
     (point-min)
     (point-max)
     'face
     'whitespace-line)
    (buffer-string))
  (point)))

(MarketRenderViewSystem)

(teamel/last-yank)
(yank)
(font-lock--add-text-property )


(defvar hehe nil)
(defun take-test ()
  (interactive)
  (setq hehe (thing-at-point 'evil-word)))
