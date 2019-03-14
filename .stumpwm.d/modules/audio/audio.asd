(asdf:defsystem #:audio
  :serial t
  :depends-on (#:stumpwm)
  :components ((:file "package")
               (:file "audio")))
