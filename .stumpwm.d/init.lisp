(in-package :stumpwm)

(ql:quickload :swank)
(ql:quickload :clx-truetype)

(set-module-dir
 (merge-pathnames #P".stumpwm.d/stumpwm-contrib/" (user-homedir-pathname)))

(swank-loader:init)
(swank:create-server :port 4005 :dont-close t)

(set-normal-gravity :center)
(setf *mouse-focus-policy* :sloppy)

(load-module "ttf-fonts")
;;(xft:cache-fonts)
(set-font (make-instance 'xft:font :family "M+ 1mn" :subfamily "Regular" :size 12))

(defvar *stumpwm-dir* (merge-pathnames #P".stumpwm.d/" (user-homedir-pathname)))
(defun load-stumpwm-conf (pathspec)
  (load (merge-pathnames pathspec *stumpwm-dir*)))

(load-stumpwm-conf "audio.lisp")
(load-stumpwm-conf "backlight.lisp")
(load-stumpwm-conf "commands.lisp")
(load-stumpwm-conf "app-menu.lisp")
(load-stumpwm-conf "keys.lisp")
(load-stumpwm-conf "bar.lisp")
(load-stumpwm-conf "modeline.lisp")
(load-stumpwm-conf "windows.lisp")
