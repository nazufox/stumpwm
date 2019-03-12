(in-package :stumpwm)

(defun get-volume ()
  (multiple-value-bind (val)
      (parse-integer
       (ppcre:scan-to-strings
        "\\d+"
        (run-shell-command
         "amixer sget Master | awk '/[[0-9]+%]/ { print $(NF-1) }' | head -n 1" t)))
    val))
(defun get-mute ()
  (multiple-value-bind (mute)
      (ppcre:scan-to-strings "[a-z]+"
                             (run-shell-command
                              "amixer sget Master | awk '/[[0-9]+%]/ { print $NF }' | head -n 1" t))
    mute))

(defun get-audio-modeline ()
  (let ((vol (get-volume)))
    (concat
     (if (string= (get-mute) "off")
         "婢"
         (cond
           ((>= vol 66) "墳")
           ((>= vol 33) "奔")
           ((>= vol  0) "奄")))
     " "
     (princ-to-string vol)
     "%%")))

(defcommand mute-toggle () ()
  "Toggle the mute"
  (run-shell-command "pactl set-sink-mute 0 toggle"))

(defcommand mic-toggle () ()
  "Toggle the mute of the microphone"
  (run-shell-command "pactl set-source-mute 1 toggle"))

(defcommand vol-up () ()
  "Increase the volume"
  (when (string= "off" (get-mute))
    (mute-toggle))
  (when (< (get-volume) 100)
    (run-shell-command "pactl set-sink-volume 0 +5%"))
  (message (princ-to-string (get-volume))))

(defcommand vol-down () ()
  "Decrease the volume"
  (when (string= "off" (get-mute))
    (mute-toggle))
  (run-shell-command "pactl set-sink-volume 0 -5%")
  (message (princ-to-string (get-volume))))
