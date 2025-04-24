;;; init.el ---  -*- lexical-binding: t; coding: utf-8 -*-

;; Copyright (C),  2025 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@macal.local>
;; Original inspired by 'allma' (github: robert-nogueira)

;; Package-Requires: (emacs "31.0.50")
;; Keywords:
;; Homepage:

;; init is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; init is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with osx.  If not, see http://www.gnu.org/licenses.

;;; Commentary:

;; This file contains configuration for Emacs packages, including
;; package management and basic UI improvements.

;;; Commentary:
;; This file loads all necessary configurations for Emacs.

;;; Code:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if nec/measure-time (nec/header "start measure of load time ('init.el')"))
(setq user-full-name    "Niels Søndergaard"
      user-mail-address "niels@algon.dk")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; figure out if homebrew is using "/opt/homebrew (on Apple
;; Mx silicon) or /usr/local (on Intel silicon)
(when (eq system-type 'darwin)
  (if (file-exists-p "/opt/homebrew")
      (setq homebrew-prefix "/opt/homebrew/")
    (setq homebrew-prefix "/usr/local/")))
(defvar config-dir (expand-file-name "config" user-emacs-directory))
;; Add config directory to load-path
(add-to-list 'load-path config-dir)
;; setup the load paths so that I can require my own packages
;; to drive the boot process
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if nec/measure-time (nec/header "start core"))
(require 'core/packages) 
;;(load (expand-file-name "core/packages" config-dir))
(require 'core/osx)
(require 'core/registers)
(require 'core/crux-load)
(require 'core/keybindings)
(require 'core/magits)
(require 'core/settings)
(require 'core/files-dired)
(if nec/measure-time (nec/stimer "core"))
;;
(if nec/measure-time (nec/header "start ui"))
;; (load (expand-file-name "ui/interface" config-dir))
(require 'ui/bookmarks)
(require 'ui/theme)
(require 'ui/faces)
(require 'ui/uuid-simple)
(require 'ui/hydra)
(require 'ui/ibuffer)
(require 'ui/dashboard)
(if nec/measure-time (nec/stimer "ui"))
;;
(if nec/measure-time (nec/header "start completion"))
(require 'completion/company)
(require 'completion/vertico)
(require 'completion/marginalia)
(require 'completion/orderless)
(if nec/measure-time (nec/stimer "completion"))
;;
(if nec/measure-time (nec/header "start org"))
(require 'org/org-ns)
(require 'org/org-doct)
(require 'org/org-roam-load)
(require 'org/org-subs)
(require 'org/org-star)
(require 'org/org-journal)
(if nec/measure-time (nec/stimer "org"))
;;
(if nec/measure-time (nec/header "start programming"))
;; (require 'programming/lua)
(require 'programming/treesitter)
(require 'programming/lsp)
(require 'programming/python)
(require 'programming/web-dev)
(require 'programming/flychecks)
(require 'programming/yassip)
(if nec/measure-time (nec/stimer "programming"))
;;
(if nec/measure-time (nec/header "start calendar"))
(require 'calendar/mac-calfw)
(require 'calendar/kalender)
(require 'calendar/calendar-danish)
(if nec/measure-time (nec/stimer "calendar"))
;;
(if nec/measure-time (nec/header "start write"))
(require 'write/pdf-tools)
(require 'write/countw)
;; (require 'write/init-latex)
;; (require 'write/latex-ed)
;; (require 'write/latex-extra)
;; (require 'write/latex-table-wizard)
(if nec/measure-time (nec/stimer "write"))
;;
(if nec/measure-time (nec/header "start tools"))
(require 'tools/treemacs)
(require 'tools/centaur-tabs)
(require 'tools/flycheck)
;; (load (expand-file-name "tools/projectile" config-dir))
(require 'tools/functions)
;; (load (expand-file-name "tools/vterm" config-dir))
;; (load (expand-file-name "tools/discord" config-dir))
;; (load (expand-file-name "tools/vc" config-dir))
(require 'tools/ligature)
(if nec/measure-time (nec/stimer "tools"))
;;



;;
(if nec/measure-time (nec/header "misc"))
(require 'hooks)
(require 'misc)
(require 'aliases)
(require 'bank-buddy)
(if nec/measure-time (nec/stimer "misc"))
;;
(message (concat "*★*   "    
                 "Emacs "           emacs-version
                 "  -  Org-mode "   org-version
                 "  -  System "     (system-name)
                 "  -  Time "       (emacs-init-time)
                 "   *★*"))


(if nec/measure-time (nec/timer "init"))
(provide 'init)
;;; init.el ends here

