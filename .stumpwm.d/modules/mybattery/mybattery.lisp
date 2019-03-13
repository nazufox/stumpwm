(in-package #:mybattery)

(add-screen-mode-line-formatter #\b 'fmt-battery-remaining)
(add-screen-mode-line-formatter #\B 'fmt-battery-remaining-with-icon)

(defun battery-capacity ()
  (with-open-file (in #P"/sys/class/power_supply/BAT0/capacity" :direction :input)
    (read in)))

(defun battery-status ()
  (with-open-file (in #P"/sys/class/power_supply/BAT0/status" :direction :input)
    (read-line in)))

(defun fmt-battery-remaining (ml)
  (declare (ignore ml))
  (format nil "~d%" (battery-capacity)))

(defun discharging-icon (capacity)
  (cond ((>= capacity 90) #\)
        ((>= capacity 80) #\)
        ((>= capacity 70) #\)
        ((>= capacity 60) #\)
        ((>= capacity 50) #\)
        ((>= capacity 40) #\)
        ((>= capacity 30) #\)
        ((>= capacity 20) #\)
        ((>= capacity 10) #\)
        ((>= capacity  0) #\)))

(defun charging-icon (capacity)
  (cond ((>= capacity 90) #\)
        ((>= capacity 80) #\)
        ((>= capacity 60) #\)
        ((>= capacity 40) #\)
        ((>= capacity 30) #\)
        ((>= capacity 20) #\)
        ((>= capacity  0) #\)))

(defun status-icon (status capacity)
  (cond ((string= status "Discharging")
         (discharging-icon capacity))
        ((string= status "Charging")
         (charging-icon capacity))
        (t #\?)))

(defun fmt-battery-remaining-with-icon (ml)
  (declare (ignore ml))
  (let ((capacity (battery-capacity))
        (status   (battery-status)))
    (format nil "~c ~d%" (status-icon status capacity) capacity)))
