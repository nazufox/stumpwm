(in-package :stumpwm)

(set-module-dir
 (merge-pathnames #P".stumpwm.d/stumpwm-contrib/" (user-homedir-pathname)))

(defun load-stumpwm-conf (pathspec)
  (load (merge-pathnames pathspec (merge-pathnames #P".stumpwm.d/" (user-homedir-pathname)))))

(load-stumpwm-conf "audio.lisp")
(load-stumpwm-conf "backlight.lisp")
(load-stumpwm-conf "commands.lisp")
(load-stumpwm-conf "keys.lisp")
(load-stumpwm-conf "visual.lisp")
