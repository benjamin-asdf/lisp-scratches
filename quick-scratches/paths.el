(defun my-double (x)
  (* x 2))
(defun my-increase (x)
  (+ x 1))
(advice-add 'my-double :filter-return #'my-increase)
(defun my-tracing-function (proc string)
  (message "Proc %S recieved %s" proc string))
(setq my-proc (start-process "name" "*echo-hello*" "echo-hello"))
(add-function :before (process-filter my-proc) #'my-tracing-function)
(set-process-sentinel my-proc #'my-tracing-function)
(apply (process-sentinel my-proc) (list my-proc "hehehehe"))
(kill-process my-proc)




(ert-deftest benj-tools/get-relative-test ()
  (let ((a "/a/b/c/d")
        (b "/a/b/x/y"))
    (should (eq (benj-tools/get-relative-path a b) "../../c/d"))))





(setq a "/a/b/c/d/e")
(setq b "/a/b/x/y")

(setq expected "../../c/d")

(setq c "/a/b/x/y/z")

(while (setq a-parts (split-string a  "/" t)))
(split-string b  "/" t)


(benj-tools/get-relative-path a b)

(defun benj-tools/get-relative-path (a b)
  "Get the relative path to A from B."
  (let* ((res)
         (comm-part-idx)
         ;; (b (file-name-directory (expand-file-name b)))
         (b-parts (split-string b  "/" t))
         (a-parts (split-string b  "/" t)))
    (--each-indexed
        a-parts
      (unless comm-part-idx
        (when (not (string-equal it (nth-value it-index b-parts)))
          (setq comm-part-idx it-index)))

          ;;  the ../ part from b going to the common base
          (--dotimes (- (length b-parts) 1) (setq res (cons res "../")))

          ;; the path to a part starting from the common base
          (setq res (cons res (subseq a-parts comm-part-idx))))

    (mapconcat 'identity res "/")))



(benj-tools/get-relative-path a b)






(let ((idx 0))
  (while (and (> (length s) idx)
              (string-match (substring s 0 1)))))
(--dotimes
    (- (length s) 1)
  )

(let ((path-from-last-common))
  (--map-indexed
  (cond
   (
    (if (string-equal (nth-value it-index a-parts) it))
    nil
    (progn ))
   (= it-index (- (length b-parts) 1) nil)
   (> it-index (lenght b-parts ".."))

   (t it))
  a-parts))


(-zip-fill  a-parts b-parts)


(--zip-with

 (progn (message it)
        (message other))

 '("a")
 '("b" "a")
 )



;; )



(* 3 "../")

(setq ben "")
(--dotimes 3 (setq ben (concat ben "../")))




























































(defun hello-args (&rest args)
  (message (or (and (plist-get args :message)) "default"))
  )



(defmacro hello-use-default (arg &rest args)
  `(pcase (plist-get ',args ,arg)
     ;; (pred  (lambda (n) (or (not n) 'default))
     ;;       )
     ;; (or (symbol 'default) _ (plist-get defaults ,arg))

     ('default (plist-get defaults ,arg))
     ((pred null) (plist-get defaults ,arg))
     (option option)
     ))

(null nil)

(hello-use-default :message "lul")

(macroexpand `(hello-use-default :message :message "hello"))

(hello-use-default :message :message 'default)



(setq defaults '(:message "best default" :other "hehe"))



(pcase nil
  ((pred number-or-marker-p) (message "is num"))
  (_ (message "default")

     )
  )



(pcase 'default
  ('default (message "hello"))
  (_ (message "other"))
  (best best)
  )


(let ((res))

  )

(--zip-with
 (when (memq ))

 '(:message "my-message")
 defaults)
