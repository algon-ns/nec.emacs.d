;;; org-babel-insert-src-block.el ---   -*- lexical-binding: t; coding: utf-8 -*-
;; Copyright (C),  2025 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@algon.dk>
;; Package-Requires: ((emacs "31.0.50"))
;; Keywords:
;; Homepage:

;; org-babel-insert-src-block is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; org-babel-insert-src-block is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with org-babel-insert-src-block.  If not, see http://www.gnu.org/licenses.

;;; Commentary:


;;; Code:
(defun my-org-babel-insert-src-block ()
  (interactive)
  (setq my-org-babel-insert-src-block-name
        (read-string "Name: "))
  (setq my-org-babel-insert-src-block-section-name-header
        (if (string= my-org-babel-insert-src-block-name "") ""
          (concat "#+name: " my-org-babel-insert-src-block-name )))
  (setq my-org-babel-insert-src-block-noweb-ref-block-header
        (if (string= my-org-babel-insert-src-block-name "") ""
          (concat " :noweb-ref " my-org-babel-insert-src-block-name)))
;;  (unless (string= my-org-babel-insert-src-block-name "")
;;    (org-insert-heading)
;;    (insert my-org-babel-insert-src-block-name "\n\n"))
  (unless (string= my-org-babel-insert-src-block-section-name-header "")
    (insert my-org-babel-insert-src-block-section-name-header "\n"))
  (insert "#+begin_src ")
  (insert
   (completing-read "Language: "
                    (list
					 "emacs-lisp"
                     "C"
                     "D"
                     "F90"
                     "R"
                     "awk"
                     "calc"
                     "clojure"
                     "comint"
                     "cpp"
                     "css"
                     "ditaa"
                     "dot"
                     "elisp"
                     "eshell"
                     "forth"
                     "gnuplot"
                     "groovy"
                     "haskell"
                     "java"
                     "js"
                     "julia"
                     "latex"
                     "lisp"
                     "lua"
                     "ly"
                     "makefile"
                     "matlab"
                     "max"
                     "ocaml"
                     "octave"
                     "org"
                     "perl"
                     "plantuml"
                     "processing"
                     "python"
                     "ruby"
                     "sass"
                     "scheme"
                     "screen"
                     "sed"
                     "shell"
                     "sql"
                     "sqlite")))
  (unless (string= my-org-babel-insert-src-block-noweb-ref-block-header "")
    (insert my-org-babel-insert-src-block-noweb-ref-block-header))
  (insert "\n\n#+end_src\n")
  (previous-line)(previous-line))

(define-key org-mode-map
			(kbd "C-. s")
			'my-org-babel-insert-src-block)

(if nec/measure-time (nec/stimer "org-babel-insert-src-block"))

(provide 'org-babel-insert-src-block)
;;; org-babel-insert-src-block.el ends here
