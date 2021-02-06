




(with-eval-after-load 'helm
  (defvar helm-benj-roslyn-analzyers-source
    (helm-build-sync-source
        "Analzyer"
      :candidates )))

(helm-build-async-source )

(defun teamel/all-components ()

  )


(defvar teamel/all-comps nil)

(with-current-buffer-window
    "out"
    nil
    nil
  (let ((default-directory idlegame-project-root))
    (process-file-shell-command
     "global --result=grep --other --reference \"Component\" | rg \"public class\""
     nil t nil))
  (->gg)
  (forward-line 4)
  (delete-region (point-at-bol) (point-max)))


(defconst team-electric/helm-all-comps-cache nil)
(defun team-electric/helm-all-comps-init ()
  (with-current-buffer
      (helm-candidate-buffer 'global)
    (if (and team-electric/helm-all-comps-cache
             (file-exists-p team-electric/helm-all-comps-cache))
        (insert-file-contents-literally team-electric/helm-all-comps-cache)
      (setq team-electric/helm-all-comps-cache (make-temp-file "team-helm-all-comps-cache"))
      (let ((default-directory idlegame-project-root))
        (dolist (elm '("Component"
                       "PrimaryIndexComponent"
                       "IndexComponent"
                       "UniqueComponent"
                       "UniqueFlagComponent"))
          (process-file-shell-command
           (format "global --result=grep --other --reference \"%s\" | rg \"public class\"" elm)
           nil t nil))
        (write-region (buffer-string) nil team-electric/helm-all-comps-cache)))))

(defun team-electric/helm-all-comps-init ()
  (with-current-buffer
      (helm-candidate-buffer 'global)
    (let ((default-directory idlegame-project-root))
      (process-file-shell-command
       "global --result=grep --other --reference \"Component\" | rg \"public class\""
       nil t nil))))

(defun team-electric/do-comp-helm (&optional arg)
  "Start helm with all idlegame comps.
With optional prefix arg, invalidate comp cache.
This relies on up to date gtags."
  (when (and arg team-electric/helm-all-comps-cache)
    (delete-file team-electric/helm-all-comps-cache))
  (let ((helm-ag--default-directory idlegame-project-root))
   (helm :sources team-electric/helm-comps-source)))

(team/with-default-dir
 cos-dir
 (with-temp-buffer
   (insert (team/to-lines-str (magit-changed-files "develop"))))
 )



(with-current-buffer-window
    "rg-out"
    nil
    nil
  (let ((default-directory idlegame-project-root))
      (start-process
       "*rg-comps*"
       (current-buffer)
       "rg"
       "--color=never"
       "--no-heading"
       "public.+?class.+?Component"
       "Assets/#/Sources"
       )
   ))

(defun team-electric/helm-all-comps-init ()
  (with-current-buffer
      (helm-candidate-buffer 'global)
    (let ((default-directory idlegame-project-root))
      (start-process
       "*rg-comps*"
       (current-buffer)
       "rg"
       "--color=never"
       "--no-heading"
       "public.+?class.+?Component"
       "Assets/#/Sources"
       ))))

(defvar team-electric/helm-comps-source nil)
(progn
  (setq team-electric/helm-comps-source
       (helm-build-in-buffer-source
           "idlegame comps"
         :init 'team-electric/helm-all-comps-init
         ;; :real-to-display #'(lambda (candidate)
         ;;                      (with-temp-buffer
         ;;                        (insert candidate)
         ;;                        (->gg)
         ;;                        ;; (when (re-search-forward ".*class[[:blank:]]+\\(\\w+\\).+?:[[:blank:]]+\\(\\(?:\\w+\\)?Component\\).*" nil t)
         ;;                        ;;   (replace-match "\\1 : \\2"))
         ;;                        (buffer-string)))
         ;; :fuzzy-match t
         :action team-electric/helm-comp-actions
         ;; :keymap helm-ag-map
         :follow (and helm-follow-mode-persistent)
         ))
  t)

(setq example "Assets/#/Scripts/Artifacts/ArtifactComponents.cs:43:public class ForgeArtifactAnimRewardId  : Component<ulong> { }")
(with-temp-buffer
  (insert example)
  (->gg)
  (when (re-search-forward ".*class.+?\\(\\w+\\).+?[:blank:]+\\(\\(?:\\w+\\)?Component\\).*" nil t)
    (replace-match "\\1 : \\2" t nil))
  (buffer-string))


(defvar team-electric/helm-comp-actions '())
(setq team-electric/helm-comp-actions
  (helm-make-actions
   "Catch comp" #'(lambda (candidate)
                    (with-temp-buffer
                      (insert candidate)
                      (team/catch-comp-on-line)))

      "Open file"              #'helm-ag--action-find-file
      "Open file other window" #'helm-ag--action-find-file-other-window
      ;; "Save results in buffer" #'helm-ag--action-save-buffer
      )
  )



(progn
  ;; (setq my/buffer-source nil)
  (setq my/buffer-source
   (helm-build-in-buffer-source
       "my buffer source"
     :init #'(lambda ()
               (with-current-buffer
                   (helm-candidate-buffer 'global)
                 (insert (team/to-lines-str (list "fa" "fu" "fem")))))
     :real-to-display #'(lambda (candidate)
                          (format "%s%s" (propertize candidate 'face 'helm-moccur-buffer)
                                  candidate))
     :fuzzy-match t
     :candidate-number-limit 9999
     :action #'my/helm--actions

     )
   )
  t)

(defvar my/helm--actions
  (helm-make-actions
   "Catch comp" #'(lambda (candidate) (print (format "this be the candidate: %s" candidate)))

   )
  )


(helm :sources my/buffer-source)
