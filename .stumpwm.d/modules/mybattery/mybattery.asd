(asdf:defsystem #:mybattery
  :serial t
  :depends-on (#:stumpwm)
  :components ((:file "package")
               (:file "mybattery")))
