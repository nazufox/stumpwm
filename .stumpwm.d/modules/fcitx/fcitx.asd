(asdf:defsystem #:fcitx
  :serial t
  :depends-on (#:stumpwm)
  :components ((:file "package")
               (:file "fcitx")))
