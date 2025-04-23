;;; flycheck.el --- Flycheck Configuration for Python  -*- lexical-binding: t; coding: utf-8 -*-
;;; Commentary:

;; Configure Flycheck with Ruff and Mypy, ensuring error display works immediately.

;;; Code:

(use-package flycheck
  :ensure t
  :init
  (setq flycheck-check-syntax-automatically
        '(save mode-enabled idle-change))
  (setq flycheck-idle-change-delay 0))

(setq flycheck-checker-cache "~/.flycheck-cache")
(setq flycheck-indication-mode nil)

(add-hook 'python-mode-hook #'flycheck-mode)

(if nec/measure-time (nec/sstimer "tools/flycheck"))
(provide 'tools/flycheck)
;;; flycheck.el ends here
