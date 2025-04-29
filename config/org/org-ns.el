;;; org.el ---   -*- lexical-binding: t; coding: utf-8 -*-
;; Copyright (C),  2024 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@algon.dk>
;; Package-Requires: ((emacs "31.0.50"))
;; Keywords:
;; Homepage:

;; org is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; org is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with org.  If not, see http://www.gnu.org/licenses.

;;; Commentary:


;;; Code:
(if nec/measure-time (nec/header "start org"))

(setq org-id-prefix "ns")
(setq org-id-track-globally t)
(setq org-id-locations-file (concat user-emacs-directory
									"var/.org-id-locations"))

(use-package org-contrib
  :straight t)
;; Always going to need these
(require 'org-compat)
;; This one defines a function for some reason
(require 'org-macs)
;; This seems to be needed for some reason
(defalias 'org-file-name-concat #'file-name-concat)
(require 'ox)
;; (if nec/measure-time (nec/stimer "load modules"))
(use-package org
  :straight nil
  :init
  (setq org-directory "~/org/)"
        org-cite-global-bibliography (file-expand-wildcards (expand-file-name "bibliography/*.bib" org-directory)))
  :bind (("C-c l" . org-store-link)
	     ("C-c a" . org-agenda)
         :map org-mode-map
         ("C-c C-'" . org-insert-or-edit-src-block)
         :map org-src-mode-map
	     ("C-c C-'" . org-edit-src-exit)
	     ("C-c C-c" . org-edit-src-exit))
  :custom (org-ellipsis "…")
  (org-src-fontify-natively t)
  (org-fontify-quote-and-verse-blocks t)
  
  (org-src-tab-acts-natively t)
  (org-edit-src-content-indentation 2)
  (org-hide-block-startup nil)
  (org-src-preserve-indentation nil)
  ;; Return or left-click with mouse follows link
  (org-return-follows-link t)
  (org-mouse-1-follows-link t)
  ;; Display links as the description provided
  (org-link-descriptive t)

  (setq org-lowest-priority ?F)  ;; Gives us priorities A through F
  (setq org-default-priority ?E) ;; If an item has no priority, it is considered [#E].

  (setq org-priority-faces
	'((65 . "#BF616A")
          (66 . "#EBCB8B")
          (67 . "#B48EAD")
          (68 . "#81A1C1")
          (69 . "#5E81AC")
          (70 . "#4C566A")))

  ;; Todo
  (org-todo-keywords
   '((sequence "NY(n!)"       ; Proposal, idea (under review), to be
               "TODO(t!)"     ; A task that needs doing & is ready to do
	           "IGANG(i)"     ; A task that is in progress
       	       "UDSAT(e)"    
       	       "VENT(w!)"     ; Something external is holding up this task
       	       "TELEFON(p!)"
       	       "VIDEO(v)"			  
       	       "MØDE(m!)"
       	       "DELEGERET(u!)"
       	       "|" 
       	       "DONE(d!)"     ; Task successfully completed
       	       "CANCEL(c@)")  ; aflyst
     (sequence "[ ](T)"       ; A task that needs doing
               "[-](S)"       ; Task is in progress
               "[?](W)"       ; Task is being held up or paused
               "|"
               "[X](D)"))) ; Task was completed
  (org-todo-keyword-faces '(("UDSAT" . warning)
                            ("❓" . warning)
			                ("TODO" . (:foreground "green" :weight bold))
			                ("DONE" . (:foreground "cyan" :weight bold))
			                ("MØDE" . (:foreground "blue" :weight bold))
			                ("CANCEL" . (:foreground "red" :weight bold))							
			                ("WAITING" . (:foreground "brown" :weight bold))
			                ("SOMEDAY" . (:foreground "gray" :weight bold)))))

;; Add timstamp to items when done
;; (org-log-done 'time)
(use-package org-superstar
  :straight t
  :config
  (setq org-superstar-leading-bullet " ")
  (setq org-superstar-special-todo-items t) ;; Makes TODO header bullets into boxes
  (setq org-superstar-todo-bullet-alist '(("TODO" . 9744)
                                          ("DONE" . 9744)
                                          ("UDSAT" . 9744)
                                          ("IDEA" . 9744)
                                          ("VENT" . 9744)
                                          ("CANCEL" . 9744)
                                          ("IGANG" . 9744)
                                          ("UDSAT" . 9744)))
  )

