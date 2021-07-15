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

(use-package ayu-theme
  :config (load-theme 'ayu-light t))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq @code-font "Menlo")
(setq @text-font "Cardo")
(setq @font-height 160)

(set-face-attribute 'default nil :family @code-font :height @font-height)
(defun @text-mode-setup ()
  (face-remap-add-relative 'default nil :family @text-font :height @font-height))
(add-hook 'text-mode-hook '@text-mode-setup)
