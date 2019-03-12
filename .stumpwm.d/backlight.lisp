(in-package :stumpwm)

(defun get-backlight ()
  (multiple-value-bind (backlight)
      (parse-integer (ppcre:scan-to-strings "\\d+" (run-shell-command "xbacklight" t)))
    backlight))
(defun set-backlight (value)
  (run-shell-command (format nil "xbacklight -set ~a" value)))

(defun get-backlight-modeline ()
  (concat "盛 " (princ-to-string (get-backlight)) "%%"))

(let ((backlight (get-backlight))
      (inc-dec-value 5))
  (defcommand bright-up () ()
    "Increase the monitor brightness"
    (incf backlight inc-dec-value)
    (when (> backlight 100) (setf backlight 100))
    (set-backlight backlight)
    (message (princ-to-string backlight)))

  (defcommand bright-down () ()
    "Decrease the monitor brightness"
    (decf backlight inc-dec-value)
    (when (< backlight 0) (setf backlight 0))
    (set-backlight backlight)
    (message (princ-to-string backlight))))
