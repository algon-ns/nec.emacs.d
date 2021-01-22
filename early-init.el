;;; early-init.el -*- lexical-binding: t; -*-
;;
;; Filename: early-init.el
;; Description:
;; Author: Niels Søndergaard
;; Created: Wed Apr 21 10:49:04 2020 (+0200)
;; Version: 1.0
;; Last-Updated: Ons jan 13 16:47:13 2021 (+0100)
;;           By: Niels Søndergaard
;;     Update #: 5
;; Keywords:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Commentary:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Code:
(setq enable-local-variables :safe)
;;
;;Some fundemental default settings are here
(setq package-enable-at-startup nil)
(setq-default debug-on-error         nil
              message-log-max        t
              ad-redefinition-action 'accept)
;; be sure to have Straight.el as the first thing to do
(setq straight-use-package-by-default t)
;; (setq straight-vc-git-default-clone-depth 'full)
(defvar bootstrap-version)
(let* ((straight-repo-dir
        (expand-file-name "straight/repos" user-emacs-directory))
       (bootstrap-file
        (concat straight-repo-dir "/straight.el/bootstrap.el"))
       (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (shell-command
     (concat
      "mkdir -p " straight-repo-dir " && "
      "git -C " straight-repo-dir " clone "
      "https://github.com/raxod502/straight.el.git && "
      "git -C " straight-repo-dir " checkout 2d407bc")))
  (load bootstrap-file nil 'nomessage))
;;
(straight-use-package '(use-package :type git :flavor melpa
                         :files (:defaults (:exclude "bind-key.el"
                                                     "bind-chord.el"
                                                     "use-package-chords.el"
                                                     "use-package-ensure-system-package.el")
                                           "use-package-pkg.el")
                         :host github :repo "jwiegley/use-package"))
(setq straight-check-for-modifications '(check-on-save find-when-checking))
;; =M-x straight-pull-all=: update all packages.
;; =M-x straight-normalize-all=: restore all packages (remove local edits)
;; =M-x straight-freeze-versions= and =M-x straight-thaw-versions= are like =pip
;;  freeze requirements.txt= and =pip install -r requirements.txt=

;;;;;; Set garbage collection threshold (to secure fast startup)
;; From https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/
(setq gc-cons-threshold-original gc-cons-threshold)
(setq gc-cons-threshold (* 1024 1024 10))
;;;;;; Set file-name-handler-alist
;; Also from https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/
(setq file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)
;;;;;; Set deferred timer to reset them
(run-with-idle-timer
 7 nil ;; seconds of idletime
 (lambda ()
   (setq gc-cons-threshold gc-cons-threshold-original)
   (setq file-name-handler-alist file-name-handler-alist-original)
   (makunbound 'gc-cons-threshold-original)
   (makunbound 'file-name-handler-alist-original)
   (straight-use-package 'gcmh)
   (use-package gcmh
     :straight t
     :delight " "
     :init
     (setq gcmh-verbose           nil
           gcmh-lows-cons-threshold #x800000
           gcmh-high-cons-threshold #x3200000
           gcmh-idle-delay          3600)
     :config
     (gcmh-mode))
   (setq garbage-collection-messages nil)
   (message "gc-cons-threshold and file-name-handler-alist restored")))               
;; start the startup
(defcustom nec/measure-time t
  "Do we want to measure time for this startup?"
  :group 'nec
  :type 'boolean)

(defcustom my-user-emacs-directory "~/.emacs.d/"
   "this is my home directory (in emacs)"
   :group 'nec
   :type 'string)

(setq default-directory my-user-emacs-directory)
(setq user-emacs-directory "~/.emacs.d/")

;; goto my base
(cd my-user-emacs-directory)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(defvar my-init-el-start-time (current-time)
  "Time when init.el was started")
;; from http://ergoemacs.org/emacs/elisp_datetime.html
(setq my-config-el-start-time-iso (concat
  (format-time-string "%Y-%m-%dT%T")
  ((lambda (x) (concat (substring x 0 3) ":" (substring x 3 5)))
    (format-time-string "%z"))))
(setq nec/total-time (current-time))
(setq nec/nutid (current-time))

(defun nec/timer (tekst)
  (message  (concat  "→ ★ " tekst "  %.2fs" )  (float-time (time-subtract (current-time) nec/nutid)))
  (setq nec/nutid (current-time)))
;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we easily halve startup times with fonts that are
;; larger than the system default.
(nec/timer "Start mesure of load time")
(setq frame-inhibit-implied-resize t)
