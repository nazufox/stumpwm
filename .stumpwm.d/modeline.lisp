(in-package :stumpwm)

(load-module "battery-portable")

(setf battery-portable:*refresh-time* 30)

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

(defun get-date-modeline ()
  (remove #\Newline (run-shell-command (format nil "date +\"%Y-%m-%d\"") t)))
(defun get-time-modeline ()
  (remove #\Newline (run-shell-command (format nil "date +\"%k:%M\"") t)))

(setf *screen-mode-line-format*
      (list " ^B^3%g^n^b | "
            '(:eval (when (group-windows (current-group)) "%W |"))
            "^>"
            '(:eval (concat "  " (get-audio-modeline)))
            (if (probe-file "/sys/class/power_supply/BAT0")
                '(:eval (concat "  " (get-battery-modeline)))
                "")
            '(:eval (concat "   " (get-date-modeline)))
            '(:eval (concat "   " (get-time-modeline)))
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
