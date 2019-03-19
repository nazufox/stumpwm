(in-package #:mynet)

(add-screen-mode-line-formatter #\i 'fmt-wifi-icon)
(add-screen-mode-line-formatter #\I 'fmt-eth-icon)

(defun get-state-of (dev)
  (with-open-file (in (format nil "/sys/class/net/~a/carrier" dev))
    (read in)))

(defun wifi-state ()
  (not (zerop (get-state-of "wlp5s0"))))
(defun eth-state ()
  (not (zerop (get-state-of "enp3s0"))))

(defun fmt-wifi-icon (ml)
  (declare (ignore ml))
  (if (wifi-state) "直" "睊"))
(defun fmt-eth-icon (ml)
  (declare (ignore ml))
  (if (eth-state) "" ""))
