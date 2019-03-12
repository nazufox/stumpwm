(in-package :stumpwm)

(defun get-battery-percentage ()
  (multiple-value-bind (val)
      (parse-integer
       (ppcre:scan-to-strings
        "\\d+"
        (run-shell-command
         "upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep \"percentage\"" t)))
    val))

(defun get-battey-state ()
  (remove
   #\Newline
   (run-shell-command
    "upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'state' | awk '{ print $2 }'" t)))

(defun get-battery-modeline ()
  (concat
   (let ((parcentage (get-battery-percentage)))
     (cond
       ((>= parcentage 80) "")
       ((>= parcentage 60) "")
       ((>= parcentage 40) "")
       ((>= parcentage 20) "")
       ((>= parcentage  0) "")))
   " "
   (princ-to-string (get-battery-percentage))
   "%%"
   (cond
     ((string= (get-battey-state) "discharging") "-")
     ((string= (get-battey-state) "charging")    "+")
     (t "?"))))
