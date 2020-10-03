;;; pretty-sym.el --- 
;; 
;; Filename: pretty-sym.el
;; Description: 
;; Author: Niels Søndergaard
;; Copyright (C) 2020, Niels Søndergaard
;; Created: Wed Jul 29 16:58:27 2020 (+0200)
;; Version: 
;; Last-Updated: Wed Jul 29 17:16:38 2020 (+0200)
;;           By: Niels Søndergaard
;;     Update #: 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Commentary: 
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Change Log:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:
(use-package pretty-symbols
  :straight t
  :config
  (setq pretty-symbol-categories '(relational logical lambda org-specific nil cpp general))

  (defun yant/str-to-glyph (str)
    "Transform string into glyph, displayed correctly."
    (let ((composition nil))
      (dolist (char (string-to-list str)
		    (nreverse (cdr composition)))
	(push char composition)
	(push '(Br . Bl) composition)
	)))
  
  (setq pretty-symbol-patterns
	(append pretty-symbol-patterns
		'((?▤ org-specific ":LOGBOOK:" (org-mode))
      		  (?⚙ org-specific ":PROPERTIES:" (org-mode))
      		  (?⏏ org-specific ":END:" (org-mode))
      		  (?★ org-specific "\\[#A\\]" (org-mode))
      		  ("" org-specific "\\[#B\\]" (org-mode))
      		  (?☕ org-specific "\\[#C\\]" (org-mode))
                  (?⁂ org-specific "\\(^\\*\\)[^*]" (org-mode) 1)
                  (?• org-specific "^\\(?:\\*\\{1\\}\\)\\(\\*\\)[^*]" (org-mode) 1)
                  (?⊢ org-specific "^\\(?:\\*\\{2\\}\\)\\(\\*\\)[^*]" (org-mode) 1)
                  (?⋮ org-specific "^\\(?:\\*\\{3\\}\\)\\(\\*\\)[^*]" (org-mode) 1)
                  (?⋱ org-specific "^\\(?:\\*\\{4,\\}\\)\\(\\*\\)[^*]" (org-mode) 1)
      		  ((yant/str-to-glyph "☐") org-specific "\\(?:^*+ +\\)\\(\\<TODO\\>\\)" (org-mode) 1)
      		  ((yant/str-to-glyph "☑") org-specific "\\(?:^*+ +\\)\\(\\<DONE\\>\\)" (org-mode) 1)
      		  ((yant/str-to-glyph "✘") org-specific "\\(?:^*+ +\\)\\(\\<FAILED\\>\\)" (org-mode) 1)
      		  ((yant/str-to-glyph "✘") org-specific "\\(?:^*+ +\\)\\(\\<CANCELLED\\>\\)" (org-mode) 1)
      		  ((yant/str-to-glyph "▶") org-specific "\\(?:^*+ +\\)\\(\\<NEXT\\>\\)" (org-mode) 1)
                  ((yant/str-to-glyph "☇") org-specific "\\(?:^*+ +\\)\\(\\<MERGED\\>\\)" (org-mode) 1)
      		  ((yant/str-to-glyph "⚑") org-specific "\\(?:^*+ +\\)\\(\\<WAITING\\>\\)" (org-mode) 1)
      		  ((yant/str-to-glyph "♲") org-specific "\\(?:^*+ +\\)\\(\\<HOLD\\>\\)" (org-mode) 1)
      		  ((yant/str-to-glyph "☠D") org-specific "\\<DEADLINE:" (org-mode))
      		  ((yant/str-to-glyph "◴S") org-specific "\\<SCHEDULED:" (org-mode))))))

(provide 'pretty-symbols)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; pretty-sym.el ends here
