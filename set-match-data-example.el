(defun re-set-sprite ()
  (interactive)
  (when
      (re-search-forward
       (concat
        ;; 1
        ;; we are probably looking at some interface declaration, skip
        "\\(.*void\\bSetSprite(.*).*;\\)"
        "\\|"
        ;; 2,3,4
        "\\("
        ;; 4 this is either an ommitted c, the name of some c,
        ;;  or the name of a sprite container
        "\\b\\(\\(.+?\\)\\.\\)?"
        "setsprite" "("
        "\\)")
       nil t)
    (forward-char 1)
    (set-match-data
     (append
      (match-data)
      (list
       (point-marker)
       (save-excursion
         (skip-chars-forward "^;")
         (forward-char -2)
         (point-marker)))))
    t))
