(in-package #:mymem)

(add-screen-mode-line-formatter #\m 'fmt-mem-usage)

(defun current-mem-usage ()
  (with-open-file (in #P"/proc/meminfo" :direction :input)
    (let* ((mem-total (parse-integer (ppcre:scan-to-strings "\\d+" (read-line in))))
           (mem-free  (parse-integer (ppcre:scan-to-strings "\\d+" (read-line in))))
           (mem-used  (- mem-total mem-free)))
      (/ mem-used mem-total))))

(defun fmt-mem-usage (ml)
  (declare (ignore ml))
  (let ((mem (truncate (* 100 (current-mem-usage)))))
    (format nil "~d%" mem)))
