;;; orderless.el --- Configuration for Orderless  -*- lexical-binding: t;
;;; Commentary:
;; This file configures the Orderless package, which provides a flexible completion
;; style for improved completion capabilities.

;;; Code:

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)))

(if nec/measure-time (nec/sstimer "completion/orderless"))

(provide 'completion/orderless)
;;; orderless.el ends here
