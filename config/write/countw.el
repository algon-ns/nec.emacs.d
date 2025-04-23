;;; countw.el ---   -*- lexical-binding: t; coding: utf-8 -*-
;; Copyright (C),  2025 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@algon.dk>
;; Package-Requires: ((emacs "31.0.50"))
;; Keywords:
;; Homepage:

;; countw is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; countw is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with countw.  If not, see http://www.gnu.org/licenses.

;;; Commentary:


;;; Code:
;;----------------------------------------------------------------------
;; COUNT-WORDS-REGION: USING `while'
;;----------------------------------------------------------------------

;;;###autoload
(defun count-words-region (beginning end)
  "Print number of words in the region."
  (interactive "r")
  (message "Counting words in region ... ")
;;; 1. Set up appropriate conditions.
  (save-excursion
    (let ((count 0))
      (goto-char beginning)
;;; 2. Run the while loop.
      (while (and (< (point) end)
		  (re-search-forward "\\w+\\W*" end t))
	(setq count (1+ count)))
;;; 3. Send a message to the user.
      (cond ((zerop count)
	     (message
	      "The region does NOT have any words."))
	    ((= 1 count)
	     (message
	      "The region has 1 word."))
	    (t
	     (message
	      "The region has %d words." count))))))

;; count words in region
;; (global-set-key (kbd "C-=") 'count-words-region)

;;;###autoload
(defun count-words-buffer ()
  "Print number of words in the region."
;;; 1. Set up appropriate conditions.
  (save-excursion
    (let ((count 0)
          (beginning (point-min))
          (end (point-max)))
      (goto-char beginning)
;;; 2. Run the while loop.
      (while (and (< (point) end)
		  (re-search-forward "\\w+\\W*" end t))
	(setq count (1+ count)))
;;; 3. Send a message to the user.
      (cond ((zerop count) (message "No words"))
            ((= 1 count) (message "1 word"))
            (t  (message  (format "%d words" count)))))))


;;----------------------------------------------------------------------
;; PRINT ASCII TABLE
;;----------------------------------------------------------------------
;;;###autoload
(defun ascii-table ()
  "Display basic ASCII table (0 thru 127)"
  (interactive)
  (pop-to-buffer "*ASCII*")
  (erase-buffer)
  (save-excursion (let ((i -1))
                    (insert "ASCII characters 0 thru 127.\n\n")
                    (insert " Hex  Dec  Char|  Hex  Dec  Char|  Hex  Dec  Char|  Hex  Dec  Char\n")
                    (while (< i 31)
                      (insert (format "%4x %4d %4s | %4x %4d %4s | %4x %4d %4s | %4x %4d %4s\n"
                                      (setq i (+ 1  i)) i (single-key-description i)
                                      (setq i (+ 32 i)) i (single-key-description i)
                                      (setq i (+ 32 i)) i (single-key-description i)
                                      (setq i (+ 32 i)) i (single-key-description i)))
                      (setq i (- i 96)))))
  (special-mode))

(if nec/measure-time (nec/sstimer "write/countw"))
(provide 'write/countw)
;;; countw.el ends here
