(in-package :stumpwm)

(defvar *acpi-thermal-zone*
  (let ((proc-dir (list-directory #P"/proc/acpi/thermal_zone/"))
        (sys-dir (sort
                  (remove-if-not
                   (lambda (x)
                     (when (ppcre:scan "^.*/thermal_zone\\d+/" (namestring x)) x))
                   (list-directory #P"/sys/class/thermal/"))
                  #'string< :key #'namestring)))
    (cond
      (proc-dir
       (cons :procfs
             (make-pathname :directory (pathname-directory (first proc-dir))
                            :name "temperature")))
      (sys-dir
       (cons :sysfs
             (make-pathname :directory (pathname-directory (first sys-dir))
                            :name "temp"))))))

(defun get-proc-file-field (fname field)
  (with-open-file (s fname :if-does-not-exist nil)
    (if s
        (do ((line (read-line s nil nil) (read-line s nil nil)))
            ((null line) nil)
          (let ((split (ppcre:split "\\s*:\\s*" line)))
            (when (string= (car split) field) (return (cadr split)))))
        "")))

(let ((prev-time 0)
      (prev-user-cpu 0)
      (prev-sys-cpu 0)
      (prev-idle-cpu 0)
      (prev-iowait 0)
      (prev-result '(0 0 0)))
  (defun current-cpu-usage ()
    (let ((cpu-result 0)
          (sys-result 0)
          (io-result nil)
          (now (/ (get-internal-real-time) internal-time-units-per-second)))
      (when (>= (- now prev-time) 1)
        (setf prev-time now)
        (with-open-file (in #P"/proc/stat" :direction :input)
          (read in)
          (let* ((norm-user (read in))
                 (nice-user (read in))
                 (user (+ norm-user nice-user))
                 (sys (read in))
                 (idle (read in))
                 (iowait (or (ignore-errors (read in)) 0))
                 (step-denom (- (+ user sys idle iowait)
                                (+ prev-user-cpu prev-sys-cpu prev-idle-cpu prev-iowait))))
            (unless (zerop step-denom)
              (setf cpu-result (/ (- (+ user sys)
                                     (+ prev-user-cpu prev-sys-cpu))
                                  step-denom)
                    sys-result (/ (- sys prev-sys-cpu)
                                  step-denom)
                    io-result (/ (- iowait prev-iowait)
                                 step-denom)
                    prev-user-cpu user
                    prev-sys-cpu sys
                    prev-idle-cpu idle
                    prev-iowait iowait
                    prev-result (list cpu-result sys-result io-result)))))))
    (apply 'values prev-result)))

(defun get-cpu-usage-modeline ()
  (let ((cpu (truncate (* 100 (current-cpu-usage)))))
    (format nil "~d%%" cpu)))

(defun get-cpu-temp-modeline ()
  (format nil "~d℃"
          (case (car *acpi-thermal-zone*)
            (:procfs (parse-integer
                      (get-proc-file-field (cdr *acpi-thermal-zone*) "temperature")
                      :junk-allowed t))
            (:sysfs (with-open-file (f (cdr *acpi-thermal-zone*))
                      (/ (read f) 1000))))))
