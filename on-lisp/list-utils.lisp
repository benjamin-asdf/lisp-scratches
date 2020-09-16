

(proclaim '(inline last1 single append1  conc1 mklist))


(defun last1 (lst)
  (car (last lst)))

(defun single (lst)
  (and (consp lst) (not (cdr lst))))

(defun append1 (lst obj)
  (append lst (list obj)))

(defun conc1 (lst obj)
  (nconc lst (list obj)))

(defun mklist  (obj)
  (if (listp obj) obj (list obj)))








(defun longer (x y)
  (labels ((compare (x y)
             (and (consp x)
                  (or (null y)
                      (compare (cdr x) (cdr  y))))))
    (if (and (listp x) (listp y))
        (compare x y)
        (> (length x) (length y)))))



(defun filter (fn lst)
  (let ((acc '()))
    (dolist (elm lst)
      (let ((val (funcall fn elm)))
        (when val (push val acc))))
    (nreverse acc)))



;; (defun group (list n)
;;   (if (= 0 n)
;;       list
;;       (labels ((rec (lst acc)
;;                  (if (null lst)
;;                      (nreverse acc)
;;                      (rec (nthcdr n lst)
;;                           (cons
;;                            (if (> (length lst) n)
;;                                (subseq lst 0 n)
;;                                lst)
;;                            acc)))))
        ;; (rec list nil))))


;; no need for (lenght), because we implicitly check that with (nthcdr)  already
(defun group (source n)
  (when (zerop n) (error "zero length"))
  (labels ((rec (source acc)
             (let ((rest (nthcdr n source)))
               (if (consp rest)
                   (rec rest (cons (subseq source 0 n) acc))
                   (nreverse (cons source acc))))))
    (if source (rec source nil) nil)))





;; my first attempt
(defun flatten (lst)
  (let ((res nil))
    (dolist (elm lst)
      (dolist (item (if (listp elm)
                        (flatten elm)
                        (list elm)))
        (push item res)))
    (nreverse res)))


(listp (cdr '(1 2 3)))


(flatten '(1 2 (3 4 (5 6))))
(mapcar )

;; (defmacro --map (form list)
;;   `(mapcar (lambda (it) ,form) ,list))


;; (defun flatten (lst)
;;   (print lst)
;;   (if (and (listp (car lst)) (cdr lst))
;;       (map 'list 'flatten lst)
;;       (list lst)))

;; (flatten '(1 2))
;; (cdr '(1 2))
;; (mapcar 'flatten)



;; my version
(defun flatten  (list)
  (labels ((rec (elm list acc)
             (print (list elm list acc))
             (if (null elm)
                 (nreverse acc)
                 (if (listp elm)
                     (let ((rest (cdr elm)))
                       (rec
                        (car elm)
                        (if rest
                            (cons rest list)
                            list)
                        acc))
                     (rec (car list) (cdr list) (cons elm acc))))))
    (rec (car list) (cdr list) nil)))

(flatten '(1 2 (3 4) (5) (6 7 (8)) 9 10))

(flatten '((1) 2 ))
(flatten '(1 2 (3) 4))

(cons nil '(2))


;; non tail - recursive
(defun flatten  (list)
  (labels ((rec (elm list acc)
             (if (null elm)
                 (nreverse acc)
                 (if (listp elm)
                     (rec (car list) (cdr list) (rec (car elm) (cdr elm) acc))
                     (rec (car list) (cdr list) (cons elm acc))))))
    (rec (car list) (cdr list) nil)))

(flatten '(1 2 (3 4) (5)))


(defun flatten  (list)
  (labels ((rec (elm list acc)
             (if (null elm)
                 (nreverse acc)
                 (if (listp elm)
                     (rec (car list) (cdr list) (rec (car elm) (cdr elm) acc))
                     (rec (car list) (cdr list) (cons elm acc))))))
    (rec (car list) (cdr list) nil)))







;; my version
(defun flatten (list)
  (labels ((rec (elm list acc)
             (print (list elm list acc))
             (if (null elm)
                 (nreverse acc)
                 (if (listp elm)
                     (let ((rest (cdr elm)))
                       (rec
                        (car elm)
                        (if rest
                            (cons rest list)
                            list)
                        acc))
                     (rec (car list) (cdr list) (cons elm acc))))))
    (rec (car list) (cdr list) nil)))




;; my version
(defun flatten (list)
  (labels ((rec (elm list acc)
             (if (null elm)
                 (nreverse acc)
                 (if (listp elm)
                     (let ((rest (cdr elm)))
                       (rec
                        (car elm)
                        (if rest
                            (cons rest list)
                            list)
                        acc))
                     (rec (car list) (cdr list) (cons elm acc))))))
    (rec (car list) (cdr list) nil)))



;; puals version
(defun flatten (x)
  (labels ((rec (x acc)
             (cond ((null x) acc)
                   ((atom x) (cons x acc))
                   (t (rec (car x) (rec (cdr x) acc))))))
    (rec x nil)))


(flatten '(1 2 (3 4) (5)) )


;; this one is reversed and also it does not preserve the tree
(defun prune (fn x)
  (labels ((rec (x acc)
             (cond
               ((null x) (nreverse acc))
               ((atom x) (if (not (funcall fn x))
                             (cons x acc)
                             acc))
               (t (rec (cdr x)
                       (rec (car x) acc))))))
    (rec x nil)))

(remove-if 'evenp '(1 2 3 (4 5)))
(prune 'evenp '(1 2 3 (4 5)))



(let ((a '(4)))
  (copy-list `(1 2 3 ,a)))
(let ((a '(4)))
  (copy-tree `(1 2 3 ,a)))
(copy-tree '(1 2 3 (4 (5))))






(defun prune (fn x)
  (labels ((rec (curr x acc)
             (cond ((null curr) acc)
                   ((atom curr) (rec nil (cons curr acc)))
                   ((listp curr) (cons (rec (rec (car curr) (cdr curr) acc)))))))
    (rec (car x) (cdr x) nil)))

(prune 'evenp '(1 2 3 (4 5)))

(prune 'evenp '(1 2 (3)))


(defun prune (test tree)
  (labels ((rec (tree acc)
             (cond ((null tree) (nreverse acc))
                   ((consp (car tree))
                    (rec (cdr tree)
                         (cons (rec (car tree) nil) acc)))
                   (t (rec (cdr tree)
                           (if (funcall test (car tree))
                               acc
                               (cons (car tree) acc)))))))
    (rec tree nil)))


(defun find2 (fn lst)
  (if (null lst)
      nil
      (let ((val (funcall fn (car lst)))))
      (if (val)
          (values val (car list))
          (find2 fn (cdr lst)))))



; before




(< (position 1 '(1 2)) (position 2 '(1 2)))


(defun before (a b lst)
  "If A is before B in LST, return non nil."
  (labels ((rec (lst acc)
             (print acc)
             (ccase lst
               ((pred null) nil)
                 (null lst)
                 nil
                 (rec (cdr lst)
                      (if (or acc (eq (car lst) a))
                          (cons (car lst) acc) nil)))))
    (rec lst nil)))


(before  'b  'a' (f a d b e))

(let ((a 10))
  (ccase a
    ((pred numberp) (print a))
    (_ (print 'abs))))

;; my version

(defun before (a b lst)
  "If A is before B in LST, return non nil."
  (labels ((rec (lst acc)
             (print acc)
             (cond
               ((null lst) nil)
               ((and acc (eq b (car lst)))
                (nreverse (cons (car lst) acc)))
               (t (rec (cdr lst)
                     (if (or acc (eq (car lst) a))
                         (cons (car lst) acc) nil))))))
    (rec lst nil)))




; paul

(defun before (x y list &key (test #'eql))
  (and lst
       (let ((first (car list)))
         (cond
           ((funcall test y first) nil)
           ((funcall test x first) list)
           (t (before x y (cdr list) :test test))))))

(before 'a 'b '(f a d b e))


(defun after (x y list &key (test #'eql))
  (let ((rest (before x y list)))
    (and rest (member y rest :test test))))

(after 'a 'b '(f a d b e))
(after 'b 'a '(f a d b e))

(defun duplicate (obj lst &key (test #'eql))
  (member obj (member obj lst :test test) :test test))

(duplicate 'a '(a b c))





(defun split-if (fn list)
  (labels ((rec (lst acc)
             (cond
               ((null lst) (nreverse acc))
               ((funcall fn (car lst)) (values (nreverse acc) (cdr lst)))
               (t (rec (cdr lst) (cons (car lst) acc))))))
    (rec list nil)))


(split-if #'evenp '(1 3 2 5))
