;;; -*- lexical-binding: t; -*-
;;; -*-no-byte-compile: t; -*- initial file for NEC configurtion
;;;init.el ---  main init file for emacs configuration
;;
;; Filename: init.el
;; Description:
;; Author: Niels Søndergaard
;; Created: Fri Jun 12 10:49:04 2020 (+0200)
;; Version: 1.0
;; Last-Updated: Fre Nov 27 20:19:06 2020 (+0100)
;;           By: Niels Søndergaard
;;     Update #: 6
;; Keywords:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Commentary:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;
;;; Code:
(setq straight-use-package-by-default t)
;; (setq straight-vc-git-default-clone-depth 'full)
(defvar bootstrap-version)
(let* ((straight-repo-dir
        (expand-file-name "straight/repos" user-emacs-directory))
       (bootstrap-file
        (concat straight-repo-dir "/straight.el/bootstrap.el"))
       (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (shell-command
     (concat
      "mkdir -p " straight-repo-dir " && "
      "git -C " straight-repo-dir " clone "
      "https://github.com/raxod502/straight.el.git && "
      "git -C " straight-repo-dir " checkout 2d407bc")))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)
(setq straight-check-for-modifications '(check-on-save find-when-checking))
;; =M-x straight-pull-all=: update all packages.
;; =M-x straight-normalize-all=: restore all packages (remove local edits)
;; =M-x straight-freeze-versions= and =M-x straight-thaw-versions= are like =pip
;;  freeze requirements.txt= and =pip install -r requirements.txt=
 (setq straight-use-package-by-default t)
 (straight-use-package 'use-package)
;; ensure we can install from git sources
 (straight-use-package '(git :type git :flavor melpa :host github :repo "rejeep/git.el"))
 (if nec/measure-time (nec/timer "After load of straight and git.... "))

(straight-use-package '(org :type git :repo "https://code.orgmode.org/bzg/org-mode.git" :local-repo "org")
                            :diminish " O")
(straight-use-package '(org-plus-contrib :type git :repo "https://code.orgmode.org/bzg/org-mode.git"
                                         :local-repo "org" :files (:defaults "contrib/lisp/*.el")))
;; need to get hold of org a soon as possible
(straight-use-package '(dash :type git :flavor melpa :files ("dash.el" "dash.texi" "dash-pkg.el") :host github :repo "magnars/dash.el"))
(straight-use-package '(f :type git :flavor melpa :files ("f.el" "f-pkg.el") :host github :repo "rejeep/f.el"))
(straight-use-package '(ht :type git :flavor melpa :files ("ht.el" "ht-pkg.el") :host github :repo "Wilfred/ht.el"))
(straight-use-package '(s :type git :flavor melpa :files ("s.el" "s-pkg.el") :host github :repo "magnars/s.el"))
(straight-use-package '(ts :type git :flavor melpa :host github :repo "alphapapa/ts.el"))
(straight-use-package '(a :type git :flavor melpa :host github :repo "plexus/a.el"))
(straight-use-package '(org-ql :type git :flavor melpa :host github :repo "alphapapa/org-ql"))
(straight-use-package '(emacsql :type git :flavor melpa :files ("emacsql.el" "emacsql-compiler.el" "emacsql-system.el" "README.md" "emacsql-pkg.el") :host github :repo "skeeto/emacsql"))
(straight-use-package '(emacsql-sqlite3 :type git :flavor melpa :host github :repo "cireu/emacsql-sqlite3"))
(if nec/measure-time (nec/timer "Load general routines "))
;; Anaphoric expressions implicitly create one or more temporary
;; variables which can be referred to during the expression.  This
;; technique can improve clarity in certain cases.  It also enables
;; recursion for anonymous functions.
;; (use-package anaphora
;;    :straight t)           ;; anaphora
(setq org-export-backends '(ascii
                            beamer
                            html
                            icalendar
                            latex
                            md
                            odt
                            koma-letter))
;; Key Chord functionality in use-package
(use-package use-package-chords
  :straight t
  :config (key-chord-mode 1))
(defmacro use-feature (name &rest args)
  "Like `use-package', but with `straight-use-package-by-default' disabled.
NAME and ARGS are as in `use-package'."
  (declare (indent defun))
  `(use-package ,name
     ,@args))

;; Feature `straight-x' from package `straight' provides
;; experimental/unstable extensions to straight.el which are not yet
;; ready for official inclusion.
;;(use-feature straight-x
;; Add an autoload for this extremely useful command.y
;;  :commands (straight-x-fetch-all))

(straight-use-package 'general)
(use-package general
  :init
  (defalias 'gsetq #'general-setq)
  (defalias 'gsetq-local #'general-setq-local)
  (defalias 'gsetq-default #'general-setq-default))

(setq garbage-collection-messages nil)
;;
(defvar current-date-time-format "%a %b %d %Y-%m-%dT%H:%M:%S "
  "Format of date to insert with `insert-current-date-time' func
   See help of `format-time-string' for possible replacements")
;; from: http://stackoverflow.com/questions/251908/how-can-i-insert-current-date-and-time-into-a-file-using-emacs
(defvar current-time-format "%a %H:%M:%S"
  "Format of date to insert with `insert-current-time' func.
   Note the weekly scope of the command's precision.")
;;
;; local load list
(add-to-list 'load-path (concat my-user-emacs-directory "lisp"))
(setq custom-theme-directory "~/.emacs.d/themes")
;;;;  package.el
;;; so package-list-packages includes them
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;;; get and untangle the config.org file
(defun my-tangle-config-org ()
  "This function will write all source blocks from =config.org= into =config.el= that are ...
- not marked as =tangle: no=
- doesn't have the TODO state =DISABLED=
- have a source-code of =emacs-lisp="
  (require 'org)
  (let* ((body-list ())
         (output-file (concat my-user-emacs-directory "config.el"))
         (org-babel-default-header-args (org-babel-merge-params org-babel-default-header-args
                                                                (list (cons :tangle output-file)))))
    (message "—————• Re-generating %s …" output-file)
    (save-restriction
      (save-excursion
        (org-babel-map-src-blocks (concat my-user-emacs-directory "config.org")
	  (let* (
		 (org_block_info (org-babel-get-src-block-info 'light))
		 ;;(block_name (nth 4 org_block_info))
		 (tfile (cdr (assq :tangle (nth 2 org_block_info))))
		 (match_for_TODO_keyword)
		 )
	    (save-excursion
	      (catch 'exit
		;;(when (string= "" block_name)
		;;  (message "Going to write block name: " block_name)
		;;  (add-to-list 'body-list (concat "message(\"" block_name "\")"));; adding a debug statement for named blocks
		;;  )
		(org-back-to-heading t)
		(when (looking-at org-outline-regexp)
		  (goto-char (1- (match-end 0))))
		(when (looking-at (concat " +" org-todo-regexp "\\( +\\|[ \t]*$\\)"))
		  (setq match_for_TODO_keyword (match-string 1)))))
	    (unless (or (string= "no" tfile)
			(string= "DISABLED" match_for_TODO_keyword)
			(not (string= "emacs-lisp" lang)))
	      (add-to-list 'body-list (concat "\n\n;; #####################################################################################\n"
					      "(message \"config • " (org-get-heading) " …\")\n\n"))
	      (add-to-list 'body-list body)
	      ))))
      (with-temp-file output-file
        (insert ";;; init.el --- -*- lexical-binding: t -*-\n")
        (insert ";; ============================================================\n")
        (insert ";; Don't edit this file, edit config.org' instead ...\n")
        (insert ";; Auto-generated at " (format-time-string current-date-time-format (current-time)) " on host " system-name "\n")
        (insert ";; ============================================================\n")
        (insert (apply 'concat (reverse body-list))))
      (message "—————• Wrote %s" output-file))))

;; following lines are executed only when my-tangle-config-org-hook-func()
;; was not invoked when saving config.org which is the normal case:
(let ((orgfile (concat my-user-emacs-directory "config.org"))
      (elfile (concat my-user-emacs-directory "config.el")))
  (when (or (not (file-exists-p elfile))
            (file-newer-than-file-p orgfile elfile))
    (my-tangle-config-org)
    ;;(save-buffers-kill-emacs);; TEST: kill Emacs when config has been re-generated due to many issues when loading newly generated config.el
    )
  (load-file elfile))

;; when config.org is saved, re-generate config.el:
(defun my-tangle-config-org-hook-func ()
  (when (string= "config.org" (buffer-name))
	(let ((orgfile (concat my-user-emacs-directory "config.org"))
		  (elfile (concat my-user-emacs-directory "config.el")))
	  (my-tangle-config-org))))
(add-hook 'after-save-hook 'my-tangle-config-org-hook-func)
(message "→★ loading init.el in %.2fs" (float-time (time-subtract (current-time) my-init-el-start-time)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(put 'dired-find-alternate-file 'disabled nil)
