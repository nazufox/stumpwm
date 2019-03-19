(asdf:defsystem #:mynet
  :serial t
  :depends-on (#:stumpwm)
  :components ((:file "package")
               (:file "mynet")))
