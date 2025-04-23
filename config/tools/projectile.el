;;; projectile.el --- Configuration for Projectile  -*- lexical-binding: t; coding: utf-8 -*-
;;; Commentary:
;; This file configures Projectile, a project management tool
;; in Emacs.  It helps to navigate and manage projects efficiently

;;; Code:

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1))

(setq projectile-project-root-files '(".git"))
(setq projectile-project-search-path '("~/Documents/freelas" "~/Documents/my-projects" "~/Documents/squarecloud")) ;; Diretórios com seus projetos

(if nec/measure-time (nec/sstimer "tools/projectile"))
(provide 'projectile)
;;; projectile.el ends here
