(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("d05303816026cec734e26b59e72bb9e46480205e15a8a011c62536a537c29a1a" "5e2ade7f65d9162ca2ba806908049fb37d602d59d90dc3a08463e1a042f177ae" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'tomorrow-night)

(when window-system
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (set-frame-size (selected-frame) 116 54)
  (set-fringe-style -1)
  (tooltip-mode -1))

(require 'package)
(add-to-list 'package-archives
	     '("marmalade" .
	       "http://marmalade-repo.org/packages/"))
(package-initialize)

;; inferior-lisp for clojure
(add-to-list 'exec-path "/usr/local/bin")
(setq inferior-lisp-program "lein repl")

;; settings for plt-racket (scheme)
(setq scheme-program-name "mzscheme")

;; comment-or-uncomment-region-or-line
; it's almost the same as in textmate.el but I wrote it before I know about
; textmate.el, in fact that's how I found textmate.el, by googling this
; function to see if somebody already did that in a better way than me.
(defun comment-or-uncomment-region-or-line ()
  "Like comment-or-uncomment-region, but if there's no mark \(that means no
region\) apply comment-or-uncomment to the current line"
  (interactive)
  (if (not mark-active)
      (comment-or-uncomment-region
        (line-beginning-position) (line-end-position))
      (if (< (point) (mark))
          (comment-or-uncomment-region (point) (mark))
        (comment-or-uncomment-region (mark) (point)))))
(global-set-key (kbd "C-/") 'comment-or-uncomment-region-or-line)

;; keyboard bindings for switching windows
(global-set-key (kbd "C-c h") 'windmove-left)
(global-set-key (kbd "C-c l") 'windmove-right)
(global-set-key (kbd "C-c j") 'windmove-down)
(global-set-key (kbd "C-c k") 'windmove-up)

;; files should always end with a new line
(setq require-final-newline t)

;; default fill column is 70, why?
(setq default-fill-column 79)

;; some saner settings
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq inhibit-startup-message t)

(fset 'yes-or-no-p 'y-or-n-p)

(delete-selection-mode t)
(blink-cursor-mode t)
(show-paren-mode t)
(global-linum-mode 1)
(column-number-mode t)
(setq visible-bell t)

(set-frame-font "Menlo-12")

;; ido-mode for fuzzy finding etx
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-create-new-buffer 'always)

;; we should use clojure-mode for clojurescript
(setq auto-mode-alist (cons '("\\.cljs" . clojure-mode) auto-mode-alist))
