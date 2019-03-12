(in-package :stumpwm)

(defun get-backlight ()
  (let ((backlight (ppcre:scan-to-strings "\\d+" (run-shell-command "xbacklight" t))))
    (if backlight backlight "100")))
(defun set-backlight (value)
  (run-shell-command (format nil "xbacklight -set ~a" value)))

(defun get-backlight-modeline ()
  (concat (get-backlight) "%%"))

(let ((backlight (parse-integer (get-backlight)))
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
