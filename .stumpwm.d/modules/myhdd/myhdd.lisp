(in-package #:myhdd)

(add-screen-mode-line-formatter #\H 'fmt-hdd-usage)

(defun fmt-hdd-usage (ml)
  (declare (ignore ml))
  (with-input-from-string (in (run-shell-command "df / --output='pcent'" t))
    (read-line in)
    (string-left-trim " " (read-line in))))
