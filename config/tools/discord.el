;;; discord.el --- Elcord Configuration for Discord Rich Presence  -*- lexical-binding: t; coding: utf-8 -*-
;;; Commentary:

;; This file configures Elcord, enabling Discord Rich Presence
;; integration for Emacs.

;;; Code:

(use-package elcord
  :ensure t
  :config
  (elcord-mode)
  (setq elcord-idle-timer 600)
  (setq elcord-idle-message "Ta' en øl..."))
(if nec/measure-time (nec/sstimer "tools/discord")
(provide 'elcord)
;;; discord.el ends here
