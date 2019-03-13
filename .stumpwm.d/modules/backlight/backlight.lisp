(in-package #:backlight)

(add-screen-mode-line-formatter #\l 'fmt-backlight)

(defvar *max-brightness*
  (with-open-file (in #P"/sys/class/backlight/intel_backlight/max_brightness") (read in)))

(defun current-brightness ()
  (with-open-file (in #P"/sys/class/backlight/intel_backlight/brightness")
    (read in)))

(defun current-brightness-pcent ()
  (truncate (* 100 (/ (current-brightness) *max-brightness*))))

(defun set-brightness (brightness)
  (run-shell-command (format nil "xbacklight -set ~a" brightness)))

(defun fmt-backlight (ml)
  (declare (ignore ml))
  (format nil "~d%" (current-brightness-pcent)))

(defcommand bright-up () ()
  (set-brightness (+ (current-brightness-pcent) 5)))

(defcommand bright-down () ()
  (set-brightness (- (current-brightness-pcent) 5)))
