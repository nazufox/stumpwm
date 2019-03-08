(in-package :stumpwm)

(defun get-volume ()
  (ppcre:scan-to-strings "\\d+"
                         (run-shell-command
                          "amixer sget Master | awk '/[[0-9]+%]/ { print $(NF-1) }' | head -n 1" t)))
(defun get-mute ()
  (ppcre:scan-to-strings "[a-z]+"
                         (run-shell-command
                          "amixer sget Master | awk '/[[0-9]+%]/ { print $NF }' | head -n 1" t)))

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
  (when (< (parse-integer (get-volume)) 100)
    (run-shell-command "pactl set-sink-volume 0 +5%"))
  (message (get-volume)))

(defcommand vol-down () ()
  "Decrease the volume"
  (when (string= "off" (get-mute))
    (mute-toggle))
  (run-shell-command "pactl set-sink-volume 0 -5%")
  (message (get-volume)))
