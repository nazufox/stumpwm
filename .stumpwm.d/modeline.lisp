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
        "yellow"
        "blue"
        "magenta"
        "cyan"
        "white"))
(update-color-map (current-screen))

(setf *group-format* "  %t  ")
(setf *window-format* "%m%n%s%20t ")

(setf *screen-mode-line-format*
      (list " ^B^3%g^n^b | " ; groups
            '(:eval (when (group-windows (current-group)) "%W |")) ; windows
            "^>"
            "   %c   %t   %m   %H  %A  盛 %l" ; cpu, temp, mem, hdd, audio, backlight
            (if (probe-file "/sys/class/power_supply/BAT0") ; battery
                "  %B"
                "")
            "   %d  %O "
            ))

(setf *mode-line-position* :bottom)
(setf *mode-line-border-width* 0)
(setf *mode-line-pad-x* 0)
(setf *mode-line-pad-y* 2)
(setf *mode-line-background-color* "Gray20")
(setf *mode-line-foreground-color* "Gray50")
(setf *mode-line-border-color* "Gray30")
(setf *mode-line-timeout* 5)

(enable-mode-line (current-screen) (current-head) t)

(defun restart-mode-line () (mode-line) (mode-line))
