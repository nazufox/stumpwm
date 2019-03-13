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

(defun echo-brightness (brightness)
  (echo (princ-to-string brightness)))

(defcommand bright-up () ()
  (let ((brightness-pcent (+ (current-brightness-pcent) 5)))
    (set-brightness brightness-pcent)
    (echo-brightness brightness-pcent)))

(defcommand bright-down () ()
  (let ((brightness-pcent (- (current-brightness-pcent) 5)))
    (set-brightness brightness-pcent)
    (echo-brightness brightness-pcent)))
