



























(when (string-match-p
       "*scratch"
       (buffer-name))
  (benj-backups--file-name (string-trim (buffer-name) "*" "*")))



(benj-roslyn-tools/run-idlegame "-sync"
                                "-sym" "FixIfHindiBengali"
                                )






(mapcar


 (-doto
     )
 )

(team/range)

(defun team/range (&rest args)
  "Return a list of numbers
If a single nubmer arg is given, default to
from 0 to ARG.
If 2 args are given, go from arg1 to arg2."
  (when-let ((res)
        (from (or (and (= 2 (length args))
                       (car args)) 0))
        (to (or (and (= 1 (length args)) (car args))
                (cdr args) (car args))))
    (dotimes
        (x (- to from))
      (setq res (cons (+ x from) res)))
    (when res (nreverse res))))


(team/range 2 13)
(cdr '(2))
