(asdf:defsystem #:mymem
  :serial t
  :depends-on (#:stumpwm)
  :components ((:file "package")
               (:file "mymem")))
