





(defmacro hello (msg)
  (let ((tempvar (gensym)))
    `(let ((,tempvar (some-op msg)))
       (lambda (arg) (message "The message %s and the arg %s" ,tempvar arg)))))

(defmacro hello (msg)
  `(lambda (arg) (message "The message %s and the arg %s" ',msg arg)))

(macroexpand `(hello "ff"))

(defun some-op (s)
  (concat "blubb" s))

(some-op "ff")
(hello msg)

(defun say-hello (msg arg)
  (funcall (hello msg) arg))

(say-hello "Hi" "We are great")

(funcall (hello "sff") "boiiss")

(hello "f")

;; shows that the lambda doesn't work
(funcall (eval (macroexpand `(hello msg))) "hi")















(defmacro double (x)
  `(* 2 ,x))

(defmacro tripple (x)
  (list '* 3 x))

(double 10)
(tripple 10)




(defun put-into-output-buff (process output)
  (when (buffer-live-p (process-buffer process))
    (with-current-buffer
        (process-buffer process)
      ()
      )
    )
  (setq kept (cons output kept))
  )

(defmacro put-into-buff ()

  )



(call-process )

(pop-to-buffer (start-process "proc-name" "*say-hello*" "echo-hello"))





(set-process-filter (start-process "proc-name" "*say-hello*" "echo-hello")
                    (lambda (process string)
                      (when (string-match-p "oo" string)
                        (write-region string nil "/tmp/hello-filtered" t))
                    ))

(string-match-p "oo" "helloo")

(defun benj/append-to-file (file string)
  (benj/with-file
   file
   (progn
     (goto-char (point-max)) (
                              insert (concat string "\n")))))

(defmacro benj/with-file (file form)
  "Insert FILE into a temp buffer. And evaluate FORM."
  `(with-temp-file
      file
    (insert-file-contents-literally file)
    ,form))




(defun keep-output (process output)
  (setq kept (cons output kept)))




(setq kept nil)

(set-process-filter (get-process "shell") 'ordinary-insertion-filter)

(process-send-string "shell" "ls \n")


(setq best-output-buff "my-output-buff")
(with-current-buffer
    )

(defmacro quatruple (name amt)
  `(defun ,name (x) (* ,amt x)))

(quatruple times-10 10)

(times-10 10)


(defmacro conditional-macro (x)
  (if  (> x 10) `(message "this macro is for nums greater 10") `(message "this macro is for nums smaller 10")))

(macroexpand `(conditional-macro 11))
(conditional-macro 11)




(defun ordinary-insertion-filter (proc string)
  )






(magit-unmerged-files)




(defmacro we-say-hello (&rest args)
  `(message ,@args))
(we-say-hello "best%s - hehe" " lisp!")
