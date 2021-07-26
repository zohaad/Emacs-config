(let ((bootstrap-file (concat user-emacs-directory "straight/repos/straight.el/bootstrap.el"))
    (bootstrap-version 3))
    (unless (file-exists-p bootstrap-file)
      (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
       'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default t)
(straight-use-package 'use-package)
(use-package git)

(setq custom-file (make-temp-file ""))

; autosaves
(defvar emacs-autosave-directory
  (concat user-emacs-directory "autosaves/")
  "This variable dictates where to put auto saves. It is set to a
directory called autosaves located wherever your .emacs.d/ is
located.")
(unless (file-exists-p emacs-autosave-directory)
  (make-directory emacs-autosave-directory))
(setq auto-save-file-name-transforms `((".*"
					,emacs-autosave-directory t)))
(setq auto-save-timeout 20 ; set save interval
      auto-save-interval 20)
(setq auto-save-default t) ; autosave every buffer that visits a file
(setq create-lockfiles nil) ; disable lockfiles

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(use-package ayu-theme
  :config (load-theme 'ayu-light t))

; different fonts for text and code
(setq @code-font "Menlo")
(setq @text-font "Fira Code")
(setq @font-height 160)

(set-face-attribute 'default nil :family @code-font :height @font-height)
(defun @text-mode-setup ()
  (face-remap-add-relative 'default nil :family @text-font :height @font-height))
(add-hook 'text-mode-hook '@text-mode-setup)

; org-mode keybinds
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

; org-mode indentation
(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook 'org-indent-mode)

; auto-complete
(use-package company
  :init (add-hook 'after-init-hook 'global-company-mode))

; macOS specific
(use-package exec-path-from-shell
  :init (exec-path-from-shell-initialize))

(use-package yasnippet)
(setq yas-snippet-dirs
      (list (concat (file-name-as-directory user-emacs-directory)
		    "snippets")))
(yas-global-mode 1)
(setq yas-triggers-in-field t) ; allow nested snippets
