(in-package :stumpwm)

(defcommand vol-up () ()
  "Increase the volume"
  (run-shell-command "pactl set-sink-volume 0 +5%"))
(defcommand vol-down () ()
  "Decrease the volume"
  (run-shell-command "pactl set-sink-volume 0 -5%"))
(defcommand mute-toggle () ()
  "Toggle the mute"
  (run-shell-command "pactl set-sink-mute 0 toggle"))
(defcommand mic-toggle () ()
  "Toggle the mute of the microphone"
  (run-shell-command "pactl set-source-mute 1 toggle"))

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
