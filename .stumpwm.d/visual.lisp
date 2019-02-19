(in-package :stumpwm)

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
