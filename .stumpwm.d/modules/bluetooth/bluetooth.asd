(asdf:defsystem #:bluetooth
  :serial t
  :depends-on (#:stumpwm)
  :components ((:file "package")
               (:file "bluetooth")))
