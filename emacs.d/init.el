(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote
                       ("d05303816026cec734e26b59e72bb9e46480205e15a8a011c62536a537c29a1a"
                        "5e2ade7f65d9162ca2ba806908049fb37d602d59d90dc3a08463e1a042f177ae"
                        default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'tomorrow-night)

;;
;; package installation
;;
(require 'cl)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(setq url-http-attempt-keepalives nil)

;; list of packages to be installed via MELPA
(defvar package-list
  '(clojure-mode markdown-mode paredit sass-mode scss-mode
                 coffee-mode handlebars-mode slime auto-complete))

(defun packages-installed-p ()
  (loop for p in package-list
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(defun install-package-list ()
  (unless (packages-installed-p)
    ;; check for new versions
    (message "%s" "Refreshing package database...")
    (package-refresh-contents)
    (message "%s" "done.")
    ;; install missing packages
    (dolist (p package-list)
      (when (not (package-installed-p p))
        (package-install p)))))
(install-package-list)
;;
;; end package installation
;;

(when window-system
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (set-frame-size (selected-frame) 116 54)
  (set-fringe-style -1)
  (tooltip-mode -1))

;; some saner settings
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq-default tab-width 2)
(defvaralias 'c-basic-offset 'tab-width)
(setq-default indent-tabs-mode nil)
(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)

;; more normal scrolling
(setq scroll-step 1
      scroll-margin 5
      scroll-conservatively 10000)

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
(setq ido-auto-merge-work-directories-length -1)

;; backup file handling
;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
  '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
  '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))
;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

(setq
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)

;; TextMate minor mode for find-in-project etc
;; (add-to-list 'load-path "~/.emacs.d/vendor/")
;; (require 'textmate)
;; (textmate-mode)

;; auto-complete mode for stuff other than minibuffer
;; (require 'auto-complete)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
;; (require 'auto-complete-config)
;; (ac-config-default)
;; (add-to-list 'ac-modes 'coffee-mode)

;; highlight the current line; set a custom face, so we can
;; recognize from the normal marking (selection)
(defface hl-line '((t (:background "Gray")))
  "Face to use for `hl-line-face'." :group 'hl-line)
(setq hl-line-face 'hl-line)
(global-hl-line-mode t) ; turn it on for all modes by default

;; mode for Jade and Stylus
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/jade-mode"))
;; (require 'sws-mode)
;; (require 'jade-mode)
;; (require 'stylus-mode)
;; (add-to-list 'auto-mode-alist '("\\.styl$" . stylus-mode))
;; (add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
;; (setq sws-tab-width 2)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/stylus-mode"))
(require 'stylus-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . stylus-mode))

(add-hook 'stylus-mode-hook
          (function (lambda ()
                      (setq indent-tabs-mode nil
                            tab-width 2))))

;; mode for SCSS
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/scss-mode"))
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(setq scss-compile-at-save nil)

;; adjustments for css mode
(setq css-indent-offset 2)

;; adjustments for js mode
(setq js-indent-level 2)

;; mode for coffee-script
(require 'coffee-mode)
(custom-set-variables '(coffee-tab-width 2))

;; handlebars
(require 'handlebars-mode)

;; inferior-lisp for clojure
(add-to-list 'exec-path "/usr/local/bin")
;; (setq inferior-lisp-program "lein repl")

;; inferior-lisp for clisp
(setq inferior-lisp-program "clisp")

;; settings for plt-racket (scheme)
(setq scheme-program-name "mzscheme")

;; more sane beginning of line stuff
(defun beginning-of-line-or-indentation ()
  "move to beginning of line, or indentation"
  (interactive)
  (if (bolp)
      (back-to-indentation)
    (beginning-of-line)))
(global-set-key [home] 'beginning-of-line-or-indentation)
(global-set-key "\C-a" 'beginning-of-line-or-indentation)

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
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region-or-line)

;; keyboard bindings for switching windows
(global-set-key (kbd "C-c h") 'windmove-left)
(global-set-key (kbd "C-c l") 'windmove-right)
(global-set-key (kbd "C-c j") 'windmove-down)
(global-set-key (kbd "C-c k") 'windmove-up)

;; files should always end with a new line
(setq require-final-newline t)

;; default fill column is 70, why?
(setq default-fill-column 79)

;; whitespace-mode ------------------------------------------------------------
;; display only trails of lines longer than 80 columns, tabs, and
;; trailing whitespaces
(setq whitespace-line-column 80
      whitespace-style '(face tabs trailing lines-tail))

;; face for long lines tails
9(set-face-attribute 'whitespace-line nil
                     :background "red3"
                     :foreground "white"
                     :weight 'bold)
;; face for tabs
(set-face-attribute 'whitespace-tab nil
                    :background "red3"
                    :foreground "white"
                    :weight 'bold)
;; remove trailing whitespace on save
(add-hook 'write-file-hooks 'delete-trailing-whitespace)
;; activate minor whitespace-mode
(whitespace-mode 1)
(global-whitespace-mode 1)

;; we should use clojure-mode for clojurescript
(setq auto-mode-alist (cons '("\\.cljs" . clojure-mode) auto-mode-alist))
