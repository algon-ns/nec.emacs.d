;;; org-roam-load.el ---   -*- lexical-binding: t; coding: utf-8 -*-




(setq org-roam-directory (file-truename "~/org/roam/"))
(setq org-roam-db-location "~/org/roam/.database/org-roam.db")

(use-package org-roam
  :straight t
  :init
  (org-roam-db-autosync-mode))

(setq org-roam-completion-everywhere t)
(setq org-roam-bibtex-mode t)
(setq org-roam-db-gc-threshold most-positive-fixnum)

;; winner-mode can be used as a simple version of browser history for Org-roam. Each click through org-roam links
;; (from both Org files and the backlinks buffer) causes changes in window configuration, which can be undone and
;; redone using winner-mode.
(winner-mode +1)
(define-key winner-mode-map (kbd "<M-left>") #'winner-undo)
(define-key winner-mode-map (kbd "<M-right>") #'winner-redo)


(require 'org-roam-dailies)
(setq org-roam-database-connector 'sqlite-builtin) 


(setq org-roam-capture-templates
	  '(("d" "default" plain "%?"
		 :target (file+head "%<%Y%m%d%H%M%S>-${slug}.roam.org"
				    "#+title: ${title}\n")
		 :unnarrowed t)))	  
(setq org-roam-dailies-directory "daglig/")
(setq org-roam-dailies-capture-templates
	  '(("d" "default" entry
		 "* %?"
		 :target (file+head "%<%Y-%m-%d>.roam.org"
				    "#+title: %<%Y-%m-%d>\n"))))

(require 'org-roam-export)

(general-define-key 
 :prefix "C-c"					  
 ;; org roam
 "n l"  'org-roam
 "n g"  'org-roam-ui
 "n o"  'org-id-get-create
 "n r"  'org-roam-alias-add
 "n f"  'org-roam-node-find
 "n i"  'org-roam-node-insert
 "n c"  'org-roam-capture
 "n j"  'org-roam-dailies-today    ;; Dailies	   
 "n h"  'org-roam-hydra/body)

(defhydra org-roam-hydra (:color red :idle 0.8 :exit t)
  "Launcher for `org-roam'"
  ("i" org-roam-node-insert "insert" :column "Org Roam")
  ("si" org-super-links-insert-link "super insert" :column "Org Roam")
  ("I" org-roam-node-insert-immediate "node-insert-immediate" :column "Org Roam")
  ("f" org-roam-node-find "node-find" :column "Org Roam")
  ("v" org-roam-buffer-activate "backlinks" :column "Misc. Roam")
  ("t" org-roam-tag-add "add tag"  :column "Misc. Roam")
  ("o" org-id-get-create "get ID"  :column "Misc. Roam")
  ("l" org-roam-buffer-toggle "buffer toggle"  :column "Misc. Roam")
  ("c" org-roam-capture "capture" :column "Capture Roam")
  ("j" org-roam-dailies-capture-today "dailies-capture-today" :Column "Capture Roam")
  ("a" org-roam-alias-add "add alias" :column "Capture Roam")
  ("g" org-roam-ui-open "orui graph" :column "Graphic UI")
  ("q" nil "quit menu" :color blue :column nil))

(use-package org-roam-timestamps
  :straight t
  :after org-roam
  :config (org-roam-timestamps-mode))
(setq org-roam-timestamps-parent-file t)
(setq org-roam-timestamps-remember-timestamps t)
(setq org-roam-timestamps-minimum-gap 3600)

(use-package deft
  :straight t
  :after org
  :bind
  ("C-c n d" . deft)
  :custom
  (deft-recursive t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension "org")
  (deft-directory org-roam-directory))

;; Org-download lets you screenshot and yank images from the web into your notes
(use-package org-download
  :straight t
  :after org
  :bind
  (:map org-mode-map
        (("s-Y" . org-download-screenshot)
         ("s-y" . org-download-yank))))


(straight-use-package 'websocket)


(use-package org-roam-ui
  :straight t
  :after org-roam
  ;; normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;; a hookable mode anymore, you're advised to pick something yourself
  ;; :hook (after-init . org-roam-ui-mode)
  :config
  ;; (org-roam-ui-sync-theme t)
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start nil))

(if nec/measure-time (nec/sstimer "org-roam"))
(provide 'org/org-roam-load)
