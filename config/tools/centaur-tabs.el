;;; centaur-tabs.el --- Configuration for Centaur Tabs  -*- lexical-binding: t; coding: utf-8 -*-
;;; Commentary:

;; This file configures Centaur Tabs, enabling a tab-based navigation
;; system for Emacs, along with some customizations for appearance and behavior.

;;; Code:

(use-package centaur-tabs
  :demand
  :hook
  (dashboard-mode . centaur-tabs-local-mode)
  :config
  (centaur-tabs-mode t)
  (centaur-tabs-headline-match)
  (setopt centaur-tabs-set-icons t)
  (setopt centaur-tabs-icon-type 'nerd-icons)
  (setopt centaur-tabs-set-bar 'under)
  (setopt x-underline-at-descent-line t)
  (setopt centaur-tabs-set-close-button nil)
  (setopt centaur-tabs-set-modified-marker t)
  (setopt centaur-tabs-cycle-scope 'tabs)
  (centaur-tabs-group-by-projectile-project)
  (setopt centaur-theme 'system)
  (setopt centaur-tabs-style "slant")
  (setopt centaur-tabs-modified-marker "👀")
  :bind
  ("C-<iso-lefttab>" . centaur-tabs-backward)
  ("C-<tab>" . centaur-tabs-forward)
  ("C-s-n" . centaur-tabs--create-new-tab)
  ("C-s-w" . centaur-tabs--kill-this-buffer-dont-ask)
  ("C-s-S-W" . centaur-tabs-kill-unmodified-buffers-in-current-group))

(if nec/measure-time (nec/sstimer "tools/centaur-tabs"))
(provide 'tools/centaur-tabs)
;;; centaur-tabs.el ends here
