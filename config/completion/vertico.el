;;; vertico.el --- Configuration for Vertico   -*- lexical-binding: t; coding: utf-8 -*-
;;; Commentary:
;; This file configures the Vertico package, which enhances the completion experience
;; by providing a better interface for selection.

;;; Code:

(use-package vertico
  :ensure t
  :init
  (vertico-mode))
(if nec/measure-time (nec/sstimer "completion/vertico"))
(provide 'completion/vertico)
;;; vertico.el ends here
