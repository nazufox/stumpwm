(in-package :stumpwm)

(ql:quickload :swank)
(ql:quickload :clx-truetype)

(set-module-dir
 (merge-pathnames #P".stumpwm.d/modules/" (user-homedir-pathname)))

(load-module "backlight")
(load-module "audio")

(setf *mouse-focus-policy* :sloppy)
(setf *ignore-wm-inc-hints* t)

(load-module "ttf-fonts")
;;(xft:cache-fonts)
(set-font (make-instance 'xft:font :family "Ricty Nerd Font" :subfamily "Regular" :size 13))

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
