;;; buddy.el ---   -*- lexical-binding: t; coding: utf-8 -*-
;; Copyright (C),  2025 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@algon.dk>
;; Package-Requires: ((emacs "31.0.50"))
;; Keywords:
;; Homepage:

;; buddy is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; buddy is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with buddy.  If not, see http://www.gnu.org/licenses.

;;; Commentary:


;;; Code:



(provide 'buddy)
;;; buddy.el ends here

;; Bank Buddy category definitions
(customize-set-variable 'bank-buddy-core-cat-list-defines
  '(("katherine\\|james\\|kate" "prs") ("railw\\|railway\\|train" "trn") ("paypal" "pay") ("electric\\|energy\\|water" "utl") ("racing" "bet") ("pension" "pen") ("savings\\|saver" "sav") ("uber" "txi") ("magazine\\|news" "rdg") ("claude\\|reddit\\|mobile\\|backmarket\\|openai\\|web" "web") ("notemachine\\|withdrawal" "atm") ("finance" "fin") ("youtube\\|netflix" "str") ("card" "crd") ("top-up\\|phone" "phn") ("amaz\\|amz" "amz") ("pets\\|pet" "pet") ("dentist" "dnt") ("residential\\|rent\\|mortgage" "hse") ("deliveroo\\|just.*eat" "fod") ("ebay\\|apple\\|itunes" "shp") ("law" "law") ("anyvan" "hmv") ("" "Niels") (".*" "o")))
