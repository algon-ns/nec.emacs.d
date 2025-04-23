;;; init-theme.el ---   -*- lexical-binding: t; coding: utf-8 -*-

;; Copyright (C),  2024 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@macal.local>

;; Package-Requires: ((emacs "29.2"))
;; Keywords:
;; Homepage:

;; init-theme is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; init-theme is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with init-theme.  If not, see http://www.gnu.org/licenses.

;;; Commentary:


;;; Code:

;; Gruvbox for change of pace every now and then.
;; https://github.com/greduan/emacs-theme-gruvbox
;;(use-package gruvbox-theme
;;  :init
;;  (load-theme 'gruvbox :no-confirm))

;; OneDark Theme

;; (when window-system
;;   (use-package atom-one-dark-theme
;;     :init
;;    (load-theme 'atom-one-dark :no-confirm)))

;; Nerd Icons
;; https://github.com/rainstormstudio/nerd-icons.el#installing-fonts
;;
;; NOTE: You will need to run 'M-x nerd-icons-install-fonts' and then manually install the
;; downloaded font on Windows.
(use-package nerd-icons
  :ensure t
  :if (display-graphic-p))

;; (require 'modus-themes)
;; Read the doc string of each of those user options.  These are some
;; sample values.
(setq modus-themes-bold-constructs t
      modus-themes-italic-constructs t
      modus-themes-disable-other-themes t
      modus-themes-mixed-fonts t
      modus-themes-variable-pitch-ui t
      modus-themes-prompts '(extrabold italic)
      modus-themes-headings
      '((0 . (variable-pitch light 1.5))
        (1 . (variable-pitch light 1.4))
        (2 . (variable-pitch light 1.3))
        (3 . (variable-pitch semilight 1.3))
        (4 . (variable-pitch semilight 1.2))
        (5 . (variable-pitch 1.1))
        (6 . (variable-pitch 1.1))
        (7 . (variable-pitch 1.1))
        (agenda-date . (1.3))
        (agenda-structure . (variable-pitch light 1.8))
        (t . (variable-pitch 1.1))))


;;; For the built-in themes which cannot use `require'.
(use-package emacs
  :config
  (require-theme 'modus-themes) ; `require-theme' is ONLY for the built-in Modus themes

  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil)

  ;; Maybe define some palette overrides, such as by using our presets
  (setq modus-themes-common-palette-overrides
        modus-themes-preset-overrides-intense)

  ;; Load the theme of your choice.
  (load-theme 'modus-vivendi)

  (define-key global-map (kbd "<f5>") #'modus-themes-toggle))

(defun my-update-active-mode-line-colors ()
  (set-face-attribute
   'mode-line nil
   :foreground (modus-themes-get-color-value 'fg-mode-line-active)
   :background (modus-themes-get-color-value 'bg-blue-subtle)))
(use-package modus-themes
  :hook
  (modus-themes-after-load-theme . my-update-active-mode-line-colors))




;; Rainbow Delimiters for colored braces.
;; https://github.com/Fanael/rainbow-delimiters
;;
;; This is a must have for Lisp programming.
(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

;; Beacon
;; https://github.com/Malabarba/beacon
;;

(if (daemonp)
    (add-hook 'after-make-frame-functions
			  (lambda (frame)
				(with-selected-frame frame
				  (my/configure-custom-font)))))

;; Set line numbers to display.
;; https://www.emacswiki.org/emacs/LineNumbers
(require 'display-line-numbers)

;; Create a custom function to set which modes we do not want to see line numbers in.
(defcustom display-line-numbers-exempt-modes
  '(vterm-mode eshell-mode shell-mode term-mode ansi-term-mode org-mode)
  "Major modes on which to disable line numbers."
  :group 'display-line-numbers
  :type 'list
  :version "green")

(defun display-line-numbers--turn-on ()
  "Turn on line numbers except for certain major modes.
Exempt major modes are defined in `display-line-numbers-exempt-modes'."
  (unless (or (minibufferp)
              (member major-mode display-line-numbers-exempt-modes))
    (display-line-numbers-mode)))

(global-display-line-numbers-mode)

;; hl-todo
;; https://github.com/tarsius/hl-todo?tab=readme-ov-file
(use-package hl-todo
  :init
  (global-hl-todo-mode)
  :config
  (setq hl-todo-keyword-faces
		'(("TODO" . "#61AFEF")
		  ("NOTE" . "#56B6C2")
		  ("WARNING" . "#E5C07B")
		  ("FIX" . "#E06C75")))
  ;; NOTE: Sets whether or not the color is applied to the foreground (nil) or background (t) of the text.
  (setq hl-todo-color-background nil)
  (setq hl-todo-highlight-punctuation ""))

(if nec/measure-time (nec/sstimer "ui/theme"))

(provide 'ui/theme)
;;; init-theme.el ends here
