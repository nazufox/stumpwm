(asdf:defsystem #:mycpu
  :serial t
  :depends-on (#:stumpwm)
  :components ((:file "package")
               (:file "mycpu")))
