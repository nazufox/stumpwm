(asdf:defsystem #:myhdd
  :defsystem-depends-on (#:cffi-grovel)
  :serial t
  :depends-on (#:cffi #:stumpwm)
  :components ((:file "package")
               (:file "utils")
               (:cffi-grovel-file "grovel-statvfs")
               (:file "statvfs")
               (:file "myhdd")))
