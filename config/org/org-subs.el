;;; init-org-subs.el ---   -*- lexical-binding: t; coding: utf-8 -*-

;; Copyright (C),  2024 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@macal.local>

;; Package-Requires: ((emacs "29.2"))
;; Keywords:
;; Homepage:

;; init-org-subs is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; init-org-subs is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with init-org-subs.  If not, see http://www.gnu.org/licenses.

;;; Commentary:


;;; Code:


;; Org Cliplink: insert the link in the clipboard as an org link. Adds the
;; title of the page as the description
;; https://github.com/rexim/org-cliplink
(use-package org-cliplink
  :bind (:map org-mode-map
              ;; "C-c C-l" is bound to `org-insert-link' by default
              ;; "C-c C-L" is bound to `org-cliplink'
              ("C-c C-S-l" . org-cliplink)))

;; org-download: easily add images to org buffers
;; https://github.com/abo-abo/org-download
(use-package org-download
  :after org)

;; https://github.com/snosov1/toc-org/
(use-package toc-org
  :after org
  :hook ((org-mode . toc-org-mode)))

;; pomodoro implementation in org
;; https://github.com/lolownia/org-pomodoro
(use-package org-pomodoro
  :bind (:map org-mode-map
			  ("C-c o p" . org-pomodoro))
  :after org)

;; Rich text clipboard for org-mode
;; https://github.com/unhammer/org-rich-yank
(use-package org-rich-yank
  :bind (:map org-mode-map
              ("C-M-y" . org-rich-yank)))

;; plantuml configuration
(use-package ob-plantuml :straight nil
  :commands
  (org-babel-execute:plantuml)
  :config
  (setq org-plantuml-jar-path (expand-file-name "etc/plantuml.jar" use-emacs.directory)))

(use-package org-drill
  :straight t)

;; Unfortunately, there are various bugs present in org-drill; however the workaround
;; for this package, found on reddit, is provided below:

(defun org-drill-time-to-inactive-org-timestamp (time)
  "Convert TIME into org-mode timestamp."
  (format-time-string
   (concat "[" (cdr org-time-stamp-formats) "]")
   time))


(defun copy-id-to-clipboard()
  "Copy the ID property value to killring,
if no ID is there then create a new unique ID.
This function works only in org-mode buffers.

The purpose of this function is to easily construct id:-links to
org-mode items. If its assigned to a key it saves you marking the
text and copying to the killring."
  (interactive)
  (when (eq major-mode 'org-mode) ; do this only in org-mode buffers
    (setq mytmpid (funcall 'org-id-get-create))
    (kill-new mytmpid)
    (message "Copied %s to killring (clipboard)" mytmpid)))
(bind-key "H-i" 'copy-id-to-clipboard org-mode-map)


(bind-key "C-c C-$" 'hydra-org-clock/body org-mode-map)
(defhydra hydra-org-clock (:color blue
                                  :hint nil)
  "
^Clock:^ ^In/out^     ^Edit^   ^Summary^    | ^Timers:^ ^Run^           ^Insert
-^-^-----^-^----------^-^------^-^----------|--^-^------^-^-------------^------
(_?_)   _i_n         _e_dit    _g_oto entry | (_z_)     _r_elative      ti_m_e
^ ^     _c_ontinue   _q_uit    _d_isplay    |  ^ ^      cou_n_tdown     i_t_em
^ ^     _o_ut        ^ ^       _r_eport     |  ^ ^      _p_ause toggle
^ ^     ^ ^          ^ ^       ^ ^          |  ^ ^      _s_top
"
  ("i" org-clock-in)
  ("c" org-clock-in-last)
  ("o" org-clock-out)
  ("e" org-clock-modify-effort-estimate)
  ("q" org-clock-cancel)
  ("g" org-clock-goto)
  ("d" org-clock-display)
  ("r" org-clock-report)
  ("?" (org-info "Clocking commands"))
  ("r" org-timer-start)
  ("n" org-timer-set-timer)
  ("p" org-timer-pause-or-continue)
  ("s" org-timer-stop)
  ("m" org-timer)
  ("t" org-timer-item)
  ("z" (org-info "Timers")))

(if nec/measure-time (nec/sstimer "org-subs"))

(provide 'org/org-subs)
;;; init-org-subs.el ends here
