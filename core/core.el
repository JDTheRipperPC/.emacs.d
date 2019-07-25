;;; core.el

(eval-when-compile
  (and (version < emacs-version "25.3")
       (error "Detected Emacs %s. Emacs 25.3 or higher is required." 
              emacs-version)))

(defvar is-debug-on (or (getenv "DEBUG") init-file-debug))

(defconst EMACS26+ (> emacs-major-version 25))
(defconst EMACS27+ (> emacs-major-version 26))

(defconst IS-MAC     (eq system-type 'darwin))
(defconst IS-LINUX   (eq system-type 'gnu/linux))
(defconst IS-WINDOWS (memq system-type '(cygwin windows-nt ms-dos)))
(defconst IS-BSD     (or IS-MAC (eq system-type 'berkeley-unix)))


;; emacs directories

; user-emacs-dir (.emacs.d absolute path)

(defvar emacs-core-dir (concat user-emacs-dir "core/")
  "Emacs configuration core directory.")

(defvar emacs-themes-dir (concat user-emacs-dir "themes/")
  "Emacs themes directory.")

(defvar emacs-snippets-dir (concat user-emacs-dir "snippets/")
  "Snippets directory.")

(defvar emacs-etc-dir (concat user-emacs-dir "etc/")
  "Non-volatile local storage directory.")

(defvar emacs-cache-dir (concat user-emacs-dir "cache/")
  "Volatile local storage directory.")


;; UTF-8 as the default coding system
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))     ; pretty
(prefer-coding-system 'utf-8)          ; pretty
(setq locale-coding-system 'utf-8)     ; please
(unless IS-WINDOWS
  (setq selection-coding-system 'utf-8))  ; with sugar on top

(setq-default ad-redefinition-action 'accept ; silence redefined function warns
              apropos-do-all t ; make 'apropos' more useful (may be slow)
              auto-mode-case-fold nil ; don't be case sensitive
              autoload-compute-prefixes nil ; ignore prefixes
              debug-on-error is-debug-on ; it depends
              jka-compr-verbose t ; silence compression messages (stfu)
              find-file-visit-truename t ; resolve symlinks when opening files
              idle-update-delay 1 ; update ui slightly less often
              ; stfu at startup
              inhibit-startup-message t
              inhibit-startup-echo-area-message user-login-name
              inhibit-default-init t
              initial-major-mode 'fundamental-mode
              initial-scratch-message nil ; TODO: i would like play with this
              ; history & backup settings (save nothing, that's what git is for)
              auto-save-default nil
              create-lockfiles nil
              history-length 500
              make-backup-files nil
              ; byte compilation
              byte-compile-verbose is-debug-on
              byte-compile-warnings '(not free-vars unresolved noruntime lexical make-local)
              ; security
              ; gnutls-verify-error (not (getenv "INSECURE")) ; (?)
              tls-checktrust gnutls-verify-error
              tls-program (list "gnutls-cli --x509cafile %t -p %p %h"
                           ;; compatibility fallbacks
                           "gnutls-cli -p %p %h"
                           "openssl s_client -connect %h:%p -no_ssl2 -no_ssl3 -ign_eof")
              auth-sources (list (expand-file-name "authinfo.gpg" emacs-etc-dir)
                                 "~/.authinfo.gpg")
  )