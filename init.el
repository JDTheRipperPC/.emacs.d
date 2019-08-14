;;; init.el

;; Minimal configuration in every emacs instance.
;; Improve garbage collection and load a default theme.
;; Any other configuration must be defered and only loaded if --run-ide
;; command line options is used.
;; Alternatively, alias emacs-ide=emacs --run-ide


;; Garbage collection

(defvar new-gc-cons-threshold 33554432        ; 32MB
  "The default value to use for 'gc-cons-threshold'. If you experience freezing,
decrease this. If you experience stuttering, increase this.")

(defvar new-gc-cons-upper-limit 1073741824    ; 1GB
  "The temporary value for 'gc-cons-threshold' to defer it.")

(defvar file-name-handler-alist-copy file-name-handler-alist
  "Copy of file-name-handler-alist-copy to restore it later.")

(defun restore-startup-optimizations ()
  (setq file-name-handler-alist file-name-handler-alist-copy)
  (run-with-idle-timer 3 nil (lambda () 
    (setq-default gc-cons-threshold new-gc-cons-threshold)
    (defun defer-garbage-collection () (setq gc-cons-threshold new-gc-cons-upper-limit))
    (defun restore-garbage-collection () 
      (run-at-time 1 nil (lambda () (setq gc-cons-threshold new-gc-cons-threshold))))
    (add-hook 'minibuffer-setup-hook #'defer-garbage-collection)
    (add-hook 'minibuffer-exit-hook #'restore-garbage-collection)
    (add-hook 'focus-out-hook #'garbage-collect))))

(if (ignore-errors (or after-init-time noninteractive))
    (setq gc-cons-threshold new-gc-cons-threshold)
  (setq gc-cons-threshold new-gc-cons-upper-limit)
  (setq file-name-handler-alist nil)
  (add-hook 'after-init-hook #'restore-startup-optimizations))

;; Garbage collection ends here


;; Load theme

(defvar user-emacs-dir (file-name-directory load-file-name)
  "Absolute path of the .emacs.d directory.")

(add-to-list 'custom-theme-load-path (concat user-emacs-dir "themes/zenburn"))
(load-theme 'zenburn t)

;; Load theme ends here


(defun emacs-run-ide (switch)
  (add-to-list 'load-path (concat user-emacs-dir "core"))
  (require 'core-yasnippet)
  )  ; emacs-run-ide ends here

(add-to-list 'command-switch-alist '("--run-ide" . emacs-run-ide))
