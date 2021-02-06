


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

(defun team-electric/do-comp-helm (&optional arg)
  "Start helm with all idlegame comps.
With optional prefix arg, invalidate comp cache.
This relies on up to date gtags."
  (when (and arg team-electric/helm-all-comps-cache)
    (delete-file team-electric/helm-all-comps-cache))
  (let ((helm-ag--default-directory idlegame-project-root))
    (helm :sources team-electric/helm-comps-source)))



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

(defvar team-electric/helm-comps-source nil)
(progn
  (setq team-electric/helm-comps-source
        (helm-build-in-buffer-source
            "idlegame comps"
          :init 'team-electric/helm-all-comps-init
          :real-to-display #'(lambda (candidate)
                               (with-temp-buffer
                                 (insert candidate)
                                 (->gg)
                                 (when (re-search-forward ".*class[[:blank:]]+\\(\\w+\\).+?:[[:blank:]]+\\(\\(?:\\w+\\)?Component\\).*" nil t)
                                   (replace-match "\\1 : \\2"))
                                 (buffer-string)))
          :fuzzy-match t
          :action team-electric/helm-comp-actions
          ;; :keymap helm-ag-map
          :follow (and helm-follow-mode-persistent)
          ))

  t)




















(team/with-default-dir
 idlegame-project-root
 (with-current-buffer-window
     "out"
     nil
     nil
   (process-file-shell-command
    "global --result=grep --other --reference \"PrimaryIndexComponent\" | rg \"public class\""
    nil t nil)))


(setq example
      "Assets/#/Sources/GameGuide/GameGuideComponents.cs:78:public class DotIndex : PrimaryIndexComponent<DotSource> { }")


(team-electric/helm-comps-real-to-display example)




















;; regenerate few comps..?



;; takes really fucking long
(team/with-default-dir
 idlegame-project-root
 (with-temp-buffer
   (process-file-shell-command
    "fd . -tf -e cs > gtags.files")
   (process-file-shell-command
    "gtags -v --gtagslabel pygments ./")
   ))
