;;; marginalia.el --- Configuration for Marginalia  -*- lexical-binding: t; coding: utf-8 -*-
;;; Commentary:
;; This file configures the Marginalia package, which provides
;; rich annotations in the minibuffer to enhance the completion experience.

;;; Code:

(use-package marginalia
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators
   '(marginalia-annotators-heavy marginalia-annotators-lv))
  :init
  (marginalia-mode))

(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(if nec/measure-time (nec/sstimer "completion/marginella"))
(provide 'completion/marginalia)
;;; marginalia.el ends here
