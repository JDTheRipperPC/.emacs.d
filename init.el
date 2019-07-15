;;; init.el

;; TODO: improve the gc

(defvar user-emacs-dir (file-name-directory load-file-name)
  "xD")
(add-to-list 'custom-theme-load-path (concat user-emacs-dir "themes/zenburn"))
(load-theme 'zenburn t)

;; TODO: Defere it
(add-to-list 'load-path (concat user-emacs-dir "snippets/yasnippet"))
(require 'yasnippet)
(yas-reload-all)
(add-hook 'python-mode-hook #'yas-minor-mode)
