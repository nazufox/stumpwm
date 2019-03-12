(in-package :stumpwm)

(defun get-battery-percentage ()
  (let ((val (ppcre:scan-to-strings
              "\\d+"
              (run-shell-command
               "upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep \"percentage\"" t))))
    (if val val "0")))

(defun get-battey-state ()
  (remove
   #\Newline
   (run-shell-command
    "upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'state' | awk '{ print $2 }'" t)))

(defun get-battery-modeline ()
  (let* ((percentage-str (get-battery-percentage))
         (percentage (parse-integer percentage-str)))
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
     percentage-str
     "%%")))
