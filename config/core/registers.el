;;; registers.el ---   -*- lexical-binding: t; coding: utf-8 -*-
;; Copyright (C),  2025 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@algon.dk>
;; Package-Requires: ((emacs "31.0.50"))
;; Keywords:
;; Homepage:

;; registers is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; registers is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with registers.  If not, see http://www.gnu.org/licenses.

;;; Commentary:

;; | command             | description                         |
;; |---------------------+-------------------------------------|
;; | M-x view-register R | see what register R contains        |
;; | C-x r s             | save region to register             |
;; | C-x r i             | insert text from a register         |
;; | C-x r n             | record a number defaults to 0       |
;; | C-x r +             | increment a number from register    |
;; | C-x r SPC           | record a position into register     |
;; | C-x r j             | jump to positions or windows config |
;; | C-x r q             | clear all saved registers           |
;; | C-x r w             | save a window configuration         |
;; | C-x r f             | save a frame configuration          |
;;; Code:

(defun clear-registers ()
  "Remove all saved registers."
  (interactive)
  (setq register-alist nil))
(bind-key  "C-x r q" 'clear-registers)

(set-register ? "(if nec/measure-time (nec/header \" \"))")
(set-register ?t "(if nec/measure-time (nec/timer \" \"))")
(set-register ?s "(if nec/measure-time (nec/stimer \" \"))")
(set-register ?z "(if nec/measure-time (nec/sstimer \" \"))")

(if nec/measure-time (nec/sstimer "core/registers"))
(provide 'core/registers)
;;; registers.el ends here
