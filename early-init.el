;;; early-init.el ---   -*- lexical-binding: t; coding: utf-8 -*-
;; Copyright (C),  2025 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@algon.dk>
;; Package-Requires: ((emacs "31.0.50"))
;; Keywords:
;; Homepage:

;; early-init is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; early-init is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with early-init.  If not, see http://www.gnu.org/licenses.

;;; Commentary:


;;; Code:
;;  You need a modern emacs
(when (version< emacs-version "30")
  (error "nec-emacs requires Emacs 30 or later"))
(setopt enable-local-variables :safe)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setopt debug nil)
(setopt debug-on-error nil)
;; toggle with 'toggle-debug-on-error'
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar emacs-start-time (current-time)
  "Time when early-init.el was started")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setopt package-enable-at-startup nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; We're going to increase the gc-cons-threshold to a very
;; high number to decrease the load time and add a hook to
;; measure Emacs startup time.
(setopt gc-cons-threshold most-positive-fixnum
	gc-cons-percentage 0.6)
;; Let's lower our GC thresholds back down to a sane level.
(add-hook 'after-init-hook (lambda ()
                             ;; restore after startup
                             (setopt gc-cons-threshold (* 16 1024 1024))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defcustom nec/measure-time t
  "Do we want to measure time for this startup?"
  :group 'nec
  :type 'boolean)
;; from http://ergoemacs.org/emacs/elisp_datetime.html
(setopt nec/total-time (current-time)
        nec/nutid0 nec/total-time
        nec/nutid1 nec/nutid0
        nec/nutid2 nec/nutid1)
(defun nec/header (tekst)
  (message  (concat  "*★* " tekst )))
(defun nec/timer (tekst)
  (message  (concat  "*★*     " tekst "  %.5fs" )
	    (float-time (time-subtract (current-time) nec/nutid0)))
  (setq nec/nutid0 (current-time)
        nec/nutid1 nec/nutid0
        nec/nutid2 nec/nutid1))
(defun nec/stimer (tekst)
  (message  (concat  "*★*         " tekst "  %.5fs" )
	    (float-time (time-subtract (current-time) nec/nutid1)))
  (setq nec/nutid1 (current-time)
        nec/nutid2 nec/nutid1))
(defun nec/sstimer (tekst)
  (message  (concat  "*★*             " tekst "  %.5fs" )
	    (float-time (time-subtract (current-time) nec/nutid2)))
  (setq nec/nutid2 (current-time)))
(if nec/measure-time (nec/header "start load time (in 'early-init.el')"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; be sure, that necesary directories and files exists
(cd user-emacs-directory )      ; Move to the user directory
(unless (file-exists-p "lisp") (make-directory "lisp" t))
(unless (file-exists-p "etc") (make-directory "etc" t))
(unless (file-exists-p "var") (make-directory "var" t))
(unless (file-exists-p "private") (make-directory "private" t))
(unless (file-exists-p "images") (make-directory "images" t))
(unless (file-exists-p "snippets") (make-directory "snippets" t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if nec/measure-time (nec/timer "early-init"))

(provide 'early-init)
;;; early-init.el ends here
