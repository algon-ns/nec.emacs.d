;;; pdf-tools.el ---   -*- lexical-binding: t; coding: utf-8 -*-

;; Copyright (C),  2024 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@macal.local>

;; Package-Requires: ((emacs "29.2"))
;; Keywords:
;; Homepage:

;; pdf-tools is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; pdf-tools is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with init-pdf-tools.  If not, see http://www.gnu.org/licenses.

;;; Commentary:


;;; Code:

(use-package pdf-tools
  :straight t
  :defer nil
  :commands (pdf-view-mode pdf-tools-install)
  :mode ("\\.[pP][dD][fF]\\'" . pdf-view-mode)
  :load-path "site-lisp/pdf-tools/lisp"
  :magic ("%PDF" . pdf-view-mode)
  :config
  ;; install pdf-tools
  (pdf-tools-install :no-query)
  ;; open pdfs scaled to fit page
  (setq-default pdf-view-display-size 'fit-page)
  ;; automatically annotate highlights
  (setq pdf-annot-activate-created-annotations t)
  (define-pdf-cache-function pagelabels)
  :hook ((pdf-view-mode-hook . (lambda () (display-line-numbers-mode -1)))
         (pdf-view-mode-hook . pdf-tools-enable-minor-modes))
  )

(use-package pdf-view-restore
  :after pdf-tools
  :straight t
  :config
  :hook (pdf-view-mode . pdf-view-restore-mode)
  )

(provide 'lv-pdf)

(if nec/measure-time (nec/sstimer "write/pdf-tools"))

(provide 'write/pdf-tools)
;;; init-pdf-tools.el ends here
