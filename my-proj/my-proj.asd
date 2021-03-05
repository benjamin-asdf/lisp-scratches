;;;; my-proj.asd

(asdf:defsystem #:my-proj
  :description "Describe my-proj here"
  :author "benj <Benjamin.Schwerdtner@gmail.com>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :depends-on (#:cepl
               #:nineveh
               #:rtg-math.vari #:cepl.sdl2 #:swank #:livesupport #:cepl.skitter.sdl2 #:dirt
               #:temporal-functions
               )
  :components ((:file "package")
               (:file "my-proj")))
