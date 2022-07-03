(setq inhibit-startup-message t)

(scroll-bar-mode -1)          ; Disable visible scrollbar
(tool-bar-mode -1)            ; Disable the toolbar
(tooltip-mode -1)             ; Disable tooltips
(set-fringe-mode 10)          ; Give some breathing room
(menu-bar-mode -1)            ; Disable the menu bar
(setq visible-bell t)         ; Set up the visible bell
(global-visual-line-mode t)   ; Wrap lines
(column-number-mode)          ; Show column number in modeline

(global-display-line-numbers-mode t)

;; Disable linenumbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

(set-face-attribute 'default nil :font "Fira Code Retina" :height 120)

(load-theme 'wombat)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(setq custom-file "~/.emacs.d/custom.el")
(setq custom-safe-themes t)

(setq frame-title-format '("" "%b" " / Emacs"))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         :map ivy-switch-buffer-map
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package swiper)
(use-package counsel
  :bind (("C-x C-f" . counsel-find-file)
         ("M-x"     . counsel-M-x)
	 ("C-x b"   . counsel-ibuffer)
	 :map minibuffer-local-map
	 ("C-r"     . counsel-minibuffer-history)))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package ess
  :ensure t
  :init (require 'ess-site))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-init-delay 0.3))

