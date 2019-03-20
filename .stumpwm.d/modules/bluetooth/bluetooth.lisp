(in-package #:bluetooth)

(add-screen-mode-line-formatter #\e 'fmt-bluetooth)

(defun read-type (dir)
  (with-open-file (in (merge-pathnames #P"type" dir) :if-does-not-exist nil)
    (when in (read in))))

(defun get-devc (dev)
  (loop :for dir :in (uiop:subdirectories #P"/sys/class/rfkill/")
        :when (string= dev (string (read-type dir)))
          :return (merge-pathnames #P"state" dir)))

(defun get-devs (dev)
  (let ((path (get-devc dev)))
    (if path
        (with-open-file (in path) (read in))
        0)))

(defun fmt-bluetooth (ml)
  (declare (ignore ml))
  (if (= (get-devs 'bluetooth) 1)
      "^B^b"
      ""))
