(in-package #:date-time)

(add-screen-mode-line-formatter #\d 'fmt-date)
(add-screen-mode-line-formatter #\o 'fmt-time)
(add-screen-mode-line-formatter #\O 'fmt-time-with-icon)

(defun fmt-date (ml)
  (declare (ignore ml))
  (time-format "%F"))

(defun fmt-time (ml)
  (declare (ignore ml))
  (time-format "%R"))

(defun time-icon (hour)
  (case hour
    (1  #\) (2  #\) (3  #\) (4  #\) (5  #\) (6  #\)
    (7  #\) (8  #\) (9  #\) (10 #\) (11 #\) (12 #\)))

(defun fmt-time-with-icon (ml)
  (declare (ignore ml))
  (let ((hour (rem (getf (stumpwm::time-plist) :hour) 12)))
    (format nil "~c ~a" (time-icon (if (zerop hour) 12 hour)) (time-format "%R"))))
