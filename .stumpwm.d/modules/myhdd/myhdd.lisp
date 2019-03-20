(in-package #:myhdd)

(add-screen-mode-line-formatter #\H 'fmt-hdd-usage)

(defun fmt-hdd-usage (ml)
  (declare (ignore ml))
  (multiple-value-bind (total free avail)
      (disk-space "/")
    (declare (ignore free))
    (format nil "~d%" (truncate (* 100 (/ (- total avail) total))))))
