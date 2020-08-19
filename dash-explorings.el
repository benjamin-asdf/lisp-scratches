




(-> 10 () )

(-as-> 10 x (+ 3 x) (+ 7 x) (* 10 x) (message (number-to-string x)))

(-some-> 10 (message ))

(eval (macroexpand `(-> 10 (+ 10) (* 11))))


(defun transformation (arg)
  (+ 10 arg))

(defun other (arg)
  (* 3 arg))

(eval (macroexpand `(-some-> 10 transformation transformation)))

(-some-->
    10
  nil
  (+ 3 it)
  nil
  )

;; ad it as last item
(macroexpand `(->> 10 (message "%s%s" "hee")))
;; ad it as second item
(macroexpand `(-> 10 (message "%s%s" "hee")))

(eval (macroexpand `(->> 10 (message "%s%s" "hee"))))
(eval (macroexpand `(-> 10 (message "%s%s" "hee"))))



(-some-> 10 (message "%s%s" "hee"))
(-some->> 10 nil (message "%s%s" "hee"))

(-some-->
    10
  (+ 5 it)
  (message (number-to-string it))
  nil
  (+ 1000)
    )

(--map-indexed
 (format "item %s %s" it-index it)
 '("ff" "fff"))

(-sort '(lambda (it other) (> (length it) (length other))) '("ff" "ffffff" "asd"))


(-map 'cdr (
  -sort
  '(lambda (it other) (> (length (car it)) (length (car other))))
  (--map-indexed
   (cons it it-index)
   '("ff" "abcdef" "fff")
   )

  ))



(--map
 (nth-value it
  '("ff" "abcdef" "fff"))
 (-grade-down
  '(lambda (it other) (> (length it) (length other)))
  '("ff" "abcdef" "fff"))
 )

(-permutations '(1 2 3))


(funcall #'(lambda (a b) (message (concat a b))) (cons "ff" "afs"))



(benj-roslyn-runner
 idlegame-sln-path
 "-comp-snapshot"
 )




(benj-roslyn-tools/add-comments-to-warnings  "/tmp/last-roslyn-run" " // disable BEST033")



(defun f (&rest arg)
  (car arg))

(defun ff (&rest arg)
  (eval `(f ,@arg)))

(defun fff (&rest arg)
  (eval `(ff ,@arg)))

(fff "ffff")




(benj-roslyn-tools/add-comments-to-warnings  "/tmp/in-file" " // disable BEST043")

























(setq path-a "/a/b/c/d.el")
(setq path-b "/a/b/f/f/")

;; get the common part index

;; first part: ../ * (- path-b index-comm)

;; second part (subseq  path-a index)


(let ((res))


  )


(-non-nil
 (--map-indexed
  (when (equal it (nth-value it-index (split-string (string-trim path-b) "/"))) it)
  (split-string (string-trim path-a) "/")))
