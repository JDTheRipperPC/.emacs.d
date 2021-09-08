;;; straight.el

;; Prevent package.el loading packages prior to their init-file loading
(setq package-enable-at-startup nil)

(defvar bootstrap-version)

(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


;; Settings

(setq initial-frame-alist '((fullscreen . maximized)))
(setq inhibit-startup-message t)
(setq column-number-mode t)

(setq large-file-warning-threshold nil)           ; Don't warn for large files
(setq vc-follow-symlinks t)                       ; Don't warn for following symlinked files
;;(setq ad-redefinition-action 'accept)             ; Don't warn when advice is added for functions

(scroll-bar-mode -1)  ;; disable visible scrollbar
(tool-bar-mode -1)    ;; disable the toolbar
(tooltip-mode -1)     ;; disable tooltips
(menu-bar-mode -1)    ;; disable the menu bar

(defalias 'yes-or-no-p 'y-or-n-p)

;; Set scroll up to one line
(setq scroll-conservatively 1)

;; Keep cursor at same position when scrolling
(setq scroll-preserve-screen-position 1)

;; Scroll window up/down by one line
(global-set-key (kbd "<M-down>") (kbd "C-u 1 C-v"))
(global-set-key (kbd "<M-up>") (kbd "C-u 1 M-v"))



;; Theme

(straight-use-package '(zenburn :type git :host github :repo "bbatsov/zenburn-emacs"))

(setq zenburn-use-variable-pitch t)               ; use variable-pitch fonts for some headings and titles
(setq zenburn-scale-org-headline t)               ; scale headings in org-mode
(setq zenburn-scale-outline-headlines t)          ; scale headings in outline-mode

(load-theme 'zenburn t)



;; All the Icons

;; TODO:
;; - Install fonts automatically
;; - on windows, it may require some extra lips function or script execution

(straight-use-package '(all-the-icons :type git :host github :repo "domtronn/all-the-icons.el"))
(require 'all-the-icons)

;;(all-the-icons-install-fonts 1)


;;; Libraries (utils)

;; dash
(straight-use-package '(dash :type git :host github :repo "magnars/dash.el"))
(require 'dash)

;; transient
(straight-use-package '(transient :type git :host github :repo "magit/transient"))
(require 'transient)

;; with-editor
(straight-use-package '(with-editor :type git :host github :repo "magit/with-editor"))
(require 'with-editor)


;; Neotree

(straight-use-package '(neotree :type git :host github :repo "jaypei/emacs-neotree"))

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

(require 'neotree)


;;; Ivy
(straight-use-package '(ivy :type git :host github :repo "abo-abo/swiper"))
(ivy-mode)


;;; Git (Magit)
(straight-use-package '(magit :type git :host github :repo "magit/magit"))
(require 'magit)


;;; Global Keybinding

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key [f8] 'neotree-toggle)



;;; Languages

;; Lua
;;
;; Use immerrr/lua-mode as a major mode for editing Lua sources
(straight-use-package '(lua-mode :type git :host github :repo "immerrr/lua-mode"))

(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(setq lua-indent-level 4)          ; Indentation offset in spaces (3 by default)
