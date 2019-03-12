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
  (let ((percentage (get-battery-percentage)))
    (concat
     (cond
       ((string= (get-battey-state) "discharging")
        (cond
          ((>= percentage 90) "")
          ((>= percentage 80) "")
          ((>= percentage 70) "")
          ((>= percentage 60) "")
          ((>= percentage 50) "")
          ((>= percentage 40) "")
          ((>= percentage 30) "")
          ((>= percentage 20) "")
          ((>= percentage 10) "")
          ((>= percentage  0) "")))
       ((string= (get-battey-state) "charging")
        (cond
          ((>= percentage 90) "")
          ((>= percentage 80) "")
          ((>= percentage 60) "")
          ((>= percentage 40) "")
          ((>= percentage 30) "")
          ((>= percentage 20) "")
          ((>= percentage  0) "")))
       (t "?"))
     " "
     (princ-to-string percentage)
     "%%")))
