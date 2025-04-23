;;; osx.el ---   -*- lexical-binding: t; coding: utf-8 -*-

;; Copyright (C),  2024 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@macal.local>

;; Package-Requires: ((emacs "29.2"))
;; Keywords:
;; Homepage:

;; osx is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; osx is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with osx.  If not, see http://www.gnu.org/licenses.

;;; Commentary:


;;; Code:
(setopt sys/mac-x-p (eq system-type 'darwin))
(setopt macOS  (eq system-type 'darwin))

(when macOS
  (use-package osx-lib
    :straight t)
  
  (setopt ns-pop-up-frames nil            ; Don't pop up new frames from the workspace
	  ns-use-thin-smoothing t	  
	  ;; sane trackpad/mouse scroll settings
	  mac-redisplay-dont-reset-vscroll t
	  mac-mouse-wheel-smooth-scroll t
	  mouse-wheel-scroll-amount '(5 ((shift) . 2))  ; one line at a time
	  mouse-wheel-progressive-speed nil             ; don't accelerate scrolling
	  ;; Curse Lion and its sudden but inevitable fullscreen mode!
	  ;; NOTE Meaningless to railwaycat's emacs-mac build
	  ns-use-native-fullscreen nil
	  ;; Don't open files from the workspace in a new frame
	  mac-option-modifier 'meta       ; Option is simply the natural Meta
	  mac-command-modifier 'super     ; But command is a lot easier to hit
	  mac-control-modifier 'control   ; control as... control
	  mac-right-command-modifier 'left
	  mac-right-option-modifier 'none ; Keep right option for accented input
	  mac-left-options-modifier 'meta
	  ;; Just in case we ever need these keys
	  mac-function-modifier 'hyper))
;; Mac specific
(when macOS
  (progn
    (defun mac-open-file ()
      (interactive)
      (let ((file (do-applescript "POSIX path of (choose file)")))
        (if (> (length file) 3)
            (setq file (substring file 1 (- (length file) 1))))
        (if (and (not (equal file "")) (file-readable-p file))
            (find-file file))))

    (defun mac-save-file-as ()
      (interactive)
      (let ((file (do-applescript "POSIX path of (choose file name with prompt \"Save As...\")")))
        (if (> (length file) 3)
            (setq file (substring file 1 (- (length file) 1))))
        (if (not (equal file ""))
            (write-file file))))))

(defun childframe-workable-p ()
  "Whether childframe is workable."
  (not (or noninteractive
           emacs-basic-display
           (not (display-graphic-p)))))

(if nec/measure-time (nec/sstimer "core/osx"))
(provide 'core/osx)
;;; osx.el ends here
