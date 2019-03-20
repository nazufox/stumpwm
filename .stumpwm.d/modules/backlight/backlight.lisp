(in-package #:backlight)

(add-screen-mode-line-formatter #\l 'fmt-backlight)
(add-screen-mode-line-formatter #\L 'fmt-backlight-with-icon)

(defvar *max-brightness*
  (with-open-file (in #P"/sys/class/backlight/intel_backlight/max_brightness") (read in)))

(defun current-brightness ()
  (with-open-file (in #P"/sys/class/backlight/intel_backlight/brightness")
    (read in)))

(defun current-brightness-pcent ()
  (truncate (* 100 (/ (current-brightness) *max-brightness*))))

(defun set-brightness (brightness)
  (run-shell-command (format nil "xbacklight -set ~a" brightness)))

(defun brightness-icon (brightness)
  (cond ((>= brightness 66) #\)
        ((>= brightness 33) #\)
        ((>= brightness  0) #\)))

(defun fmt-backlight (ml)
  (declare (ignore ml))
  (format nil "~d%" (current-brightness-pcent)))

(defun fmt-backlight-with-icon (ml)
  (declare (ignore ml))
  (let ((brightness (current-brightness-pcent)))
    (format nil "~c ~d%" (brightness-icon brightness) brightness)))

(defun echo-brightness (brightness)
  (echo (princ-to-string brightness)))

(defcommand bright-up () ()
  (let ((brightness-pcent (min (+ (current-brightness-pcent) 5) 100)))
    (set-brightness brightness-pcent)
    (echo-brightness brightness-pcent)))

(defcommand bright-down () ()
  (let ((brightness-pcent (max (- (current-brightness-pcent) 5) 0)))
    (set-brightness brightness-pcent)
    (echo-brightness brightness-pcent)))
