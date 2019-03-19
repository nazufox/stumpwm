(in-package #:bluetooth)

(add-screen-mode-line-formatter #\e 'fmt-bluetooth)

(defun current-state ()
  (ppcre:scan-to-strings "on|off" (run-shell-command "bluetooth" t)))

(defun fmt-bluetooth (ml)
  (declare (ignore ml))
  (if (string= (current-state) "on")
      ""
      ""))
