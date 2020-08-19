




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
    "collect"
    nil
    nil
  (set-process-sentinel
   (start-process
    "collect-comps"
    (current-buffer)
    "global"
    "--result=grep"
    "--other"
    "--reference"
    "Component"
    )
   (// (proc evnt)
       (let ((res))
         (with-current-buffer
             (process-buffer proc)
           (goto-char (point-min))
           (team/while-reg
            ":public[[:blank:]]class[[:blank:]]\\(\\w+\\)"
            (push (match-string-no-properties 1) res)))
         (setq teamel/all-comps res)))))



(let ((res))
  (with-current-buffer
     "collect"
   (goto-char (point-min))
   (team/while-reg
    ":public[[:blank:]]class[[:blank:]]\\(\\w+\\)"
    (push (match-string-no-properties 1) res)))
  res)


(defun teamel/helm-all-comps-init ()
  (with-current-buffer
      (helm-candidate-buffer 'global)
    (let (default-directorly idlegame-project-root)
      (process-file-shell-command
       "global --result=grep --other --reference \"Component\" | rg \"public class\""
       nil t nil
       ))))

(defvar teamel/helm-all-comps-source
  (helm-build-in-buffer-source
     "idlegame comps"
   :init 'teamel/helm-all-comps-init
   :real-to-display 'helm-ag--candidate-transformer
   :fuzzy-match t
   :action helm-ag--actions
   :candidate-number-limit 9999
   :keymap helm-ag-map
   :follow (and helm-follow-mode-persistent)
   ))

(helm :sources teamel/helm-all-comps-source)



(defvar teamel/all-comps-helm-source
 (helm-build-sync-source
     "all comps"
     :candidates teamel/all-comps


     ))

(helm :sources teamel/all-comps-helm-source)
