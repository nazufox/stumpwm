(in-package #:fcitx)

(add-screen-mode-line-formatter #\f 'fmt-fcitx)

(defvar *state-message*
  '("--" "en" "ja"))

(defun fcitx-state ()
  (nth-value 0 (parse-integer (run-shell-command "fcitx-remote" t))))

(defun fmt-fcitx (ml)
  (declare (ignore ml))
  (nth (fcitx-state) *state-message*))
