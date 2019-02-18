(in-package :stumpwm)

(set-module-dir
 (pathname-as-directory (concat (getenv "HOME")
                                "/.stumpwm.d/stumpwm-contrib")))

(set-prefix-key (kbd "s-space"))

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

(define-key *top-map* (kbd "XF86AudioRaiseVolume") "vol-up")
(define-key *top-map* (kbd "XF86AudioLowerVolume") "vol-down")
(define-key *top-map* (kbd "XF86AudioMute")        "mute-toggle")
(define-key *top-map* (kbd "XF86AudioMicMute")     "mic-toggle")

(define-key *top-map* (kbd "XF86MonBrightnessUp")   "bright-up")
(define-key *top-map* (kbd "XF86MonBrightnessDown") "bright-down")

(define-key *root-map* (kbd "c")   "exec termite")
(define-key *root-map* (kbd "C-c") "exec termite")

(define-key *root-map* (kbd "Print") "print-screen")

(define-key *root-map* (kbd "s-l") "lock-screen")

(define-key *root-map* (kbd "F12") "detect-submonitor")


;;; Visual appearance and the mode-line

(load-module "cpu")
(load-module "net")
(load-module "battery-portable")

(defvar battery-mode-sting "")

(when (probe-file "/sys/class/power_supply/BAT0")
  (setf battery-mode-string " ^7*%B"
        battery-portable:*refresh-time* 30))

(set-normal-gravity :bottom)

(setf *message-window-gravity* :center
      *input-window-gravity* :center

      *window-info-format* (format nil "^>^B^5*%c ^b^6%w^7*~%%t")

      *time-format-string-default* (format nil "^5*%H:%M:%S~%^2*%A~%^7%d %B")

      *mode-line-timeout* 5
      *screen-mode-line-format*
      '("^5*" (:eval (time-format "%k:%M"))
        " ^2*%n" ; group name
        " ^7*%C" ; cpu
        " ^6*%l" ; net
        battery-mode-string)

      *mouse-focus-policy* :sloppy)

(enable-mode-line (current-screen) (current-head) t)
