(in-package :stumpwm)

(ql:quickload :swank)
(ql:quickload :clx-truetype)

(set-module-dir
 (merge-pathnames #P".stumpwm.d/modules/" (user-homedir-pathname)))

(load-module "backlight")
(load-module "audio")

(setf *startup-message* nil)
(setf *mouse-focus-policy* :sloppy)
(setf *ignore-wm-inc-hints* t)

(load-module "ttf-fonts")
;;(setf xft:*font-dirs* (cons (format nil "~a.local/share/fonts/" (user-homedir-pathname))
;;                            xft:*font-dirs*))
;;(xft:cache-fonts)
(set-font (list
           (make-instance 'xft:font :family "uzura_font Nerd Font" :subfamily "Book" :size 13)
           (make-instance 'xft:font :family "azukifontB Nerd Font" :subfamily "Book" :size 11)))

(defvar *stumpwm-dir* (merge-pathnames #P".stumpwm.d/" (user-homedir-pathname)))
(defun load-stumpwm-conf (pathspec)
  (load (merge-pathnames pathspec *stumpwm-dir*)))

(load-stumpwm-conf "commands.lisp")
(load-stumpwm-conf "app-menu.lisp")
(load-stumpwm-conf "keys.lisp")
(load-stumpwm-conf "bar.lisp")
(load-stumpwm-conf "modeline.lisp")
(load-stumpwm-conf "windows.lisp")
(load-stumpwm-conf "frames.lisp")
(load-stumpwm-conf "groups.lisp")

(swank-loader:init)
(swank:create-server :port 4005 :dont-close t)
