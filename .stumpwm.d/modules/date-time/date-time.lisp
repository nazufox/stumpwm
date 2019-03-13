(in-package #:date-time)

(add-screen-mode-line-formatter #\d 'fmt-date)
(add-screen-mode-line-formatter #\o 'fmt-time)
(add-screen-mode-line-formatter #\O 'fmt-time-with-icon)

(defun fmt-date (ml)
  (declare (ignore ml))
  (time-format "%Y-%m-%d"))

(defun fmt-time (ml)
  (declare (ignore ml))
  (time-format "%k:%M"))

(defun time-icon (hour)
  (case hour
    (1  #\) (2  #\) (3  #\) (4  #\) (5  #\) (6  #\)
    (7  #\) (8  #\) (9  #\) (10 #\) (11 #\) (12 #\)))

(defun fmt-time-with-icon (ml)
  (declare (ignore ml))
  (let ((hour (parse-integer (stumpwm::time-hour-12hr))))
    (format nil "~c ~a" (time-icon hour) (time-format "%k:%M"))))
