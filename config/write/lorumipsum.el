;;; Lorumipsumd.el ---   -*- lexical-binding: t; coding: utf-8 -*-

;; Copyright (C),  2024 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@macal.local>

;; Package-Requires: ((emacs "29.2"))
;; Keywords:
;; Homepage:

;; lorumipsum is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; lorumipsum is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with init-lorum-ipsum.  If not, see http://www.gnu.org/licenses.

;;; Commentary:

;; C-c l p: lorem-ipsum-insert-paragraphs
;; C-c l s: lorem-ipsum-insert-sentences
;; C-c l l: lorem-ipsum-insert-list

;;; Code:


(use-package lorem-ipsum
  :straight t
  :bind
  ("C-c C-l s" . lorem-ipsum-insert-sentences)
  ("C-c C-l p" . lorem-ipsum-insert-paragraphs)
  ("C-c C-l l" . lorem-ipsum-insert-list))


(if nec/measure-time (nec/sstimer "write/loremipsum "))

(provide 'write/lorumipsum)
;;; init-lorum-ipsum.el ends here
