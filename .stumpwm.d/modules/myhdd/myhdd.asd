(asdf:defsystem #:myhdd
  :serial t
  :depends-on (#:stumpwm)
  :components ((:file "package")
               (:file "myhdd")))
