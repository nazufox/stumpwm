(in-package :stumpwm)

(ql:quickload '(swank) :silent t)
(swank-loader:init)
(swank:create-server :port 4005 :dont-close t)

(set-normal-gravity :center)
(setf *mouse-focus-policy* :sloppy)

(set-module-dir
 (merge-pathnames #P".stumpwm.d/stumpwm-contrib/" (user-homedir-pathname)))

(defvar *stumpwm-dir* (merge-pathnames #P".stumpwm.d/" (user-homedir-pathname)))
(defun load-stumpwm-conf (pathspec)
  (load (merge-pathnames pathspec *stumpwm-dir*)))

(load-stumpwm-conf "audio.lisp")
(load-stumpwm-conf "backlight.lisp")
(load-stumpwm-conf "commands.lisp")
(load-stumpwm-conf "keys.lisp")
(load-stumpwm-conf "bar.lisp")
(load-stumpwm-conf "modeline.lisp")
