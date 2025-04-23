;;; packages.el --- Emacs Packages Setup  -*- lexical-binding: t; coding: utf-8 -*-

;; Copyright (C),  2025 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@macal.local>

;; Package-Requires: ((emacs "31.0.50"))
;; Keywords:
;; Homepage:

;; packages is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; packages is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with osx.  If not, see http://www.gnu.org/licenses.

;;; Commentary:

;; This file contains configuration for Emacs packages, including
;; package management and basic UI improvements.

;;; Code:
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el"
                         (or (bound-and-true-p straight-base-dir)
                         user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setopt package-archives '(("melpa"  . "https://melpa.org/packages/")
                           ("gnu"    . "https://elpa.gnu.org/packages/")
			   ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(setq straight-use-package-by-default t)
(package-initialize)

(defcustom auto-package-update-last-update-day-filename
  "var/.last-package-update-day"
  "Name of the file in which the last update day is going to be stored."
  :type 'string
  :group 'auto-package-update)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (Try to) Ensure the latest org-mode is installed
(condition-case nil
    (straight-use-package 'org)
  (error
   (display-warning 'init "Could not install latest org-mode. Falling back to bundled version.")))
(straight-use-package 'el-patch)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package exec-path-from-shell
  :straight t
  :config (exec-path-from-shell-initialize))

(setenv "PATH"
        (concat "/opt/homebrew/bin" path-separator
                "/Library/TeX/texbin" path-separator				
                "/usr/local/bin" path-separator
                "/usr/bin" path-separator
                "/usr/sbin" path-separator
		"/bin" path-separator
                "/sbin" path-separator
                "/Applications/Emacs.app/Contents/MacOS/"  path-separator
		"/Applications/Emacs.app/Contents/MacOS/bin/" path-separator
                (getenv "PATH")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package auto-package-update
  :ensure t
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)  ;; Fechar parêntese corrigido aqui
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "23:00"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq use-package-always-defer t)
(if nec/measure-time (nec/sstimer "core/packages"))
(provide 'core/packages)
;;; packages.el ends here
