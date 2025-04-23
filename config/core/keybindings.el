;;; key-setting.el ---   -*- lexical-binding: t; coding: utf-8 -*-
;; Copyright (C),  2024 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@algon.dk>
;; Package-Requires: ((emacs "31.0.50"))
;; Keywords:
;; Homepage:

;; key-setting is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; key-setting is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with key-setting.  If not, see http://www.gnu.org/licenses.

;;; Commentary:


;;; Code:
;;  https://github.com/noctuid/general.el
;; (global-set-key "\M-h" 'help-for-help)
;; (global-set-key (kbd "C-q") 'other-window)
;; (global-set-key (kbd "C-k") 'enlarge-window)
;; (global-set-key (kbd "C-i") 'shrink-window)
;; (global-set-key (kbd "C-l") 'enlarge-window-horizontally)
;; (global-set-key (kbd "C-j") 'shrink-window-horizontally)
;; (global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; (global-set-key (kbd "C-c y") 'company-yasnippet)
;; (global-set-key (kbd "C-=") 'text-scale-increase)
;; (global-set-key (kbd "C--") 'text-scale-decrease)
;; (global-set-key (kbd "C-0") 'text-scale-adjust)
;; (global-set-key (kbd "C-c h") 'hs-hide-block)
;; (global-set-key (kbd "C-c s") 'hs-show-block)
;; (global-set-key (kbd "C-c C-r") 'lsp-rename)
;; (global-set-key (kbd "C-=") 'text-scale-increase)
;; (global-set-key (kbd "C--") 'text-scale-decrease)
;; (global-set-key (kbd "C-0") 'text-scale-adjust)
;; (global-set-key (kbd "C-c h") 'hs-hide-block)
;; (global-set-key (kbd "C-c s") 'hs-show-block)
;; (global-set-key (kbd "C-c C-r") 'lsp-rename)

(global-unset-key (kbd "C-z"))

(straight-use-package '(general :type git
				:host github
				:repo "noctuid/general.el"))
(defalias 'gsetq #'general-setq)
(defalias 'gsetq-local #'general-setq-local)
(defalias 'gdefine-key #'general-define-key)
(defalias 'gsetq-default #'general-setq-default)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
(general-define-key "<f2>" #'dashboard-open)
;; (general-define-key "<f6>" 'ivy-resume)
;; (general-define-key "<f7>" 'nec/copy-id-to-clipboard)
;; (general-define-key "<f12>" 'xwidget-webkit-browse-url)
;; ;; zoom in/out the screen
;; (general-define-key "C-+" 'text-scale-increase)
;; (general-define-key "C--" 'text-scale-decrease)
(general-define-key "C-M-=" 'increase-default-font-height)
(general-define-key "C-M--" 'decrease-default-font-height)
;; ;; ;; crux
(general-define-key "C-a"  'crux-move-beginning-of-line)
(general-define-key "C-x K" 'crux-kill-other-buffers)
(general-define-key "C-x 4 t"  'crux-transpose-windows)
(general-define-key "M-o"  'crux-smart-open-line)
(general-define-key "C-c D"  'crux-delete-file-and-buffer)
;; ;; (general-define-key "C-c i r" 'crux-reopen-as-root-mode)
(general-define-key "C-c e i"  'crux-find-user-init-file)
(general-define-key "C-k"  'crux-smart-kill-line)
(general-define-key "C-c c b" 'crux-buffer-mode)
(general-define-key "C-c c R" 'crux-rename-file-and-buffer)
(general-define-key "C-c c D" 'crux-delete-file-and-buffer)
(general-define-key "C-c C-z" 'hydra-toggle/body)
(general-define-key "C-c C-," 'org-insert-structure-template)
;; ;; ;; osx library
(general-define-key 
 :prefix "<f1>"
 "F" 'counsel-describe-function
 "v" 'counsel-describe-variable
 "o" 'counsel-describe-symbol
 "l" 'counsel-find-library)
;; RefTeX keys
(general-define-key "C-c ="  'reftex-toc)


;; ;; 
;; (general-define-key
;; :prefix "C-c o"
;; "E u"  'udgifter/body
;; "f" 'org-journal-next-entry
;; "b" 'org-journal-previous-entry
;; "j" #'org-journal-new-entry
;; "s" 'org-journal-search)
;; ;; "R" #'rcd-org-agenda-dashboard					  
;; ;; ;; org roam
;; ;; "n l"  'org-roam
;; ;; "n g"  'org-roam-ui-open
;; ;; "n f"  'org-roam-node-find
;; ;; "n i"  'org-roam-node-insert
;; ;; "n c"  'org-roam-capture
;; ;; "n h"  'org-roam-hydra/body
;; ;; "r r" 'org-backlink-mode-refresh-rate
;; ;; "r s" 'org-backlink-mode-refresh-rate  
;; ;; "r m" 'org-backlink-mode
;; (general-define-key
;; :prefix "C-c s"
;; "s"    'org-super-links-link
;; "l"    'org-super-links-store-link
;; "C-l"  'org-super-links-insert-link
;; "d"    'org-super-links-quick-insert-drawer-link
;; "i"    'org-super-links-quick-insert-inline-link
;; "C-d"  'org-super-links-delete-link
;; )
;; ;; ;; ivy
;; ;; (general-define-key  "C-s" 'ctrlf-forward-literal)
;; ;; (general-define-key  "C-r" 'ctrlf-backward-literal)
;; ;; ;;
;; (general-define-key "C-c g"    'magit-status)
;; (general-define-key "C-x g x"  'magit-checkout)
;; (general-define-key "C-x g c"  'magit-commit)
;; (general-define-key "C-x g p"  'magit-push)
;; (general-define-key "C-x g u"  'magit-pull)
;; (general-define-key "C-x g e"  'magit-ediff-resolve)
;; (general-define-key "C-x g r"  'magit-rebase-interactive)
;; ;; ;; misc
;; ;; (general-define-key "M-g M-g" 'hydra-git-gutter/body)
;; ;; ;;(general-define-key "C-M-S-s-d" 'deft)
;; ;; ;;(general-define-key "C-x C-g" 'deft-find-file)
;; ;; (general-define-key "C-c r e"  'ebib)
;; ;; (general-define-key "C-c r r"  'org-ebib-open)
;; ;; (general-define-key "C-c r s"  'org-ebib-store-link)
;; ;; (general-define-key "C-c d"  'docker)
;; ;; 
;; ;; (general-define-key "C-c C-c C-b" 'cargo-build)
;; ;; (general-define-key "C-c C-c C-r" 'cargo-run)
;; ;; (general-define-key "C-c C-c C-t" 'cargo-test)
(general-define-key "C-c q" 'auto-fill-mode)
(general-define-key "C-c l" 'org-store-link)
(general-define-key "C-c a" 'org-agenda)
(general-define-key "C-c c" 'org-capture)
;; ;; ;;				 (general-define-key
;; ;; ;;				   :keymaps 'projectile-mode-map 
;; ;; ;;					   "C-c p" 'projectile-command-map)
;; ;; (general-define-key "C-a" 'beginning-of-line-dwim)
;; ;; (general-define-key "C-x o" 'ace-window)
;; ;;
;; 
(if nec/measure-time  (nec/sstimer "core/keybindings)"))

(provide 'core/keybindings)
;;; key-setting.el ends here
