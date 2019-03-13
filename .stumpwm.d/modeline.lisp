(in-package :stumpwm)

(load-module "mycpu")
(load-module "mymem")
(load-module "myhdd")

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

(defun get-hdd-usage-modeline ()
  (remove #\Newline (run-shell-command "df / | head -n 2 | awk 'NR==2 {print $5}'" t)))

(setf *screen-mode-line-format*
      (list " ^B^3%g^n^b | "                                        ; groups
            '(:eval (when (group-windows (current-group)) "%W |"))  ; windows
            "^>"
            "   %c   %t   %m   %H"
;;            '(:eval (concat "  " (get-audio-modeline)))             ; audio
;;            '(:eval (concat "  盛 " (get-backlight-modeline)))      ; backlight
            (if (probe-file "/sys/class/power_supply/BAT0")         ; battery
                '(:eval (concat "  " (get-battery-modeline)))
                "")
            '(:eval (concat "   " (get-date-modeline)))            ; calender
            '(:eval (concat "  " (get-time-modeline)))              ; clock
            " "
            ))

(setf *mode-line-position* :bottom)
(setf *mode-line-border-width* 4)
(setf *mode-line-pad-x* 0)
(setf *mode-line-pad-y* 3)
(setf *mode-line-background-color* "Gray20")
(setf *mode-line-foreground-color* "Gray50")
(setf *mode-line-border-color* "Gray30")
(setf *mode-line-timeout* 5)

(enable-mode-line (current-screen) (current-head) t)
