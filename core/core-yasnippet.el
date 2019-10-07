;;; yasnippet.el

;; Load yasnippet tables and set yasnippet as minor mode

;; Modes with yasnippet enabled:
;;
;; python-mode

(add-to-list 'load-path (concat user-emacs-dir "snippets/yasnippet"))

(require 'yasnippet)

(yas-reload-all)

(add-hook 'python-mode-hook #'yas-minor-mode)
(add-hook 'html-mode-hook #'yas-minor-mode)

(provide 'core-yasnippet)

;;; yasnippet.el ends here
