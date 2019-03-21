(in-package #:audio)

(add-screen-mode-line-formatter #\a 'fmt-audio)
(add-screen-mode-line-formatter #\A 'fmt-audio-with-icon)

(defun parse-status (status-output)
  (ppcre:scan-to-strings  ".*\\[([0-9]+)%\\].*\\[(on|off)\\]\\n" status-output))

(defun current-status ()
  (nth-value 1 (parse-status (run-shell-command "amixer sget Master" t))))

(defparameter *audio-status* (current-status))

(defun status-control (&key amount mute)
  (let* ((output (run-shell-command
                  (format nil "amixer sset Master ~a" (or amount mute "toggle")) t))
         (status (nth-value 1 (parse-status output)))
         (volume (aref status 0)))
    (setf (aref status 0) (parse-integer volume))
    (setf *audio-status* status)
    (echo (aref status 0))))

(defun fmt-audio (ml)
  (declare (ignore ml))
  (format nil "~a%" (aref *audio-status* 0)))

(defun volume-icon (volume)
  (cond ((>= volume 66) #\墳)
        ((>= volume 33) #\奔)
        ((>= volume  0) #\奄)))

(defun status-icon (volume mute)
  (if (string= mute "off")
      #\婢
      (volume-icon volume)))

(defun fmt-audio-with-icon (ml)
  (declare (ignore ml))
  (let ((volume (aref *audio-status* 0))
        (mute   (aref *audio-status* 1)))
    (format nil "~c ~a%" (status-icon volume mute) volume)))

(defcommand toggle-mute () ()
  (status-control))

(defcommand toggle-mic () ()
  (run-shell-command "pactl set-source-mute 1 toggle"))

(defun mute-p (status)
  (string= (aref status 1) "off"))

(defcommand vol-up () ()
  (when (mute-p *audio-status*) (status-control))
  (status-control :amount "5%+"))

(defcommand vol-down () ()
  (when (mute-p *audio-status*) (status-control))
  (status-control :amount "5%-"))
