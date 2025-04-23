;;; org-star.el ---   -*- lexical-binding: t; coding: utf-8 -*-
;; Copyright (C),  2024 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@algon.dk>
;; Package-Requires: ((emacs "31.0.50"))
;; Keywords:
;; Homepage:

;; org-star is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; org-star is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with org-star.  If not, see http://www.gnu.org/licenses.

;;; Commentary:


;;; Code:
;; (setq org-superstar-headline-bullets-list '("◉" "⁑" "⁂" "❖" "✮" "✱" "✸"))
;; (setq org-superstar-headline-bullets-list '(?◉ ?⁑ ?⁂ ?❖ ?✮ ?✱ ?✸))
;;hexagrams
;; “✡” “⎈” “✽” “✲” “✱” “✻” “✼” “✽” “✾” “✿” “❀” “❁” “❂” “❃” “❄” “❅” “❆” “❇”
;; circles
;; “○” “☉” “◎” “◉” “○” “◌” “◎” “●” “◦” “◯” “⚪” “⚫” “⚬” “❍” “￮” “⊙” “⊚” “⊛” “∙” “∘”
;; special circles
;; “◐” “◑” “◒” “◓” “◴” “◵” “◶” “◷” “⚆” “⚇” “⚈” “⚉” “♁” “⊖” “⊗” “⊘”
;; crosses
;; “✙” “♱” “♰” “☥” “✞” “✟” “✝” “†” “✠” “✚” “✜” “✛” “✢” “✣” “✤” “✥”
;; poker sybmols
;; “♠” “♣” “♥” “♦” “♤” “♧” “♡” “♢”
;; yinyang
;; “☯” “☰” “☱” “☲” “☳” “☴” “☵” “☶” “☷”
;; special symbols
;; “☀” “♼” “☼” “☾” “☽” “☣” “§” “¶” “‡” “※” “✕” “△” “◇” “▶” “◀” “◈”
;; 
;; (use-package org-superstar
;; :straight t
;; :hook (org-mode . org-superstar-mode)
;; :config (setq org-superstar-headline-bullets-list '("◉" "⁑" "⁂" "❖" "✮" "✱" "✸")
;; org-superstar-item-bullet-alist '((?* . ?•) (?+ . ?➤) (?- . ?•))))
;; 
;; (add-hook 'org-mode-hook (lambda () (org-superstar-mode t)))

;; use org-bullets-mode for utf8 symbols as org bullets
(straight-use-package 'org-superstar)
(setq org-superstar-headline-bullets-list '("◉" "⁑" "⁂" "❖" "✮" "✱" "✸"))
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(setq org-ellipsis "⚡ ∞ ⚡")
(if nec/measure-time (nec/sstimer "org-star/bullets"))

(provide 'org/org-star)
;;; org-star.el ends here
