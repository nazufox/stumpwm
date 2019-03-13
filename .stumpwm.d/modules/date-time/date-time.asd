(asdf:defsystem #:date-time
  :serial t
  :depends-on (#:stumpwm)
  :components ((:file "package")
               (:file "date-time")))
