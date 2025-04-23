;;; init-org-doct.el ---   -*- lexical-binding: t; coding: utf-8 -*-

;; Copyright (C),  2024 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@macal.local>

;; Package-Requires: ((emacs "29.2"))
;; Keywords:
;; Homepage:

;; init-org-doct is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; init-org-doct is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with init-org-doct.  If not, see http://www.gnu.org/licenses.

;;; Commentary:


;;; Code:

(use-package doct
  :ensure t 
  :commands (org-capture))
(eval-when-compile (require 'subr-x))

(defvar org-default-tasks-file "~/org/agenda/opgaver.org")
(defvar org-default-notes-file "~/org/agenda/notes.org")

(setq org-capture-bookmark nil)
(setq org-id-link-to-org-use-id t)
(setq org-capture-templates
	  (doct
	   '(("📥 Aftale"
		  :keys "a"
		  :file "~/org/agenda/aftaler.org"
		  :type entry
		  :headline "Aftaler"
		  :template ("* TODO [#C] | %?           %^G:AFTALE:"
					 "  SCHEDULED:  %^T"
					 "  :PROPERTIES:"
					 "  :ID:        %(org-id-new)"
					 "  :DEADLINE:  "
					 "  :STED:      "
					 "  :EMNE:      "
					 "  :CATEGORY:  Aftale"
					 "  :CREATED:   %U"
					 "  :SRC:       %a"
					 "  :END:"))
		 ("💼 Møde"
		  :keys "m"
		  :file "~/org/agenda/møder.org"
		  :type entry
		  :headline "Møder"
		  :template ("* TODO [#C] | %?           %^G:MØDE:"
					 "  SCHEDULED:  %^T"
					 "  :PROPERTIES:"
					 "  :ID:        %(org-id-new)"
					 "  :DEADLINE:  "                                 
					 "  :STED:      "
					 "  :EMNE:      "
					 "  :CATEGORY:  Møde"
					 "  :CREATED:   %U"
					 "  :SRC:       %a"
					 "  :END:"))
		 ("💼 Faste møder"
		  :keys "f"
		  :file "~/org/agenda/møder.org"
		  :type entry
		  :headline "Fastmøde"
		  :template ("* TODO [#C] | %?           %^G:MØDE:"
					 "  SCHEDULED:  %^T"
					 "  :PROPERTIES:"
					 "  :ID:        %(org-id-new)"
					 "  :DEADLINE:  "
					 "  :NEXT-SPEC-DEADLINE: (= (calendar-extract-day date) (calendar-last-day-of-month (calendar-extract-month date) (calendar-extract-year date)))"
					 "  :NEXT-SPEC-SCHEDULED: (org-float 6 0 3)"
					 "  :STED:      "
					 "  :EMNE:      "
					 "  :CATEGORY:  Møde"
					 "  :CREATED:   %U"
					 "  :SRC:       %a"
					 "  :END:"))
		 ("󱧜 Note"
		  :keys "n"
		  :file "~/org/agenda/note.org"
		  :type entry
		  :headline "Note"
		  :template ("* TODO [#C] | %?           %^G:NOTE:"
					 "  SCHEDULED:  %^T"
					 "  :PROPERTIES:"
					 "  :ID:        %(org-id-new)"
					 "  :DEADLINE:  "                                 
					 "  :STED:      "
					 "  :EMNE:      "
					 "  :CATEGORY:  Note"
					 "  :CREATED:   %U"
					 "  :SRC:       %a"
					 "  :END:"))
		 ("📋 Opgave"
		  :keys "o"
		  :file "~/org/agenda/opgaver.org"
		  :type entry
		  :headline "Opgaver"
		  :template ("* TODO [#C] | %?             %^G:OPGAVE:"
					 "  SCHEDULED:  %^T"
					 "  :PROPERTIES:"
					 "  :ID:        %(org-id-new)"
					 "  :DEADLINE:  %^T"
					 "  :EMNE:      "
					 "  :CATEGORY:  Opgave"
					 "  :CREATED:   %U"
					 "  :SRC:       %a"
					 "  :END:"))
		 ;;		 ("📔 Dagbog"
		 ;;		  :keys "j"
		 ;;		 :type entry
		 ;;		 :function org-journal-find-location
		 ;;		 :template ("* %(format-time-string org-journal-time-format)%^{Title}"
		 ;;		 "  %?"
		 ;;		 "  %i"))
		 ("  Tickler"
		  :keys "T"
		  :type entry
		  :file "~/org/agenda/huskeliste.org"
		  :headline "Huske Liste"
		  :template ("* TODO [#C] - %?             %^G:HUSK:"
					 "  SCHEDULED:  %^T"
					 "  :PROPERTIES:"
					 "  :ID:        %(org-id-new)"
					 "  :DEADLINE:  %^T"					 
					 "  :STED:      "
					 "  :EMNE:      "
					 "  :CATEGORY:  Husk"
					 "  :CREATED:   %U"
					 "  :SRC:       %a"
					 "  :END:")) 
		 (" Kontakt"
		  :keys "K"
		  :file "~/org/agenda/kontakter.org"
		  :type entry
		  :headline "Kontakter"
		  :template ("* KONTAKT %?              :KONTAKT:"
					 "  :PROPERTIES:   "
					 "  :ID:        %(org-id-new)"
					 "  :ADRESSE:      "
					 "  :TELEFON:      "
					 "  :E-MAIL:       "
					 "  :FØDSELSDAG:   "
					 "  :NOTE:         "
					 "  :CATAGORY:     Kontakt "
					 "  :END:"))
		 ("kommunikation" 
		  :keys "k"
		  :file "~/org/agenda/opgaver.org"
		  :children
		  ((:group "Tid"
				   :clock-in t
				   :children 
				   (("Telefon"
					 :keys "t"
					 :template ("* Telefon med %?          :TELEFON:"
								"  :PROPERTIES:   "
								"  :ID:        %(org-id-new)"
								"  :CREATED: %U   "
								"  :EMNE:         "
								"  :CATEGORY: Telefon "
								"  :SRC:     %a   "
								"  :END:          "))
					("Møde"
					 :keys "m"
					 :template ("* Møde med %?               :MØDE:"
								"  :PROPERTIES:    "
								"  :ID:        %(org-id-new)"
								"  :CREATED:  %U   "
								"  :EMNE:          "
								"  :CATEGORY: Møde "
								"  :SRC:      %a   "
								"  :END:           ")))))))))
(if nec/measure-time (nec/sstimer "org-doct"))

(provide 'org/org-doct)
;;; init-org-doct.el ends here
