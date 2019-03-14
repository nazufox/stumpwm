(in-package :stumpwm)

(set-prefix-key (kbd "s-space"))


;;; *top-map*

(define-key *top-map* (kbd "XF86AudioRaiseVolume") "vol-up")
(define-key *top-map* (kbd "XF86AudioLowerVolume") "vol-down")
(define-key *top-map* (kbd "XF86AudioMute")        "toggle-mute")
(define-key *top-map* (kbd "XF86AudioMicMute")     "toggle-mic")

(define-key *top-map* (kbd "XF86MonBrightnessUp")   "bright-up")
(define-key *top-map* (kbd "XF86MonBrightnessDown") "bright-down")

(define-key *top-map* (kbd "Print") "print-screen")


;;; *root-map*

(define-key *root-map* (kbd "c")   "exec termite")
(define-key *root-map* (kbd "C-c") "exec termite")

(define-key *root-map* (kbd "s-l") "lock-screen")

(define-key *root-map* (kbd "F12") "detect-submonitor")

(define-key *root-map* (kbd "RET") "show-menu")
(define-key *root-map* (kbd "s-RET") "show-menu")
