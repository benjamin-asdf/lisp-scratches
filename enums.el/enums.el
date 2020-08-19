















(team/spacemacs-define-keys
 "ot"
 '("e" grap-last-enum)
 '("t" insert-enum-to-descr)
 )




(defun insert-enum-to-descr ()
  (interactive)
  (unless last-enum
    (error "No last enum"))
  (let ((small-name (de-capitalize (car last-enum))))

    (insert (format "

public static string ToDescription(this %s %s) {
    switch(%2$s) {
%s
%s
    }
}

"
                    (car last-enum) small-name
                    (mapconcat
                     (// (value)
                         (format
                          "case %s.%s: return L._(\"%2$s\");"
                          (car last-enum)
                          value))
 (cadr last-enum)
 "\n")
                    (format "case default: throw new ArgumentException(typeof(%s));"
                            (car last-enum))))))


(defun de-capitalize (s)
  (concat
   (downcase (substring s 0 1))
   (substring s 1))o


(defvar last-enum '())
(defun grap-last-enum ()
  (interactive)
  (setq last-enum
        (list (enum-name) (get-enum-values))))

(defun enum-name ()
  (save-excursion
    (re-search-backward "public\s+enum\s+\\(\\w+\\) {" nil)
    (match-string-no-properties 1)))


(defun get-enum-values ()
  (let ((res)
        (bounds (points-to-markers (curly-bounds))))
    (goto-char (car bounds))
    (while (and
            (> (cadr bounds) (point))
            (re-search-forward "^[[:blank:]]+?\\(\\w+\\)\\(?:[[:blank:]]?=?,?\\)"
                               nil
                               t))
      (push (match-string-no-properties 1) res))

    res))



(defun curly-bounds ()
  (let ((res))
   (while
       (not (looking-at "{"))
       (forward-char -1))
   (forward-line 1)
   (setq res (point-at-bol))
   (while
       (not (looking-at "}"))
     (forward-char 1))
   (forward-line -1)
   (setq res (list res (point-at-eol)))))

(defun point-to-marker (p)
  (save-excursion
    (goto-char p)
    (point-marker)))

(defun points-to-markers (points)
  (mapcar #'point-to-marker points))

(cdr '( 1 2))
(cadr '(1 2 ))
