(in-package :stumpwm)

(defun get-backlight ()
  (multiple-value-bind (backlight)
      (parse-integer (ppcre:scan-to-strings "\\d+" (run-shell-command "xbacklight" t)))
    backlight))

(let ((inc-dec-value 5))
  (defcommand bright-up () ()
    "Increase the monitor brightness"
    (let ((backlight (+ (get-backlight) inc-dec-value)))
      (when (> backlight 100) (setf backlight 100))
      (run-shell-command (format nil "xbacklight -set ~a" backlight))
      (message (princ-to-string backlight))))

  (defcommand bright-down () ()
    "Decrease the monitor brightness"
    (let ((backlight (- (get-backlight) inc-dec-value)))
      (when (< backlight 0) (setf backlight 0))
      (run-shell-command (format nil "xbacklight -set ~a" backlight))
      (message (princ-to-string backlight)))))