(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Prettify UI
(use-package org-modern
  :straight t
  :hook ((org-mode . org-modern-mode)
         (org-agenda-finalize . org-modern-agenda)
         (org-modern-mode . (lambda ()
                              "Adapt `org-modern-mode'."
                              ;; Disable Prettify Symbols mode
                              ;; (setq prettify-symbols-alist nil)
                              (prettify-symbols-mode 1)))))
(use-package org-dashboard
  :ensure t
  :commands (org-dashboard-display))
(setq org-dashboard-files '("~/org/agenda/note.org"
							"~/org/agenda/opgaver.org"
							"~/org/agenda/aftaler.org"
							"~/org/agenda/kontakter.org"
							"~/org/agenda/huskeliste.org"
							"~/org/agenda/møder.org")
	  org-dashboard-show-category t)
(defun my/org-dashboard-filter (entry)
  (and (> (plist-get entry :progress-percent) 0)
	   (< (plist-get entry :progress-percent) 100)
	   (not (member "archive" (plist-get entry :tags)))))

(setq org-dashboard-filter 'my/org-dashboard-filter)

;; Agenda styling
(setq org-agenda-files org-dashboard-files)
(setq org-agenda-span 14
	  org-agenda-tags-column -100
	  org-agenda-clock-report-header " "
	  org-agenda-default-appointment-duration 30
	  org-agenda-log-mode-items nil
	  org-agenda-block-separator ?─
	  org-columns-default-format "%14SCHEDULED %Effort{:} %1PRIORITY %TODO %50ITEM %TAGS"
	  org-agenda-time-grid
	  '((daily today require-timed)
		(800 1000 1200 1400 1600 1800 2000)
		" ...... " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
	  org-agenda-current-time-string
	  "⭠ now ─────────────────────────────────────────────────")

;; (if nec/measure-time (nec/stimer "Keywords, files and agenda"))
(use-package org
  :straight nil
  :commands org-clocking-buffer
  :config
  ;; Custom src-block behaviors
  (progn
	(defun org-insert-src-block (src-code-type)
	  "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
	  (interactive
	   ^	   (let ((src-code-types
					  '("emacs-lisp" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
						"calc" "asymptote" "dot" "gnuplot" "hledger" "lilypond" "mscgen"
						"octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
						"haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
						"scheme" "sqlite")))
				 (list (ido-completing-read "Source code type: " src-code-types))))
	  (progn
		(newline-and-indent)
		(insert (format "#+BEGIN_SRC %s\n" src-code-type))
		(newline-and-indent)
		(insert "#+END_SRC\n")
		(forward-line -2)
		(org-edit-src-code)))
	(defun org-insert-or-edit-src-block (src-code-type &optional interactive-call)
	  "Insert a source code block in org-mode or edit an existing one."
	  (interactive (list nil t))
	  (if (and (org-in-src-block-p)
			   ;; Matching the logic in `org-edit-src-code'
			   (org-src--on-datum-p (org-element-at-point)))
		  (org-edit-src-code)
		(if interactive-call
			(call-interactively 'org-insert-src-block)
		  (org-insert-src-block src-code-type)))))
  ;; Allow an emphasized expression to extend over 15 lines
  (progn
	(setcar (nthcdr 2 org-emphasis-regexp-components) " \t\r\n\"'")
	(setcar (nthcdr 4 org-emphasis-regexp-components) 15)
	(org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components))
  ;; Enable org links that roll dice
  (progn
	(defvar roll-dice-command "rolldice")
	(defun roll-dice (&rest args)
	  (interactive "sRoll dice: ")
	  (let ((result
			 (s-trim
			  (shell-command-to-string
			   (mapconcat #'shell-quote-argument (cons roll-dice-command args) " ")))))
		(when (called-interactively-p)
		  (message result))
		result))
	(defun org-rolldice-open (path)
	  (let ((spec (read-string "Roll dice: " path)))
		(message (roll-dice spec))))
	(org-link-set-parameters
	 "roll"
	 :follow #'org-rolldice-open
	 ;; This must be a lambda so it is self-contained
	 :export (lambda (link desc format) (or desc link))))
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         :map org-mode-map
         ("C-c C-'" . org-insert-or-edit-src-block)
         :map org-src-mode-map
         ("C-c C-'" . org-edit-src-exit)
         ("C-c C-c" . org-edit-src-exit)))

 
(if nec/measure-time (nec/sstimer "org-ns"))

(provide 'org/org-ns)
;;; org.el ends here
