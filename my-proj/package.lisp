;;;; package.lisp


(uiop:define-package #:my-proj
    (:use #:cl #:cepl #:rtg-math #:vari
          :cepl.skitter.sdl2
     :livesupport
          #:nineveh
     :temporal-functions))
