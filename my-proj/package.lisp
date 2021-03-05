;;;; package.lisp


(uiop:define-package #:my-proj
    (:use #:cl #:cepl #:rtg-math #:vari
          #:temporal-functions
          :cepl.skitter.sdl2
     :livesupport
          #:nineveh
          :varjo))
