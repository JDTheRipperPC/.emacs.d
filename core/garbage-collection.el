;;; garbage-collection.el

;; NOTE: This is already implemented in init.el file.

(defvar new-gc-cons-threshold 33554432  ;; 16MB
  "The default value to use for 'gc-cons-threshold'. If you experience freezing,
decrease this. If you experience stuttering, increase this.")

(defvar gc-cons-upper-limit 1073741824  ;; 512MB
  "The temporary value for 'gc-cons-threshold' to defer it.")

(defvar file-name-handler-alist-copy file-name-handler-alist
  "Copy of file-name handler-alist-copy to restore it later.")

(defun restore-startup-optimizations ()
  (setq file-name-handler-alist file-name-handler-alist-copy)
  (run-with-idle-timer 3 nil (lambda ()
    (setq-default gc-cons-threshold new-gc-cons-threshold)
    (defun defer-garbage-collection () (setq gc-cons-threshold gc-cons-upper-limit))
    (defun restore-garbage-collection ()
      (run-at-time 1 nil (lambda () (setq gc-cons-threshold new-gc-cons-threshold))))
    (add-hook 'minibuffer-setup-hook #'defer-garbage-collection)
    (add-hook 'minibuffer-exit-hook #'restore-garbage-collection)
    (add-hook 'focus-out-hook #'garbage-collect))))

(if (ignore-errors (or after-init-time noninteractive))
    (setq gc-cons-threshold new-gc-cons-threshold)
  (setq gc-cons-threshold gc-cons-upper-limit)
  (setq file-name-handler-alist nil)
  (add-hook 'after-init-hook #'restore-startup-optimizations))

(provide 'garbage-collection)

;;; garbage-collection.el ends here
