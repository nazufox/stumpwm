(in-package #:date-time)

(add-screen-mode-line-formatter #\d 'fmt-date)
(add-screen-mode-line-formatter #\o 'fmt-time)
(add-screen-mode-line-formatter #\O 'fmt-time-with-icon)

(defun get-time-list ()
  (multiple-value-list (decode-universal-time (get-universal-time))))

(defun fmt-date (ml)
  (declare (ignore ml))
  (let* ((time-list (get-time-list))
         (year  (nth 5 time-list))
         (month (nth 4 time-list))
         (date  (nth 3 time-list)))
    (format nil "~d-~2,'0d-~d" year month date)))

(defun fmt-time (ml)
  (declare (ignore ml))
  (let* ((time-list (get-time-list))
         (hour   (nth 2 time-list))
         (minute (nth 1 time-list)))
    (format nil "~d:~d" hour minute)))

(defun time-icon (hour)
  (case hour
    (1  #\) (2  #\) (3  #\) (4  #\) (5  #\) (6  #\)
    (7  #\) (8  #\) (9  #\) (10 #\) (11 #\) (12 #\)))

(defun fmt-time-with-icon (ml)
  (declare (ignore ml))
  (let* ((time-list (get-time-list))
         (hour   (nth 2 time-list))
         (minute (nth 1 time-list)))
    (format nil "~c ~d:~d" (time-icon hour) hour minute)))
