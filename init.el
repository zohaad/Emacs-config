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
(setq make-backup-files nil) ; disable ~ files 

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(use-package ayu-theme
  :config (load-theme 'ayu-light t))

(setq vc-follow-symlinks t)

; different fonts for text and code
(setq @code-font "Menlo")
(setq @text-font "Iosevka Extended")
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
  :config (add-hook 'after-init-hook 'global-company-mode))

; macOS specific
(use-package exec-path-from-shell
  :init (exec-path-from-shell-initialize))

(use-package yasnippet)
(setq yas-snippet-dirs
      (list (concat (file-name-as-directory user-emacs-directory)
		    "snippets")))
(yas-global-mode 1)
(setq yas-triggers-in-field t) ; allow nested snippets

(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
	       '("acmart"
		 "\\documentclass{acmart}
		 [NO-DEFAULT-PACKAGES]
		 [PACKAGES]
		 [EXTRA]"
		 ("\\section{%s}" . "\\section*{%s}")
		 ("\\subsection{%s}" . "\\subsection*{%s}")
		 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
		 ("\\paragraph{%s}" . "\\paragraph*{%s}")
		 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(setq org-latex-logfiles-extensions
      (quote ("lof" "lot" "tex~" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl")))


; screen centering
; from: https://christiantietze.de/posts/2021/06/emacs-center-window-single-function/
;; (defun @frame-recenter (&optional frame)
;;   "Center FRAME on the screen.
;; FRAME can be a frame name, a terminal name, or a frame.
;; If FRAME is omitted or nil, use currently selected frame."
;;   (interactive)
;;   (unless (eq 'maximised (frame-parameter nil 'fullscreen))
;;     (let* ((frame (or (and (boundp 'frame) frame) (selected-frame)))
;;             (frame-w (frame-pixel-width frame))
;;             (frame-h (frame-pixel-height frame))
;;             ;; frame-monitor-workarea returns (x y width height) for the monitor
;;             (monitor-w (nth 2 (frame-monitor-workarea frame)))
;;             (monitor-h (nth 3 (frame-monitor-workarea frame)))
;;             (center (list (/ (- monitor-w frame-w) 2)
;;                           (/ (- monitor-h frame-h) 2))))
;;       (apply 'set-frame-position (flatten-list (list frame center))))))

;; (add-hook 'after-init-hook #'@frame-recenter)
;; (add-hook 'after-make-frame-functions #'@frame-recenter)

(defun @org-in-export-block ()
  "Checks if in export block. Returns t or nil."
  (if (org-in-block-p (list "EXPORT")) t))
