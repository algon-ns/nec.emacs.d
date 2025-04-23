;;; mac-calfw.el ---   -*- lexical-binding: t; coding: utf-8 -*-
;; Copyright (C),  2024 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@algon.dk>
;; Package-Requires: ((emacs "31.0.50"))
;; Keywords:
;; Homepage:

;; mac-calfw is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; mac-calfw is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with mac-calfw.  If not, see http://www.gnu.org/licenses.

;;; Commentary:


;;; Code:
(use-package maccalfw
  :commands maccalfw-open
  :straight (:host github
                   :repo "haji-ali/maccalfw"
                   :files ("maccalfw.el" ("src" . "src"))))

(if nec/measure-time (nec/sstimer "mac-calfw"))

(provide 'calendar/mac-calfw)
;;; mac-calfw.el ends here
