(in-package :stumpwm)

(defun get-date-modeline ()
  (time-format "%Y-%m-%d"))

(defun get-time-modeline ()
  (let ((hour (parse-integer (time-hour-12hr))))
    (concat
     (case hour
       (1  "") (2  "") (3  "") (4  "") (5  "") (6  "")
       (7  "") (8  "") (9  "") (10 "") (11 "") (12 ""))
     " "
     (time-format "%k:%M"))))
