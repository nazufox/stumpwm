(in-package :stumpwm)

(load-module "mycpu")
(load-module "mymem")
(load-module "myhdd")
(load-module "mybattery")
(load-module "date-time")

(setf *bar-med-color*  "^B")
(setf *bar-hi-color*   "^B^3")
(setf *bar-crit-color* "^B^1")

(setf *colors*
      '("black"
        "red"
        "green"
        "#FFFC78"
        "blue"
        "magenta"
        "cyan"
        "white"))
(update-color-map (current-screen))

(setf *group-format* "  %t  ")
(setf *window-format* "%m%n%s%20t ")

(setf *screen-mode-line-format*
      (list " ^B^3%g^n | " ; groups
            '(:eval (when (group-windows (current-group)) "%W |")) ; windows
            "^>"
            "^B   %c   %t   %m   %H  %A  盛 %l" ; cpu, temp, mem, hdd, audio, backlight
            (if (probe-file "/sys/class/power_supply/BAT0") ; battery
                "  %B"
                "")
            "   %d  %O ^b"
            ))

(setf *mode-line-position* :bottom)
(setf *mode-line-border-width* 3)
(setf *mode-line-pad-x* 0)
(setf *mode-line-pad-y* 4)
(setf *mode-line-background-color* "#ef708e")
(setf *mode-line-foreground-color* "#fbc6d2")
(setf *mode-line-border-color* "#f8a8bb")
(setf *mode-line-timeout* 5)

(enable-mode-line (current-screen) (current-head) t)

(defun restart-mode-line () (mode-line) (mode-line))
