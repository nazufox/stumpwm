(in-package :stumpwm)

;;(load-module "swm-gaps")
(load-module "mycpu")
(load-module "mymem")
(load-module "myhdd")
(load-module "mynet")
(load-module "mybattery")
(load-module "date-time")
(load-module "bluetooth")

(setf *bar-med-color*  "^B")
(setf *bar-hi-color*   "^B^3")
(setf *bar-crit-color* "^B^1")

(setf *colors*
      '("black"
        "red"
        "green"
        "#FFFC78"
        "blue"
        "#ef708e"
        "cyan"
        "white"))
(update-color-map (current-screen))

(setf *group-format* "  %t  ")
(setf *window-format* "%m%n%s%15t ")

(setf *screen-mode-line-format*
      (list "^f1 ^B^3%g^n^b | " ; groups
            '(:eval (when (group-windows (current-group)) "^B%W^b ^f1|")) ; windows
            "^>"
            "^f1| ^B %c   %t   %m   %H  %A  %L^b" ; cpu, temp, mem, hdd, audio, backlight
            (if (probe-file "/sys/class/power_supply/BAT0") ; battery
                "  ^B%B^b"
                "")
            " | %I  %i  %e | ^B%d %o^b " ; eth, wifi, bluetooth, date, time
            ))

(setf *mode-line-position* :bottom)
(setf *mode-line-border-width* 0)
(setf *mode-line-pad-x* 0)
(setf *mode-line-pad-y* 4)
(setf *mode-line-background-color* "#ef708e")
(setf *mode-line-foreground-color* "#fbc6d2")
(setf *mode-line-border-color* "#f8a8bb")
(setf *mode-line-timeout* 5)

;;(setf swm-gaps:*inner-gaps-size* 10)
;;(setf swm-gaps:*outer-gaps-size* 10)

(enable-mode-line (current-screen) (current-head) t)
;;(swm-gaps:toggle-gaps)

(defun restart-mode-line () (mode-line) (mode-line))
