(in-package :stumpwm)

(set-module-dir
 (merge-pathnames #P".stumpwm.d/stumpwm-contrib/" (user-homedir-pathname)))

(defconstant +stumpwm-dir-pathname+ (merge-pathnames #P".stumpwm.d/" (user-homedir-pathname)))

(load (merge-pathnames "audio.lisp"     +stumpwm-dir-pathname+))
(load (merge-pathnames "backlight.lisp" +stumpwm-dir-pathname+))
(load (merge-pathnames "commands.lisp"  +stumpwm-dir-pathname+))
(load (merge-pathnames "keys.lisp"      +stumpwm-dir-pathname+))
(load (merge-pathnames "visual.lisp"    +stumpwm-dir-pathname+))
