(defvar v)

(cl-loop
 for x upfrom 100 downto 0 by 10
 do (message (number-to-string x))

 )


(cl-loop for name in '(fred sue alice joe june)
         for kids in '((bob ken) () () (kris sunshine) ())
         collect name
         append kids)
















(cl-loop
        for l in lists
         collect (length l)
         sum l)

(cl-loop for x from 0 to 5
         collect (+ x 10)
         sum x)




(cl-loop for buf in (buffer-list)
         collect (buffer-file-name buf))







(cl-loop repeat 20 do (insert "Yowsa\n"))Yowsa



(cl-loop do (message "another line") until (eobp) do (forward-line 1))




(eobp)



(cl-loop for x from 1 to 100
         for y = (* x x)
         until (>= y 729)
         finally return (list x (= y 729)))

(cl-loop as x being the elements of lists

         )


(setq lists '((2 10) () (126)))

(let ((res))
  (when (> (cl-loop for x in lists sum (length x)) 0)
    (-mapcat
     (cl-loop
      for x below (get-length it)
      collect (memq x it))
     lists)


    )
  )

(defun get-length (l) 4)


(--mapcat (list (= 10 it)) '(0 3 10 3 10 20))

(cl-loop
 for x below 5
 collect (memq x '(3 4)))


(defun team/magit-unstage-regex (arg)
  "Unstage all files matching `arg' using magit.
If arg is 0, use 'prefab."
  (interactive"P")
  (require 'magit)
  (unless arg (user-error "Prefix arg is either a string,
or 0 to use .prefab$
or 1 to use .meta$"))
  (magit-with-toplevel
    (if-let* ((match (if (eql arg 0) ".prefab$" arg))
                (files (--filter (string-match match it) (magit-unstaged-files))))
        (magit-run-git-async
      "checkout"
      "--"
      (mapcar
       'identity
       files)))
    (message "There are no unstaged files for %s" arg)))




(magit-get-upstream-remote )
(magit-get-upstream-branch (magit-read-branch "B: "))
(magit-get-upstream-ref (magit-read-branch "B: "))

(format "%1$s:%1$s" "ff")


(let ((default-directory
        (concat
         idlegame-project-root
         "Tools/"
         "CodePatcherCLI/")))
  (async-shell-command
   "dotnet"
   (expand-file-name "CodePatcherCLI.dll")
   )

  )


(let ((default-directory))


  )









(defmacro m (name)
  `(message ,(symbol-name name)))

(m my-name)

(make-symbol "my-sym")


(eval `(defvar hi nil))

(when hi (message "hi"))



(defmacro test (options)
  (let ((group-name)
        (sym))
    (while (keywordp (setq keyw (pop options)))
      (pcase keyw
        (:group:
         (setq group-name
               (concat
                "team/cmd-chain-list-"
                (symbol-name (pop options)))))
        ))
    (setq sym (make-symbol group-name))
    `(progn
       (defvar ,sym "param value")
       (defun tt ()
         (message ,sym)))))

(test (:group: hehe))

(tt)

team/cmd-chain-list-hehe




(defvar team/cmd-chain-list nil
  "This is either set to t, if there is a single process running,
Or to queue of waiting proccesses.")

(defmacro team/define-chainable-cmd (name arg-list options &rest proc-form)
  "Define a command NAME that can be chained with other chainable commands.
NAME, ARG-LIST and PROC-FORM follow defun style.
Options is a list of keyword options pairs.
:group: this is required and should be a symbol specifying the command chain group.
Example:
:group 'code-pather: commands defined in the code pather group will be chained."
  (let ((name (symbol-name name))
        (keyw)
        (chain-sym))
    (while (keywordp (setq keyw (pop options)))
      (pcase keyw
        (:group:
         (setq chain-sym
               (concat
                "team/cmd-chain-list-"
                (symbol-name (pop options)))))))
    (progn
      `(defvar ,chain-sym '())
      `(defun ,name ,arg-list
        (interactive)
        (when team/cmd-chain-list
          (push
           (list ,name (list ,@arg-list))
           team/cmd-chain-list)
          (user-error "%s will run next in the cmd chain." ,name))

        (push team/cmd-chain-list t)

        (let ((proc ,@proc-form))
          (set-process-sentinel
           proc
           (lambda (proc evnt)
             (when team/cmd-chain-list
               (if (listp team/cmd-chain-list)
                   ;; pop and run

                   (message "we are done"))

               )
             (let ((next))
               (while (setq next (car ll))
                 (pcase next
                   ((pred listp)
                    (message "elt is a list")
                    )
                   (_
                    (message "something else")
                    )
                   )

                 )
               (if (listp next)
                   (apply (car next) (cdr next))
                 )
               )))))))

  )


(push 1 ll)
(push 2 ll)
(setq ll (append ll (list 4)))
(pop ll)


(let ((ll '(t (frist) (second))))

  (setq ll (-filter 'listp ll))
  (let ((next (pop ll)))
    (message "do sth with %s" (symbol-name (car next)))

    ))

(let ll `(t (frist) (second))
    (while (setq next (car ll))
   (pcase next
     ((pred listp)
      (message "doing something with %s" (symbol-name (car next)))
      )
     (_
      (message "remove")
      )
     )

   ))



(-concat )

(-cons* 1 2 3 nil)


(defvar ll '())

(push 1 ll)
(push t ll)
(push (list #'message (list "ff" "fff")) ll)

(pop ll)

(while ())

(while ll
  (pcase  (car ll)
   ((pred listp) (message "elt is a list"))
   (_ (message "something else"))
   )
  (pop ll))

(while (pop ll) (message "e"))

(while (pcase (pop ll) (_ (message "eee")))
  (message "e")
  )

(cond )

(pcase nil
  ((pred (listp)) (message "el is a list"))
  )

(let ((next))
  (while (setq next (car ll))

    (pop ll))
  )



(defmacro m (name args)
  (declare (indent defun))
  `(defun ,name ,args
     (apply #'message (list ,@args))))

(macroexpand `(m lul (a b)))

(m lul (a b))

(lul "hi%s" "  fff")
(lul)


(macroexpand `(m hehehe (a b)))
(macroexpand )
(m hehehe (a b))
(hehehe "helloo ! %s" "world")
