(in-package :stumpwm)

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
