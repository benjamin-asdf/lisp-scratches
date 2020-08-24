




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

(progn
  (let ((res))
   (message "Build all comps lookup..")
   (with-current-buffer
       "collect"
     (goto-char (point-min))
     (team/while-reg
      ":public[[:blank:]]class[[:blank:]]\\(\\w+\\)"
      (push (match-string-no-properties 1) res)))
   (setq teamel/all-comps res))
  (message "done."))
(setq teamel/all-comps nil)


(defun teamel/helm-all-comps-init ()
  (with-current-buffer
      (helm-candidate-buffer 'global)
    (let ((default-directory idlegame-project-root))
      (process-file-shell-command
       "global --result=grep --other --reference \"Component\" | rg \"public class\""
       nil t nil))))


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
(helm :sources teamel/helm-all-comps-names-source)

(setq teamel/helm-all-comps-names-source nil)

(defvar teamel/helm-all-comps-names-source
  (helm-build-in-buffer-source
      "idlegame comps"
    :init 'teamel/helm-all-comps-init
    ;; :real-to-display 'teamel/helm-comps-name-canditate-transformer
    :real-to-display 'helm-ag--candidate-transformer
    ;; :candidates
    :fuzzy-match t
    :match-part #'match---part
    :get-line #'get---line
    ;; :action  'identity
    :action helm-ag--actions
    ;; :action (helm-make-actions
    ;;          "put"
    ;;          )
    :candidate-number-limit 9999
    ;; :keymap helm-ag-map
    ;; :follow (and helm-follow-mode-persistent)
    ))


(defun get---line (beg end)
  (message "get line %s" (buffer-substring-no-properties beg end))
  (goto-char beg)
  (when (re-search-forward "public class \\(\\w+\\)" end t 1)
    (match-string 1))
  )

(defun match---part (canditate)
  (with-temp-buffer
    (insert canditate)
    (re-search-forward "public class \\(\\w+\\)")
    (match-string 1)))



(defun teamel/helm-comps-name-canditate-transformer (canditate)
  canditate)


(defvar teamel/all-comps-helm-source
 (helm-build-sync-source
     "all comps"
     :candidates teamel/all-comps
     ))

(helm :sources teamel/all-comps-helm-source)
