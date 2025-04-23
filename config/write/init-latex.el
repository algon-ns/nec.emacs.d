;;; init-latex.el ---   -*- lexical-binding: t; coding: utf-8 -*-

;; Copyright (C),  2024 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@macal.local>

;; Package-Requires: ((emacs "30.0.50"))
;; Keywords:
;; Homepage:

;; init-latex is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; init-latex is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with init-latex.  If not, see http://www.gnu.org/licenses.

;;; Commentary:
;;  AUCTEX is a comprehensive customizable integrated environment for writing
;;  input files for TEX, LaTEX, ConTEXt, Texinfo, and docTEX using Emacs.
;;  

;;; Code:

(straight-use-package 'auctex)
(setopt TeX-auto-save t)
(setopt TeX-parse-self t)
(setq-default TeX-master nil)
(setq-default TeX-engine 'luatex)

(if nec/measure-time (nec/sstimer "write/init-latex"))

(provide 'write/init-latex)
;;; init-latex.el ends here
