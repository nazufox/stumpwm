(asdf:defsystem #:backlight
  :serial t
  :depends-on (#:stumpwm)
  :components ((:file "package")
               (:file "backlight")))
