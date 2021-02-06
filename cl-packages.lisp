











(defpackage :my-package
  (:use :cl))

(in-package :my-package)






(defpackage :my-package
  (:import-from :ppcre :regex-replace)
  (:use :cl))




(find-package 'prove)




(defpackage prove
  (:nicknames :cl-test-more :test-more)
  (:export :run :is :ok))

(do-external-symbols (s (find-package 'prove))
  (print s))

(prove:run)


(defpackage :mypackage
  (:use :cl)
  (:local-nicknames
   ;; (:nickname :original-package-name)
   (:alex :alexandria)
   (:re :cl-ppcre)))


(in-package :mypackage)
(alex:clamp )

(alex:whichever
 1 2 3 )

(butlast '(1 2 3))
