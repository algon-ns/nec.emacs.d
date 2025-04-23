;;; settings.el --- General Emacs settings  -*- lexical-binding: t; coding: utf-8 -*-
;;; Commentary:
;; General configurations to adjust the behavior of Emacs.

;;; Code:

(use-package emacs
  :straight nil
  :init
  (modify-all-frames-parameters '((width . 200)
                                  (height . 60)))
  :custom
  (inhibit-startup-message t)
;;  (frame-inhibit-implied-resize nil)
  (frame-title-format "\n")
  (inhibit-startup-screen t)
  (inhibit-startup-message t)
  (inhibit-splash-screen t)
  (inhibit-startup-buffer-menu t)                      ; Disable display of buffer list when more than 2 files are loaded
  (inhibit-startup-echo-area-message "niels")
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (global-display-line-numbers-mode t)
  (ring-bell-function 'ignore)
  (cursor-type '(hbar . 2))        ; Underline-shaped cursor
  ;; Smoother scrolling.
  (fast-but-imprecise-scrolling t)                       ; More performant rapid scrolling over unfontified region
;;  (hscroll-margin 1)                                   ; Reduce margin triggering automatic horizontal scrolling
;;  (hscroll-step 1)                                     ; Slower horizontal scrolling
;;  (mouse-wheel-scroll-amount '(1 ((shift) . hscroll))) ; Reduce vertical scroll speed
;;  (mouse-wheel-scroll-amount-horizontal 2)             ; Reduce horizontal scroll speed
;;  (pixel-scroll-precision-interpolate-mice nil)        ; Disable interpolation (causes wired jumps)
;;  (pixel-scroll-precision-mode (display-graphic-p))    ; Enable pixel-wise scrolling
;;  (pixel-scroll-precision-use-momentum t)              ; Enable momentum for scrolling lagre buffers
;;  (scroll-conservatively 101)                          ; Avoid recentering when scrolling far
;;  (scroll-preserve-screen-position t)                  ; Don't move point when scrolling
  ;; We tell emacs to use UTF-8 encoding as much as possible.
  (set-default-coding-systems 'utf-8)                  ; Default to utf-8 encoding
  (prefer-coding-system       'utf-8)                  ; Add utf-8 at the front for automatic detection.
  (set-language-environment   'utf-8)
  (set-terminal-coding-system 'utf-8)                  ; Set coding system of terminal output
  (set-keyboard-coding-system 'utf-8)                  ; Set coding system for keyboard input on TERMINAL
  ;; No tabulation, ever.
  (indent-tabs-mode nil)                               ; Stop using tabs to indent
  (defun smart-open-line ()
    "Insert a new line, indent it, and move the cursor there."
    (interactive)
    (move-end-of-line nil)
    (newline-and-indent))
  (initial-major-mode 'fundamental-mode)
  (select-enable-clipboard t)
  (global-hl-line-mode 1)
  (delete-selection-mode t)
  (electric-pair-mode 1)
  (savehist-mode 1)
  (save-place-mode 1)
  (setq-default display-fill-column-indicator-column 79)
  (use-dialog-box nil)
  (add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
  (display-time-mode 1)
  (display-line-numbers-type 'absolute)
  (setq-default right-fringe 10)
  (set-mouse-color (cdr (assoc 'mouse-color (frame-parameters)))))

(setopt custom-file (expand-file-name "var/custom.el" user-emacs-directory))
 ;; Load customization File
(load custom-file 'noerror 'nomessage)

;; Put backup files neatly away
(let ((backup-dir "~/var/backupfiles/")
      (auto-saves-dir "~/var/auto-save-files/"))
  (dolist (dir (list backup-dir auto-saves-dir))
    (when (not (file-directory-p dir))
      (make-directory dir t)))
  (setopt backup-directory-alist `(("." . ,backup-dir))
          auto-save-file-name-transforms `((".*" ,auto-saves-dir t))
          auto-save-list-file-prefix (concat auto-saves-dir ".saves-")
          tramp-backup-directory-alist `((".*" . ,backup-dir))
          tramp-auto-save-directory auto-saves-dir))

(setopt backup-by-copying t    ; Don't delink hardlinks
        delete-old-versions t  ; Clean up the backups
        version-control t      ; Use version numbers on backups,
        kept-new-versions 5    ; keep some new versions
        kept-old-versions 2)   ; and some old ones, too

(set-frame-font "FiraCode Nerd Font-12" nil t)
(if nec/measure-time (nec/sstimer "core/settings"))
;;; settings.el ends here
(provide 'core/settings)
