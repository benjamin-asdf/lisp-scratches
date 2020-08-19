;;(team/setup-dev-scratch)

(defun wrap-assert ()
  (interactive)
  (goto-char (line-beginning-position))
  (let ((indentation (current-indentation))
        (success
         (save-excursion
           (re-search-forward
            "^[[:blank:]]*\\(?:UnityEngine\.\\)?Debug\.Assert\(\\([^\"]+\\),\\([^;]+\\)\);"
            (save-excursion
              (forward-line 5)
              (point-at-eol))
            t))))
    (if (not success)
        (insert "//--> regex fail")
      (let ((kill-whole-line t)
            (cond-match
             (format
              "!(%s)"
              (match-string-no-properties 1)))
            (body-match
             (format
              "Debug.Log(%s);"
              (string-trim
               (match-string-no-properties 2)))))
        (kill-line)
        (yas-minor-mode 1)
        (yas-expand-snippet
         (yas-lookup-snippet
          "if-template"
          'cc-mode)
         nil
         nil
         `((condition ,cond-match)
           (body ,body-match))))
      (let ((region (inserted-region)))
        (indent-region
         (cadr region)
         (car region)
         indentation))
      (forward-line -2)
      (indent-line-to (+ 4 indentation)))))

(team/with-file
    "example.cs"
  (forward-line 1)
  (forward-char 18)
  (wrap-assert))

(defun inserted-region ()
  (let ((res '()))
    (save-excursion
     (forward-line -3)
     (goto-char (line-beginning-position))
     (push (point-at-bol) res)
     (forward-line 2)
     (goto-char (line-end-position))
     (push (point-at-eol) res))))








;; (setq example-in '("/home/benj/repos/lisp/debug-assert/example.cs" (2 6)))


(defun rewrite-debug-assert (file lines &rest _)
  (team/with-file
   file
   (let ((markers (mapcar #'team/line-to-marker lines)))
     (--each
         markers
       (goto-char it)
       (wrap-assert)))))


(defun team/lines-as-markers (lines)
  "Return a new list consisting of the markers at the end of LINES
LINES should be a list of numbers."
  (--map
   (progn (line->> it)
          (point-marker))
   lines))

(defun team/line-to-marker (line)
  (line->> line)
  (point-marker))






;; (benj-roslyn/with-collected-lines
;;  ;; "/tmp/example-in"
;;  "/tmp/IdleGame-10:26:56.analyzer-log"

;;  #'(lambda (file lines &rest _)
;;      (message "File %s with %s" file (length lines))
;;        )
;;  )



(benj-roslyn/with-collected-lines
  "/tmp/in-file"
 #'rewrite-debug-assert
)
