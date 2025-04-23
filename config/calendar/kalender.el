;;; kalender.el ---   -*- lexical-binding: t; coding: utf-8 -*-
;; Copyright (C),  2024 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@algon.dk>
;; Package-Requires: ((emacs "31.0.50"))
;; Keywords:
;; Homepage:

;; kalender is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; kalender is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with kalender.  If not, see http://www.gnu.org/licenses.

;;; Commentary:


;;; Code:

(straight-use-package '(emacs-calfw :type git
									:host github
									:repo "kiwanami/emacs-calfw"))
(require 'calfw)
(require 'calfw-org)
(require 'calfw-ical)
(require 'calfw-cal)
;; (require 'calfw-howm) ;; demands howm "a note taking system"


(use-package calendar
  :ensure t
  :hook ((calendar-today-visible . calendar-mark-today))
  :bind (("H-d" . help/hydra/timestamp/body))
  :config
  (setq diary-file (concat user-emacs-directory  "var/diary"))  
  (defhydra help/hydra/timestamp (:color blue :hint nil)
    "
                                                         ╭────────────┐
                                                         │ Timestamps │
 ╭───────────────────────────────────────────────────────┴────────────╯
                                                         Quit [_q_]
  ISO         : date [_d_]
  U.S.        : date [_u/_] year   [_uy_] dashes [_u-_] words [_uw_]
  Europe      : date [_e/_] year   [_ey_] dashes [_e-_] words [_ew_]
  Stamp       : UTC  [_s_]  human  [_h_]
  Epoch       : unix [_E_]  J2000  [_J_]
  Org Active  : date [_a_]  pick   [_p_]
  Org Inactive: date [_i_]  choose [_c_]
"
    ("d" help/insert-datestamp)                         ; 2018-05-12
    ("u/" help/insert-datestamp-us)                      ; 05/12/18
    ("uy" help/insert-datestamp-us-full-year)            ; 05/12/2018
    ("u-" help/insert-datestamp-us-full-year-and-dashes) ; 05-12-2018
    ("uw" help/insert-datestamp-us-words)                ; Saturday May 12, 2018

    ("e/" help/insert-datestamp-eu)                      ; 21/05/18
    ("ey" help/insert-datestamp-eu-full-year)            ; 21/05/2018
    ("e-" help/insert-datestamp-eu-full-year-and-dashes) ; 21-06-2018
    ("ew" help/insert-datestamp-eu-words)                ; Saturday, 12. may 2018		

    ("s" help/insert-timestamp)                         ; 2018-05-12T11:50:01+07:00
    ("h" help/insert-human-stamp) ; 2018-05-12T12:36@Prek Leap (11.642600N-104.919210W)

    ("E" help/insert-unix-time)                         ; 1526100829
    ("J" insert-epoch)                                  ; 579372688.143557080

    ("a" help/org-time-stamp-with-seconds-now)          ; <2018-05-12 Sat 11:50>
    ("p" org-time-stamp)
    ("i" help/org-time-stamp-inactive-with-seconds-now) ; [2018-05-12 Sat 11:50]
    ("c" org-time-stamp-inactive)
    ("q" nil :color blue))

  (defun help/insert-datestamp ()
    "Produces and inserts a partial ISO 8601 format timestamp."
    (interactive)
    (insert (format-time-string "%F")))

  (defun help/insert-datestamp-us ()
    "Produces and inserts a US datestamp."
    (interactive)
    (insert (format-time-string "%m/%d/%y")))

  (defun help/insert-datestamp-eu ()
    "Produces and inserts a Europe datestamp."
    (interactive)
    (insert (format-time-string "%d/%m/%y")))

  (defun help/insert-datestamp-us-full-year-and-dashes ()
    "Produces and inserts a US datestamp with full year and dashes."
    (interactive)
    (insert (format-time-string "%m-%d-%Y")))

  (defun help/insert-datestamp-eu-full-year-and-dashes ()
    "Produces and inserts a Europe datestamp with full year and dashes."
    (interactive)
    (insert (format-time-string "%d-%m-%Y")))

  (defun help/insert-datestamp-us-full-year ()
    "Produces and inserts a US datestamp with full year."
    (interactive)
    (insert (format-time-string "%m/%d/%Y")))

  (defun help/insert-datestamp-eu-full-year ()
    "Produces and inserts a Europe datestamp with full year."
    (interactive)
    (insert (format-time-string "%d/%m/%Y")))

  (defun help/insert-datestamp-us-words ()
    "Produces and inserts a US datestamp using words."
    (interactive)
    (insert (format-time-string "%A %B %d, %Y")))

  (defun help/insert-datestamp-eu-words ()
    "Produces and inserts a Europe datestamp using words."
    (interactive)
    (insert (format-time-string "%A, %d. %b %Y")))

  (defun help/insert-timestamp-no-colons ()
    "Inserts a full ISO 8601 format timestamp with colons replaced by hyphens."
    (interactive)
    (insert (help/get-timestamp-no-colons)))

  (defun help/insert-datestamp ()
    "Produces and inserts a partial ISO 8601 format timestamp."
    (interactive)
    (insert (format-time-string "%F")))

  (defun help/insert-unix-time ()
    "Produce seconds since 1970-01-01 00:00:00 UTC"
    (interactive)
    (insert (format-time-string "%s")))

  (defun help/get-timestamp ()
    "Produces a full ISO 8601 format timestamp."
    (interactive)
    (let* ((timestamp-without-timezone (format-time-string "%Y-%m-%dT%T"))
           (timezone-name-in-numeric-form (format-time-string "%z"))
           (timezone-utf-offset
            (concat (substring timezone-name-in-numeric-form 0 3)
                    ":"
                    (substring timezone-name-in-numeric-form 3 5)))
           (timestamp (concat timestamp-without-timezone
                              timezone-utf-offset)))
      timestamp))

  (defun help/insert-timestamp ()
    "Inserts a full ISO 8601 format timestamp."
    (interactive)
    (insert (help/get-timestamp)))

  (defun help/org-time-stamp-with-seconds-now ()
    (interactive)
    (let ((current-prefix-arg '(16)))
      (call-interactively 'org-time-stamp)))

  (defun help/org-time-stamp-inactive-with-seconds-now ()
    (interactive)
    (let ((current-prefix-arg '(16)))
      (call-interactively 'org-time-stamp-inactive)))

  (defun insert-epoch ()
    "Insert time in seconds from the J2000.0 epoch in
   sec.microseconds, by subtracting unix-time"
    (interactive)
    (insert (epoch-J2000)))

  (defun epoch-J2000 ()
    "Get time in seconds from the J2000.0 epoch in
   sec.microseconds, by subtracting seconds unix-time
   until year 2000"
    (replace-regexp-in-string "\n\\'" ""
			                  (concat
			                   (number-to-string
			                    (round (- (string-to-number
					                       (shell-command-to-string "date +%s")) 946727935)))
			                   (shell-command-to-string "date +.%N")))))

(if nec/measure-time (nec/sstimer "hydra timestamp"))

(if (not (featurep 'appt))
	(require 'appt))   
;; initiate diary
(setq view-diary-entries-initially t
	  mark-diary-entries-in-calendar t
	  number-of-diary-entries 7)
(add-hook 'diary-display-hook 'fancy-diary-display)
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)
  ;;;;;;;;
(defun alt-clean-equal-signs ()
  "This function makes lines of = signs invisible."
  (goto-char (point-min))
  (let ((state buffer-read-only))
	(when state (setq buffer-read-only nil))
	(while (not (eobp))
	  (search-forward-regexp "^=+$" nil 'move)
	  (add-text-properties (match-beginning 0)
						   (match-end 0)
						   '(invisible t)))
	(when state (setq buffer-read-only t))))
(add-hook 'fancy-diary-display-mode-hook '(lambda () (alt-clean-equal-signs)))

  ;;;;

(defun diary-save-hook ()
  "Stuff to do when saving the diary files."
  (appt-initialize))
(defun add-diary-save-hook ()
  "find-file-hooks hook to add the diary-save-hook when appropriate"
  (if (string-match "diary" (buffer-name))
	  (add-hook 'after-save-hook 'diary-save-hook)))
(add-hook 'find-file-hooks 'add-diary-save-hook)

(if nec/measure-time (nec/sstimer "initiate diary "))

										;
;; ---great bit of code from Jeff Miller 
(defface appt-face
  '((t (:foreground "red" :background "white")))
  "Face to indicate a current appointment."
  :group 'appt)

(defadvice appt-disp-window (before appt-hilite-more activate)
  (when appt-mode-string
	(put-text-property 1 (- (length appt-mode-string) 1)
					   'face 'appt-face appt-mode-string)))

(defadvice appt-check (after appt-hilite activate)
  (when appt-mode-string
	(put-text-property 1 (- (length appt-mode-string) 1)
					   'face 'appt-face appt-mode-string)
	(force-mode-line-update)))

;; ---------------------------------
;; compatability - we don't really miss the aliases appt defines anyway.
;; there's no need for this in xemacs or emacs 21.3+
(when (not (fboundp 'defvaralias))
  (defun defvaralias (&rest args)))

(when (require 'appt nil t)
  (setq appt-msg-countdown-list '(10 5 1 0)
		appt-audible (cons 3 .5)
		appt-check-time-syntax nil
		appt-announce-method 'appt-persistant-message-announce
		appt-display-duration 360)

  ;; ding takes a different number of args in gnu emacs - eventually i'll
  ;; redefine this to use my soundcard anyway
  (when (not (featurep 'xemacs))
	(defun appt-beep (&rest args)))

  (defun diary-save-hook ()
	"Stuff to do when saving the diary files."
	(appt-activate 1))

  (defun add-diary-save-hook ()
	"find-file-hooks hook to add the diary-save-hook when appropriate"
	(let* ((diary-file-components (split-string diary-file "/"))
		   (diary-buffer-name
			(nth (1- (length diary-file-components)) diary-file-components)))
	  (if (string= (buffer-name) diary-buffer-name)
		  (add-hook (make-variable-buffer-local 'after-save-hook)
					'diary-save-hook))))

  (add-hook 'find-file-hooks 'add-diary-save-hook))
(if nec/measure-time (nec/sstimer "initiate appt/diary "))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(declare-function cfw:open-calendar-buffer "calfw")
(declare-function cfw:refresh-calendar-buffer "calfw")
(declare-function cfw:org-create-source "calfw-org")
(declare-function cfw:cal-create-source "calfw-cal")

(defun my-calendar ()
  (interactive)
  (let ((buf (get-buffer "*cfw-calendar*")))
	(if buf
		(pop-to-buffer buf nil)
	  (cfw:open-calendar-buffer
	   :contents-sources
	   (list (cfw:org-create-source "Dark Orange")
			 (cfw:cal-create-source "Green"))
	   :view 'month))))
;; `org-autolist` makes org-mode lists behave more like lists in non-programming
;; editors such as Google Docs, MS Word, and OS X Notes.
(use-package org-autolist
  :straight t
  :after org
  :bind ("<C-f12>" . my-calendar)
  :commands cfw:open-calendar-buffer  org-autolist-mode)

(use-package calfw
  :straight nil
  :bind ("C-c A" . my-calendar)
  :init
  (progn
	(use-package calfw-cal
	  :ensure t)
	(use-package calfw-org
	  :ensure t)
	(bind-key "M-n" 'cfw:navi-next-month-command cfw:calendar-mode-map)
	(bind-key "M-p" 'cfw:navi-previous-month-command cfw:calendar-mode-map))
  :config
  (progn
	;; Unicode characters
	(setq cfw:fchar-junction ?╋
		  cfw:fchar-vertical-line ?┃
		  cfw:fchar-horizontal-line ?━
		  cfw:fchar-left-junction ?┣
		  cfw:fchar-right-junction ?┫
		  cfw:fchar-top-junction ?┯
		  cfw:fchar-top-left-corner ?┏
		  cfw:fchar-top-right-corner ?┓)
	(bind-key "j" 'cfw:navi-goto-date-command cfw:calendar-mode-map)
	(bind-key "g" 'cfw:refresh-calendar-buffer cfw:calendar-mode-map)))
(if nec/measure-time (nec/sstimer "Drawing calendar "))

(defadvice org-refile-get-location (before clear-refile-history activate)
  "Fit the Org Agenda to its buffer."
  (setq org-refile-history nil))

(defun jump-to-org-agenda ()
  (interactive)
  (let ((recordings-dir "~/org/agenda/"))
	(ignore-errors
	  (if (directory-files recordings-dir nil "\\`[^.]")
		  (find-file recordings-dir))))
  (let ((buf (get-buffer "*Org Agenda*"))
		wind)
	(if buf
		(if (setq wind (get-buffer-window buf))
			(when (called-interactively-p 'any)
			  (select-window wind)
			  (org-fit-window-to-buffer))
		  (if (called-interactively-p 'any)
			  (progn
				(select-window (display-buffer buf t t))
				(org-fit-window-to-buffer))
			(with-selected-window (display-buffer buf)
			  (org-fit-window-to-buffer))))
	  (call-interactively 'org-agenda-list))))

(defun org-get-global-property (name)
  (save-excursion
	(goto-char (point-min))
	(and (re-search-forward (concat "#\\+PROPERTIES: " name " \\(.*\\)") nil t)
		 (match-string 1))))

	  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun save-org-mode-files ()
  (dolist (buf (buffer-list))
	(with-current-buffer buf
	  (when (eq major-mode 'org-mode)
		(if (and (buffer-modified-p) (buffer-file-name))
			(save-buffer))))))

(run-with-idle-timer 25 t 'save-org-mode-files)
;;** Example 12: org-agenda-view
(defun org-agenda-cts ()
  (and (eq major-mode 'org-agenda-mode)
	   (let ((args (get-text-property
					(min (1- (point-max)) (point))
					'org-last-args)))
		 (nth 2 args))))

(defhydra hydra-org-agenda-view (:hint none)
  "
	  _d_: ?d? day        _g_: time grid=?g?  _a_: arch-trees
	  _w_: ?w? week       _[_: inactive       _A_: arch-files
	  _t_: ?t? fortnight  _f_: follow=?f?     _r_: clock report=?r?
	  _m_: ?m? month      _e_: entry text=?e? _D_: include diary=?D?
	  _y_: ?y? year       _q_: quit           _L__l__c_: log = ?l?"
  ("SPC" org-agenda-reset-view)
  ("d" org-agenda-day-view (if (eq 'day (org-agenda-cts)) "[x]" "[ ]"))
  ("w" org-agenda-week-view (if (eq 'week (org-agenda-cts)) "[x]" "[ ]"))
  ("t" org-agenda-fortnight-view (if (eq 'fortnight (org-agenda-cts)) "[x]" "[ ]"))
  ("m" org-agenda-month-view (if (eq 'month (org-agenda-cts)) "[x]" "[ ]"))
  ("y" org-agenda-year-view (if (eq 'year (org-agenda-cts)) "[x]" "[ ]"))
  ("l" org-agenda-log-mode (format "% -3S" org-agenda-show-log))
  ("L" (org-agenda-log-mode '(4)))
  ("c" (org-agenda-log-mode 'clockcheck))
  ("f" org-agenda-follow-mode (format "% -3S" org-agenda-follow-mode))
  ("a" org-agenda-archives-mode)
  ("A" (org-agenda-archives-mode 'files))
  ("r" org-agenda-clockreport-mode (format "% -3S" org-agenda-clockreport-mode))
  ("e" org-agenda-entry-text-mode (format "% -3S" org-agenda-entry-text-mode))
  ("g" org-agenda-toggle-time-grid (format "% -3S" org-agenda-use-time-grid))
  ("D" org-agenda-toggle-diary (format "% -3S" org-agenda-include-diary))
  ("!" org-agenda-toggle-deadlines)
  ("[" (let ((org-agenda-include-inactive-timestamps t))
		 (org-agenda-check-type t 'timeline 'agenda)
		 (org-agenda-redo)
		 (message "Display now includes inactive timestamps as well")))
  ("q" (message "Abort") :exit t)
  ("v" nil))

;; Recommended binding:
(define-key org-agenda-mode-map "v" 'hydra-org-agenda-view/body)

(if nec/measure-time (nec/sstimer "org agenda calendar"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Recommended binding:
(define-key org-agenda-mode-map "v" 'hydra-org-agenda-view/body)
	  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
										; Erase all reminders and rebuilt reminders for today from the agenda
(defun nec/org-agenda-to-appt ()
  (interactive)
  (setq appt-time-msg-list nil)
  (org-agenda-to-appt))

										; Rebuild the reminders everytime the agenda is displayed
(add-hook 'org-agenda-finalize-hook 'nec/org-agenda-to-appt 'append)

										; This is at the end of my .emacs - so appointments are set up when Emacs starts
(nec/org-agenda-to-appt)

										; Activate appointments so we get notifications
(appt-activate nil)

										; If we leave Emacs running overnight - reset the appointments one minute after midnight
(run-at-time "24:01" nil 'nec/org-agenda-to-appt)


(setq zoneinfo-style-world-list '(("America/Los_Angeles" "Seattle")
								  ("America/New_York" "New York")
								  ("Europe/London" "London")
								  ("Europa/København" "København")
								  ("Asia/Calcutta" "Bangalore")
								  ("Asia/Tokyo" "Tokyo")))



(if nec/measure-time (nec/sstimer "kalender"))

(provide 'calendar/kalender)
;;; kalender.el ends here
