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

(defcommand bright-up () ()
  "Increase the monitor brightness"
  (run-shell-command "xbacklight -inc 10"))
(defcommand bright-down () ()
  "Decrease the monitor brightness"
  (run-shell-command "xbacklight -dec 10"))

(defcommand print-screen () ()
  "Print the screen"
  (run-shell-command "import -window root png:$HOME/screenshot_$(date +%F_%H%M%S).png"))

(defcommand lock-screen () ()
  "Lock the screen"
  (run-shell-command "light-locker-command -l"))

(defcommand detect-submonitor () ()
  "Enable the sub monitor when HDMI is connected"
  (if (zerop (length (run-shell-command "xrandr | grep \"HDMI1 connected\"" t)))
      (run-shell-command "xrandr --output HDMI1 --off")
      (run-shell-command "xrandr --output HDMI1 --auto --right-of eDP1")))
