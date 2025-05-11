;;; yassip.el ---   -*- lexical-binding: t; coding: utf-8 -*-

;; Copyright (C),  2024 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@macal.local>

;; Package-Requires: ((emacs "29.2"))
;; Keywords:
;; Homepage:

;; yassip is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; yassip is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with init-snippet.  If not, see http://www.gnu.org/licenses.


;;; Commentary

;; The default configuration of yasnippet consists of activating it
;; and plugging it with company.  Obviously, the package
;; =yasnippet-snippets= is also configured to provide default
;; snippets.  Finally, my own snippets are stored in the directory
;; =~/.emacs.d/snippets=.
;; 

;;; Code:

(setopt tmpfilename  "~/.emacs.d/snippets/")

(setopt yas-snippet-dirs
      (list (concat tmpfilename "bibtex-mode/")
	    (concat tmpfilename "emacs-lisp-mode/" )
	    (concat tmpfilename "latex-mode/")  	
	    (concat tmpfilename "org-mode/")
	    (concat tmpfilename "org-ai-mode/")
	    (concat tmpfilename "python-mode/")))

(use-package yasnippet
  :straight t
  :init (yas-global-mode 1))

(defconst yasnippet-snippets-dir "~/.emacs.d/snippets")

;;;###autoload
(defun yasnippet-snippets-initialize ()
  "Load the `yasnippet-snippets' snippets directory."
  ;; NOTE: we add the symbol `yasnippet-snippets-dir' rather than its
  ;; value, so that yasnippet will automatically find the directory
  ;; after this package is updated (i.e., moves directory).
  (unless (member 'yasnippet-snippets-dir yas-snippet-dirs)
    (add-to-list 'yas-snippet-dirs 'yasnippet-snippets-dir t)
    (yas--load-snippet-dirs)))

(defgroup yasnippet-snippets nil
  "Options for yasnippet setups.

This is useful for customizing options declared in
“.yas-setup.el” files.  For example, you could declare a
customizable variable used for a snippet expansion.

See Info node `(elisp)Customization Types'."
  :group 'yasnippet)

(defun yasnippet-snippets--no-indent ()
  "Set `yas-indent-line' to nil."
  (set (make-local-variable 'yas-indent-line) nil))

;;;###autoload
(eval-after-load 'yasnippet
  '(yasnippet-snippets-initialize))


(setq yas-triggers-in-field t)

(add-hook 'org-mode-hook #'yas-minor-mode)
(add-hook 'elisp-mode-hook #'yas-minor-mode)
(add-hook 'prog-mode-hook #'yas-minor-mode)
(add-hook 'latex-mode-hook #'yas-minor-mode)

(require 'dropdown-list) 
(setq yas-prompt-functions '(yas-dropdown-prompt yas-ido-prompt yas-completing-prompt))

(defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
  (when (featurep 'popup)
    (popup-menu*
     (mapcar
      (lambda (choice)
		(popup-make-item
		 (or (and display-fn (funcall display-fn choice))
			 choice)
		 :value choice))
      choices)
     :prompt prompt
     ;; start isearch mode immediately
     :isearch t)))

(setq yas-prompt-functions '(yas-popup-isearch-prompt yas-maybe-ido-prompt yas-completing-prompt yas-no-prompt))

;; This package bridges the gap between YASnippet and auto-insert-mode. By
;; populating auto-insert-alist with filenames and automatically expanding their
;; content after insertion by auto-insert-mode, it's an easy way to create dynamic
;; file templates. Simply call yatemplate-fill-alist somewhere in your Emacs
;; initialization file to populate auto-insert-alist with filenames from
;; yatemplate-dir.

(require 'autoinsert)
(defvar templates-private-directory "~/.emacs.d/templates"
  "Configurable private templates directory.")

(defvar templates-use-default-templates t
  "If true, do not remove the default settings for
  `auto-insert-mode'. If `nil', ONLY the ones specified by template
  files will be used.")

(setq yatemplate-dir "~/.emacs.d/templates")

(use-package yatemplate)
(setq auto-insert-alist nil)
(yatemplate-fill-alist)
(auto-insert-mode +1)

(if nec/measure-time (nec/sstimer "programming/yassip"))

(provide 'programming/yassip)
;;; init-snippet.el ends here
