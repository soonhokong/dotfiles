;;; Emacs Initialization file
;;; Soonho Kong <soonho.kong@gmail.com>
(require 'package)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(when (version< emacs-version "27.0") (package-initialize))

;; Ignore "following symbolic link warning"
(setq vc-handled-backends nil)

;; use-package
(unless (package-installed-p 'use-package) (package-refresh-contents)
  (package-install 'use-package)
  (package-install 'diminish)
  (package-install 'bind-key))
(setq use-package-always-ensure t)
(setq use-package-verbose t)

(add-to-list 'load-path "~/.emacs.d/local")

(eval-when-compile
  (require 'use-package))
(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant

(use-package org
  :ensure org-plus-contrib
  :config
    (setq org-src-tab-acts-natively t)
    (setq org-src-fontify-natively t))

;; ----------------------
;; Load settings.org file
;; ----------------------
(org-babel-load-file (expand-file-name (concat user-emacs-directory "settings.org")))

;; -------------------------
;; Custom
;; -------------------------
(setq custom-file (expand-file-name "~/.emacs.d/custom.el"))
(if (file-exists-p custom-file) (load custom-file))

