;;; file-header.el  -*- lexical-binding: t; -*-
;; Copyright (c) 2021-2021, Niels Søndergaard niels@algon.dk
;;
;; Author: Niels Søndergaard, niels@algon.dk
;; URL: https://github.com/algon-ns/nec.emacs.d
;; This code is taken from the original "header2.el" by
;; Description: Support for creation and update of file headers.
;; Author: Lynn Slater
;;         Drew Adams
;; Maintainer: Drew Adams (concat "drew.adams" "@" "oracle" ".com")
;; Copyright (C) 1996-2019, Drew Adams, all rights reserved.
;; Copyright (C) 1989 Free Software Foundation, Inc.
;; Copyright (C) 1988 Lynn Randolph Slater, Jr.
;; Created: Tue Aug  4 17:06:46 1987
;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Support for creation and update of file headers.
;;
;; Commands (interactive functions) defined here:
;;
;;   `make-header', `make-revision', `make-divider',
;;   `make-box-comment', `make-box-comment-region',
;;   `update-file-header'.
;;
;; Other functions defined here:
;;
;;   `auto-make-header', `auto-update-file-header',
;;   `delete-and-forget-line', `header-AFS', `header-author',
;;   `header-blank', `header-code', `header-commentary',
;;   `header-compatibility', `header-copyright',
;;   `header-creation-date', `header-date-string',
;;   `header-description', `header-doc-url',`header-end-line',
;;   `header-eof', `header-file-name', `header-free-software',
;;   `header-history', `header-keywords', `header-lib-requires',
;;   `header-maintainer', `header-mode-line',
;;   `header-modification-author', `header-modification-date',
;;   `header-multiline', `header-pkg-requires',
;;   `header-prefix-string', `header-rcs-id', `header-rcs-log',
;;   `header-sccs', `header-shell', `header-status', `header-title',
;;   `header-toc', `header-update-count', `header-url',
;;   `header-version', `headerable-file-p', `make-box-comment',
;;   `make-divider', `make-revision', `nonempty-comment-end',
;;   `nonempty-comment-start', `register-file-header-action',
;;   `section-comment-start', `true-mode-name', `uniquify-list',
;;   `update-file-name', `update-last-modified-date',
;;   `update-last-modifier', `update-lib-requires',
;;   `update-write-count'.
;;
;; User options (variables) defined here:
;;
;;   `header-copyright-notice', `header-date-format',
;;   `header-history-label', `header-max',
;;   `make-box-comment-region-replace-prefix-flag',
;;   `make-header-hook'.
;;
;; Other variables defined here:
;;
;;   `file-header-update-alist', `header-auto-update-enabled',
;;   `header-multiline', `header-prefix-string', `return-to'.
;;
;;
;; To have Emacs update file headers automatically whenever you save a
;; file, put this in your init file (~/.emacs):
;;
;;   (autoload 'auto-update-file-header "file-header")
;;   (add-hook 'write-file-hooks 'auto-update-file-header)
;;
;; To have Emacs add a file header whenever you create a new file in
;; some mode, put this in your init file (~/.emacs):
;;
;;   (autoload 'auto-make-header "file-heder")
;;   (add-hook 'emacs-lisp-mode-hook 'auto-make-header)
;;   (add-hook 'c-mode-common-hook   'auto-make-header)
;;   (add-hook 'org-mode-hook 'auto-make-header)
;;   ...
;;
;;
;;     Mode-specific headers:
;;     ---------------------
;;      Not all headers need look alike.  Suppose that you have a unix script mode
;;      and want it to have a shell specifier line that all other headers do not
;;      have.  To do this, Place the following line in a hook called when the
;;      mode is invoked or in the code that establishes the mode:
;;
;;         (add-hook 'make-header-hook 'header-shell nil t)

;;      The header building blocks are sensitive to the different comment
;;      characters in different modes.
;;
;;     Mode specific update actions:
;;     ----------------------------
;;      Suppose something needs to be automatically maintained only in certain
;;      modes.  An example is the .TH macro in man pages.  You can create mode-
;;      specific update actions by placing code like the following in the
;;      mode creation function of the mode hook.
;;
;;        (register-file-header-action
;;          "^\.TH[ \t]+[^\" \t]+[ \t]+[^\" \t]+[ \t]+\"\\([^\"]*\\)\""
;;         'update-last-modified-date-macro)
;;
;;     Define individual header elements.  These are the building blocks
;;     used to construct a site specific header.  You may add your own
;;     functions either in this file or in your `.emacs' file.  The
;;     variable `make-header-hook' specifies the functions that will
;;     actually be called.
;;
;; Note on change-control systems:
;;
;;  If you use `header2.el' in a change-control system, such as RCS,
;;  you might need to leave it checked out.  This is because any
;;  change-control keywords in the file will be expanded during
;;  check-in.  Normally, you will want those keywords to be inserted
;;  in file headers unexpanded.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;;; TBD
;;; Code:

(require 'lib-requires nil t)
  ;; (no error if not found):
  ;; libreq-insert-lib-requires-as-comment, libreq-file-header

;;;;;;;;;;;;;;;;;;;;;;
;; Quiet byte-compiler.
(defvar c-style)
(defvar explicit-shell-file-name)
(defvar libreq-file-header)
 
;; User Options (Variables) --------------------------------

(defgroup Automatic-File-Header nil
  "File header insertion and updating."
  :group 'files :group 'editing :group 'convenience :group 'programming
  :group 'development
  :link `(url-link :tag "Send Bug Report"
          ,(concat "mailto:" "niels" "@" "algon" ".dk?subject=\
file-header.el bug: \
&body=Describe bug here, starting with `emacs -q'.  \
Don't forget to mention your Emacs and library versions.")))

(defcustom header-max 5000
  "*Maximum number of chars to examine for header updating."
  :type 'integer :group 'Automatic-File-Header)

(defcustom header-copyright-notice nil
  "*Copyright notice to be inserted into file headers."
    :type '(choice (const :tag "No copyright notice (value nil)" nil) string)
    :group 'Automatic-File-Header)

(defcustom header-date-format t
  "*Date/time format for header timestamp.
The value can be a string, t, or nil.
A string value is passed to `format-time-string'.
t means use local time with timezone; nil means use UTC."
  :group 'Automatic-File-Header
  :type '(choice
          (const  :tag "Local time, with timezone" t)
          (const  :tag "UTC" nil)
          (string :tag "Custom format")))

;; Change this as you like.
;; Note that the Elisp manual, node Library Headers, suggests putting copyright just
;; after header-description.  That is not done here, by default, because I feel that
;; copyright is not the first information people are looking for.  Otherwise, this
;; default value corresponds to what the Elisp manual recommends for Emacs Lisp.
(defcustom make-header-hook '(
                              ;;header-mode-line
                              header-title
                              header-blank
                              header-file-name
                              header-description
                              ;;header-status
                              header-author
                              header-maintainer
                              header-copyright
                              header-creation-date
                              ;;header-rcs-id
                              header-version
                              header-pkg-requires
                              ;;header-sccs
                              header-modification-date
                              header-modification-author
                              header-update-count
                              header-url
                              header-doc-url
                              header-keywords
                              header-compatibility
                              header-blank
                              header-lib-requires
                              header-end-line
                              header-commentary
                              header-blank
                              header-blank
                              header-blank
                              header-end-line
                              header-history
                              header-blank
                              header-blank
                              ;; header-rcs-log
                              header-end-line
                              header-free-software
                              header-code
                              header-eof)
                              
  "*Functions that insert header elements.
Each function is started on a new line and is expected to end in a new line.
Each function may insert any number of lines, but each line, including the
first, must be started with the value of `header-prefix-string'.
\(This variable holds the same value as would be returned by calling
`header-prefix-string' but is faster to access.)  Each function may set the
following global variables:

  `header-prefix-string' -- mode-specific comment sequence
  `return-to' -- character position to which point will be moved after header
                 functions are processed.  Any header function may set this,
                 but only the last setting will take effect.

It is reasonable to locally set these hooks according to certain modes.
For example, a table of contents might only apply to code development modes
and `header-shell' might only apply to shell scripts.  See instructions in
file 'file-header.el' to do this."
  :type 'hook :group 'Automatic-File-Header)

(defcustom header-history-label "Change Log:" ; Was "HISTORY:" before.
  "*Label introducing change log history."
  :type 'string :group 'Automatic-File-Header)

(defcustom header-free-software
  "This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or (at
your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>."

  "*Text saying that this is free software"
  :type 'string :group 'Automatic-File-Header)

(defcustom make-box-comment-region-replace-prefix-flag nil
  "Non-nil means remove any comment prefix from lines, before boxing."
  :type 'boolean :group 'Automatic-File-Header)
 
;;; Internal variables -------------------------------------
(defvar header-auto-update-enabled t
  "Non-nil means file-header updating is enabled for current buffer.")
(make-variable-buffer-local 'header-auto-update-enabled)
(when (boundp 'safe-local-variable-values)
  (add-to-list 'safe-local-variable-values '(header-auto-update-enabled)))
(defvar return-to nil
  "Position to move point to after header fns are processed.
Any header function may set this.  The last setting will take effect.")
(defvar header-multiline ""
  "Multiline text to be inserted as a comment.
Leave the global value of this as \"\", and bind the value as needed.")

(defvar file-header-update-alist ()
  "Used by `update-file-header' to know what to do in a file.
Is a list of sets of cons cells where the car is a regexp string and the cdr is
the function to call if the string is found near the start of the file.")

(defvar header-prefix-string ""
  "Mode-specific comment prefix string for use in headers.")
 
;;; Functions ----------------------------------------------
(defsubst nonempty-comment-start ()
  "Return `comment-start', or nil if it is an empty string."
  (and (not (equal "" comment-start))  comment-start))
(defsubst nonempty-comment-end ()
  "Return `comment-end', or nil if it is an empty string."
  (and (not (equal "" comment-end))  comment-end))
(defsubst header-blank ()
  "Insert `header-prefix-string' followed by a newline char."
  (insert (concat header-prefix-string "\n")))

;; Major section headings
(defsubst section-comment-start ()
  "Comment start of major section headings."
  (if (= (length comment-start) 1)      ; e.g. Lisp: ";; \n;;;"
      (concat header-prefix-string "\n" comment-start header-prefix-string)
    (concat "\n" comment-start)))       ; e.g. C: "\n/*"

(defsubst header-title ()
  "Insert buffer's file name and leave room for a description.
In `emacs-lisp-mode', this should produce the title line for library
packages."
  (insert (concat comment-start
                  (and (= 1 (length comment-start))  header-prefix-string)
                  (if (buffer-file-name)
                      (file-name-nondirectory (buffer-file-name))
                    (buffer-name))
                  " --- " "\n"))
  (setq return-to  (1- (point))))

(defsubst header-file-name ()
  "Insert \"Filename: \" line, using buffer's file name."
  (insert (concat header-prefix-string
                  "Filename: "
                  (if (buffer-file-name)
                      (file-name-nondirectory (buffer-file-name))
                    (buffer-name))
                  "\n")))

(defsubst header-description ()
  "Insert \"Description: \" line."
  (insert (concat header-prefix-string "Description: \n")))

(defsubst header-author ()
  "Insert current user's name (`user-full-name') as this file's author."
  (insert (concat header-prefix-string "Author: " (user-full-name) "\n")))

(defsubst header-maintainer ()
  "Insert \"Maintainer: \" line."
  (insert (concat header-prefix-string "Maintainer: \n")))

(defun header-copyright ()
  "Insert `header-copyright-notice', unless nil."
  (when header-copyright-notice
    (let ((start  (point)))
      (insert header-copyright-notice)
      (save-restriction
        (narrow-to-region start (point))
        (goto-char (point-min))
        ;; Must now insert header prefix.  Cannot just replace string,
        ;; because that would cause too many undo boundries.
        (insert (concat header-prefix-string))
        (while (progn (skip-chars-forward "^\n") (looking-at "\n"))
          (forward-char 1) (unless (eolp) (insert (concat header-prefix-string))))
        (goto-char (point-max))))))

(defsubst header-creation-date ()
  "Insert today's time, date, and time zone as file creation date."
  (insert (concat header-prefix-string "Created: "))
  (insert (header-date-string) "\n"))

(defun header-date-string ()
  "Current date and time."
  (format-time-string
   (cond ((stringp header-date-format) header-date-format)
         (header-date-format "%a %b %e %T %Y (%z)")
         (t                  "%Y-%m-%dT%T%z")) ; An alternative: "%a %b %e %T %Y (UTC)"
   (current-time)
   (not header-date-format)))

(defsubst header-rcs-id ()
  "Insert lines to record RCS id information (\"$Id$\n\")."
  (insert (concat header-prefix-string "Version: $Id$\n")))

(defsubst header-version ()
  "Insert lines to record version information."
  (insert (concat header-prefix-string "Version: \n")))

(defsubst header-sccs ()
  "Insert a line to record SCCS version information."
  (insert (concat header-prefix-string "Version: %W%    %E%    %U%\n")))

(defsubst header-pkg-requires ()
  "Insert a line to record `Package-Requires' information."
  (insert (concat header-prefix-string "Package-Requires: ()\n")))

(defsubst header-commentary ()
  "Insert \"Commentary: \" line."
  (insert (concat (section-comment-start) "Commentary: \n")))

(defsubst header-history ()
  "Insert `header-history-label' into header for use by `make-revision'.
Without this, `make-revision' inserts `header-history-label' after the header."
  (insert (concat (section-comment-start) header-history-label "\n")))

(defun header-free-software ()
  "Insert text saying that this is free software."
  (let ((header-multiline  header-free-software)) (header-multiline)))

(defun header-multiline ()
  "Insert multiline comment.  The comment text is in `header-multiline'."
  (when header-multiline
    (let ((lineno  1)
          beg end nb-lines)
      (beginning-of-line)
      (if (nonempty-comment-end)
          (insert (concat "\n" comment-start))
        (header-blank)
        (insert (concat header-prefix-string)))
      (setq beg  (point))
      (insert header-multiline)
      (setq end       (point-marker)
            nb-lines  (count-lines beg end))
      (goto-char beg)
      (forward-line 1)
      (while (< lineno nb-lines)
        (insert (concat header-prefix-string))
        (forward-line 1)
        (setq lineno  (1+ lineno)))
      (goto-char end)
      (when (nonempty-comment-end) (insert "\n"))
      (insert (concat comment-end))
      (insert "\n")
      (unless (nonempty-comment-end)
        (header-blank)
        (header-end-line)))))

(defsubst header-code ()
  "Insert \"Code: \" line."
  (insert (concat (section-comment-start) "Code:" (nonempty-comment-end) "\n\n\n")))

(defsubst header-eof ()
  "Insert comment indicating end of file."
  (goto-char (point-max))
  (insert "\n")
  (unless (nonempty-comment-end) (header-end-line))
  (insert (concat comment-start
                  (and (= 1 (length comment-start))  header-prefix-string)
                  (if (buffer-file-name)
                      (file-name-nondirectory (buffer-file-name))
                    (buffer-name))
                  " ends here"
                  (or (nonempty-comment-end)  "\n"))))

(defsubst header-modification-date ()
  "Insert todays date as the time of last modification.
This is normally overwritten with each file save."
  (insert (concat header-prefix-string "Last-Updated: \n")))

(defsubst header-modification-author ()
  "Insert current user's name as the last person who modified the file.
This is normally overwritten with each file save."
  (insert (concat header-prefix-string "          By: \n")))

(defsubst header-update-count ()
  "Insert a count of the number of times the file has been saved."
  (insert (concat header-prefix-string "    Update #: 0\n")))

(defsubst header-url ()
  "Insert \"URL: \" line."
  (insert (concat header-prefix-string "URL: \n")))

(defsubst header-doc-url ()
  "Insert \"Doc URL: \" line."
  (insert (concat header-prefix-string "Doc URL: \n")))

(defsubst header-keywords ()
  "Insert \"Keywords: \" line."
  (insert (concat header-prefix-string "Keywords: \n")))

(defsubst header-compatibility ()
  "Insert a \"Compatibility: \" line."
  (insert (concat header-prefix-string "Compatibility: \n")))

(defsubst header-lib-requires ()
  "Insert list of libraries required by this one."
  (when (and (eq major-mode 'emacs-lisp-mode)  (boundp 'libreq-file-header))
    (insert libreq-file-header)         ; Defined in `lib-requires.el'.
    (insert ";;   None\n;;\n")))

(defsubst header-status ()
  "Insert a \"Status: \" line."
  (insert (concat header-prefix-string "Status: \n")))

(defsubst header-toc ()
  "Insert a \"Table of Contents: \" line."
  (insert
   (concat header-prefix-string "Table of Contents: \n" header-prefix-string "\n")))

(defsubst header-rcs-log ()
  "Insert lines to record RCS log information (\"$Log$\n\")."
  (insert (concat header-prefix-string
                   "RCS $"  ; String split prevents `vc.el' overwrite.
                   "Log$\n")))           ; Thanks to Steve Taylor.

(defsubst header-AFS ()
  "Insert a line to record SHAPE information."
  (insert (concat header-prefix-string "AFSID: $__Header$\n")))

(defsubst header-shell ()
  "Insert a kernal shell specifier line.
Uses the same shell named in `explicit-shell-file-name', the ESHELL
environment variable, the SHELL environment variable, or
'/bin/sh'.  (This is the same shell that the shell command uses.)"
  (insert "#!" (or (and (boundp 'explicit-shell-file-name)  explicit-shell-file-name)
                   (getenv "ESHELL")
                   (getenv "SHELL")
                   "/bin/sh")
          "\n"))

(defun header-mode-line ()
  "Insert a \" -*- Mode: \" line."
  (let* ((mode-declaration  (concat " -*- Mode: " (true-mode-name)
                                    (if (assoc 'c-style (buffer-local-variables))
                                        (concat "; C-Style: " (symbol-name c-style))
                                      "")
                                    " -*- "))
         (md-length         (length mode-declaration)))
    (insert (cond ((and comment-start  (= 1 (length comment-start)))
                   ;; Assume comment start char is also fill char.
                   (concat comment-start comment-start
                           (make-string (/ (- 77 md-length) 2)
                                        (aref comment-start 0))
                           mode-declaration
                           (make-string (/ (- 78 md-length) 2)
                                        (aref comment-start 0))))
                  ((nonempty-comment-start) ; Assume spaces fill the gaps.
                   (concat comment-start
                           (make-string (/ (- 79 md-length (length comment-start)) 2)
                                        ?\ )
                           mode-declaration))
                  (t                    ; No comment-start.  Assume Lisp.
                   (concat ";;" (make-string (/ (- 77 md-length) 2) ?\;)
                           mode-declaration
                           (make-string (/ (- 78 md-length) 2) ?\;))))
            "\n")))

(defsubst header-end-line ()
  "Insert a divider line."
  (insert (cond ((nonempty-comment-end))
                ((and comment-start  (= 1 (length comment-start)))
                 (make-string 70 (aref comment-start 0)))
                ((nonempty-comment-start))
                (t (make-string 70 ?\;)))
          "\n"))


;; User function to declare header actions on a save file.
;;   See examples at the end of this file.
;; Invoke from `site-init.el' or in `.emacs'.
;; -------------------------------------------------------
(defun register-file-header-action (regexp function-to-call)
  "Record FUNCTION-TO-CALL as the action to take if REGEXP is found
in the file header when a file is written.  The function will be called
with the cursor located just after the matched REGEXP.  Calling this twice
with the same args overwrites the previous FUNCTION-TO-CALL."
  (let ((ml  (assoc regexp file-header-update-alist)))
    (if ml
        (setcdr ml function-to-call);; overwrite old defn
      ;; This entry is new to us.  Add to the master alist
      (setq file-header-update-alist  (cons (cons regexp function-to-call)
                                            file-header-update-alist)))))


;; Register the automatic actions to take for file headers during a save
;; See the second part of the file for explanations.
;; ---------------------------------------------------------------------
;; (register-file-header-action "^.* *\\(.*\\) *\\-\\-" 'update-file-name)
;; (register-file-header-action "\$VERSION[ \t]*=[ \t]*\"\\([0-9]+\\.\\)+"
;;                              'update-write-count)

(register-file-header-action "Last-Updated[ \t]*: " 'update-last-modified-date)
(register-file-header-action "          By[ \t]*: " 'update-last-modifier)
(register-file-header-action "    Update #[ \t]*: " 'update-write-count)
(when (boundp 'libreq-file-header)
  (register-file-header-action libreq-file-header 'update-lib-requires))


;; Header and file division header creation code
;; ---------------------------------------------
(defun true-mode-name ()
  "Return name of mode in a form such that mode may be re-established
by calling the function named by appending \"-name\" to this string.
This differs from variable `mode-name' in that this is guaranteed to
work even when the value has embedded spaces or other junk."
  (let ((major-mode-name  (symbol-name major-mode)))
    (capitalize (substring major-mode-name 0 (or (string-match "-mode" major-mode-name)
                                                 (length major-mode-name))))))

(defun header-prefix-string ()
  "Return a mode-specific prefix string for use in headers.
It is sensitive to language-dependent comment conventions."
  (cond
   ;; E.g. Lisp.
   ((and comment-start  (= 1 (length comment-start)))
    (concat comment-start comment-start " "))

   ;; E.g. C++ and ADA.
   ;; Special case, three letter `comment-start' where the first and
   ;; second letters are the same.
   ((and comment-start  (= 3 (length comment-start))
         (equal (aref comment-start 1) (aref comment-start 0)))
    comment-start)

   ;; E.g. C.
   ;; Other three-letter `comment-start' -> grab the middle character
   ((and comment-start  (= 3 (length comment-start)))
    (concat " " (list (aref comment-start 1)) " "))

   ((and comment-start  (not (nonempty-comment-end)))
    ;; Note: no comment end implies full `comment-start' must be used on each line.
    comment-start)
   (t ";; ")))       ; Use Lisp as default.

;; Usable as a programming language mode hook.
(defun auto-make-header ()
  "Call `make-header' if current buffer is empty and is a file buffer."
  (and (zerop (buffer-size))
       (not buffer-read-only)
       (buffer-file-name)
       (make-header)))

;;;###autoload
(defun make-header ()
  "Insert (mode-dependent) header comment at beginning of file.
A header is composed of a mode line, a body, and an end line.  The body is
constructed by calling the functions in `make-header-hook'.  The mode line
and end lines start and terminate block comments.  The body lines continue
the comment."
  (interactive)
  (beginning-of-buffer)                 ; Leave mark at old location.
  (let* ((return-to             nil)    ; To be set by `make-header-hook'.
         (header-prefix-string  (header-prefix-string))) ; Cache result.
    (mapcar #'funcall make-header-hook)
    (when return-to (goto-char return-to))))

;;;###autoload
(defun make-revision ()
  "Prepare for a new history revision.  Insert history line if inexistant."
  (interactive)
  (setq comment-start  (or comment-start  "\;")) ; Use Lisp comment as default.
  (let ((header-prefix-string   (header-prefix-string))
        (logical-comment-start  (if (= 1 (length comment-start))
                                    (concat comment-start comment-start " ")
                                  comment-start)))
    ;; Look for the history line
    (beginning-of-buffer)               ; Leave a mark behind.
    (if (re-search-forward (concat "^\\(" (and comment-start  (regexp-quote comment-start))
                                   (regexp-quote (header-prefix-string)) "\\|"
                                   (if (nonempty-comment-start)
                                       (concat "\\|" (regexp-quote comment-start))
                                     "")
                                   "\\)" " *\\(" header-history-label
                                   "\\|HISTORY\\)") ; Backward compatibility.
                           header-max t)
        (end-of-line)
      ;; We did not find a history line, add one
      (goto-char (point-min))
      ;; find the first line that is not part of the header
      (while (and (< (point) header-max)
                  (looking-at (concat "[ \t]*\\("
                                      (regexp-quote (header-prefix-string))
                                      (if (nonempty-comment-start)
                                          (concat "\\|" (regexp-quote comment-start))
                                        "")
                                      (if (nonempty-comment-end)
                                          (concat "\\|" (regexp-quote comment-end))
                                        "")
                                      "\\)")))
        (forward-line 1))
      (insert "\n" logical-comment-start header-history-label)
      (save-excursion (insert (concat "\n" comment-end))))
    ;; We are now on the line with the header-history-label label
    (insert (concat "\n"
                    header-prefix-string
                    (let ((str  (current-time-string)))
                      (concat (if (equal ?\  (aref str 8))
                                  (substring str 9 10)
                                (substring str 8 10))
                              "-"
                              (substring str 4 7)
                              "-"
                              (substring str 20 24)))
                    "    "
                    (user-full-name)
                    ;;"  |>Ident<|\n"
                    "  \n"
                    header-prefix-string
                    "   "))
    ;; Add details about the history of the file before its modification
    (when (save-excursion (re-search-backward "Last-Updated[ \t]*: \\(.+\\)$" nil t))
      (insert "Last-Updated: " (buffer-substring (match-beginning 1) (match-end 1)))
      (when (save-excursion (re-search-backward "    Update #[ \t]*: \\([0-9]+\\)$" nil t))
        (insert " #" (buffer-substring (match-beginning 1) (match-end 1))))
      (when (save-excursion (re-search-backward "          By[ \t]*: \\(.+\\)$" nil t))
        (insert " (" (buffer-substring (match-beginning 1) (match-end 1)) ")"))
      (insert (concat "\n" header-prefix-string "   ")))))

;;;###autoload
(defun make-divider (&optional end-col)
  "Insert a comment divider line: the comment start, filler, and end.
The width is `fill-column', by default.  With a numeric prefix arg,
use that as the width, except use at least 4 columns."
  (interactive "P")
  (setq end-col  (if end-col (prefix-numeric-value end-col) fill-column))
  (insert (concat comment-start))
  (when (= 1 (length comment-start)) (insert comment-start))
  (insert (concat (make-string (max 2 (- end-col (length comment-end) (current-column)))
                               (aref comment-start (if (= 1 (length comment-start)) 0 1)))
                  comment-end
                  "\n")))

;;;###autoload
(defun make-box-comment (&optional end-col)
  "Insert an empty (mode dependent) box comment.
The maxium width is `fill-column', by default.  With a numeric prefix
arg, use that as the maximum width, except use at least 2 + the length
returned by function `header-prefix-string'."
  (interactive "P")
  (setq end-col  (if end-col (prefix-numeric-value end-col) fill-column))
  (unless (= 0 (current-column)) (forward-line 1))
  (insert (concat comment-start))
  (when (= 1 (length comment-start)) (insert comment-start))
  (unless (char-equal (preceding-char) ?\  ) (insert ?\  ))
  (insert (concat (make-string (max 2 (- end-col (length comment-end) (current-column)))
                               (aref comment-start (if (= 1 (length comment-start)) 0 1))))
          "\n"
          (header-prefix-string))
  (save-excursion
    (insert
     (concat "\n"
             (header-prefix-string)
             (make-string (max 2 (- end-col (length comment-end) (current-column)))
                          (aref comment-start (if (= 1 (length comment-start)) 0 1)))
             comment-end
             "\n"))))

(defun make-box-comment-region (&optional end-col start end)
  "Wrap active region in a box comment, or make an empty box comment.
The maxium width is `fill-column', by default.  With a numeric prefix
arg, use that as the maximum width, except use at least 2 + the length
returned by function `header-prefix-string'.
Respects `make-box-comment-region-remove-comments'."
  (interactive "P\nr")
  (setq end-col  (if end-col (prefix-numeric-value end-col) fill-column))
  (if (not (and mark-active  (mark)  (> (region-end) (region-beginning))))
      (make-box-comment end-col)
    (let ((selection  (buffer-substring start end)))
      (kill-region start end)
      (make-box-comment end-col)
      (insert
       (replace-regexp-in-string "\n"
                                 (concat "\n" (header-prefix-string))
                                 (if make-box-comment-region-replace-prefix-flag
                                     (replace-regexp-in-string
                                      (concat "^[ \t]*[" (nonempty-comment-start) "]*")
                                      ""
                                      selection)
                                   selection))))))



;; Automatic Header update code
;; ----------------------------
;;;###autoload
(defun update-file-header ()
  "Update file header.
Search the first `header-max' chars in buffer using regexps in
`file-header-update-alist'.  When a match is found, apply the
corresponding function with point located just after the match.
The functions can use `match-beginning' and `match-end' to find
the strings that cause them to be invoked."
  (interactive)
  (save-excursion
    (save-restriction                   ; Only search `header-max' chars.
      (narrow-to-region 1 (min header-max (1- (buffer-size))))
      (let ((patterns  file-header-update-alist))
        ;; Do not record this call as a command in command history.
        (setq last-command  nil)
        (while patterns
          (goto-char (point-min))
          (when (re-search-forward (car (car patterns)) nil t)
            ;; Position cursor at end of match.
            (goto-char (match-end 0))
            ;;(message "do %s" (car patterns)) (sit-for 1)
            (funcall (cdr (car patterns))))
          (setq patterns  (cdr patterns)))))))

(defun auto-update-file-header ()
  "Update file header if buffer is modified.
Call `update-file-header' if all of these are true:
 * `header-auto-update-enabled' is non-nil,
 * the buffer is longer than 100 chars,
 * the buffer is modified,
 * the buffer is not read-only.
Return nil, for use on a hook."
  (and header-auto-update-enabled
       (> (buffer-size) 100)
       (buffer-modified-p)
       (not buffer-read-only)
       (update-file-header)
       nil))



;; Define individual file header actions.  These are the building
;; blocks of automatic header maintenance.
;; -----------------------------------------------------------------------
(defsubst delete-and-forget-line ()
  "Delete current line and return it.  Do not add it to the `kill-ring'."
  (let* ((start  (point))
         (stop   (line-end-position))
         (str    (buffer-substring start stop)))
    (delete-region start stop)
    str))

(defun update-write-count ()
  (let* ((str  (delete-and-forget-line))
         (rem  (read-from-string str))
         (num  (car rem)))
    (if (numberp num)
        (insert (format "%s" (1+ num)) (substring str (cdr rem)))
      (insert str)
      (error "Invalid number for update count `%s'" str))))

;;; ;;;###autoload
;;; (defun update-VCS-version ()
;;;   "Update VCS version, of the form $VERSION = \"NUM\".
;;; NUM is a decimal number with one or more decimal points -
;;; e.g. 3.1415.9265.  Only the part after the last decimal point is
;;; incremented."
;;;   (interactive)
;;;   (let* ((beg  (point))
;;;          (eol  (line-end-position))
;;;          (end  (re-search-forward "\\([^\\\"]+\\)\"" eol t))
;;;          (str  (buffer-substring beg (1- end)))
;;;          (num  (car (condition-case err
;;;                         (read-from-string str)
;;;                       (error (format "Invalid number for version `%s'" str))))))
;;;     (when (>= num most-positive-fixnum)
;;;       (error "Version number is too large to increment: `%s'" num))
;;;     (when (and end  (numberp num))
;;;       (let ((newnum  (condition-case err2
;;;                          (1+ num)
;;;                        (error (format "Invalid number for version `%s'" str)))))
;;;         (replace-match (format "%d" newnum) nil nil nil 1)))))

(defsubst update-last-modifier ()
  "Update the line that indicates who last modified the file."
  (delete-and-forget-line)
  (insert (format "%s" (let ((ufn  (user-full-name)))
                         (if (and ufn  (not (string= "" ufn))) ufn (user-login-name))))))

(defsubst update-last-modified-date ()
  "Update the line that indicates the last-modified date."
  (delete-and-forget-line)
  (insert (header-date-string)))

(defun update-file-name ()
  "Update the line that indicates the file name."
  (beginning-of-line)
  ;; Verify looking at a file name for this mode.
  (when (looking-at (concat (regexp-quote (header-prefix-string)) " *\\(.*\\) *\\-\\-"))
    (goto-char (match-beginning 1))
    (delete-region (match-beginning 1) (match-end 1))
    (insert (file-name-nondirectory (buffer-file-name)) " ---")))

(defun update-lib-requires ()
  "Update the lines that show what libraries are required by this one.
This uses function `libreq-insert-lib-requires-as-comment' from
library `lib-requires.el'.

Note: If a byte-compiled file (`*.elc') for the library is available,
it is used when determining library dependencies, in preference to the
source library - this is the standard behavior of `load-library'.  The
list of required libraries reflects the dependencies indicated in the
byte-compiled file, not the source file.  If the byte-compiled file is
out-of-date with respect to its required libraries, so will be the
result of `update-lib-requires'."
  (when (buffer-file-name)              ; Do nothing if not a file buffer.
    (let ((lib  (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
      (when (and (eq major-mode 'emacs-lisp-mode)
                 (fboundp 'libreq-insert-lib-requires-as-comment))
        (goto-char (match-beginning 0))
        ;; Verify looking at `libreq-file-header'"
        (when (looking-at (regexp-quote libreq-file-header))
          (delete-and-forget-line) (delete-char 1)
          (delete-and-forget-line) (delete-char 1)
          (while (not (looking-at "^;;$")) (delete-and-forget-line) (delete-char 1))
          (delete-and-forget-line) (delete-char 1)
          (condition-case err
              ;; (let ((load-path  (cons (file-name-directory (buffer-file-name))
              ;;                         load-path)))
              (libreq-insert-lib-requires-as-comment lib) ; Tries to load LIB.
            ;;   )
            ;; Typically, user just now added `provide' and must load again.
            (error (insert libreq-file-header (header-prefix-string) "  "
                           (error-message-string err) ".\n;;\n"))))))))



;;(setq file-header-update-alist  nil)
;;(setq file-header-update-alist  (cdr file-header-update-alist))

;; Stand-alone Headers
;; These functions give the ability to invoke headers from the command line.
;;   E.g Can use with `vi' instead of emacs.
;; -------------------------------------------------------------------------
(defun headerable-file-p (file)
  "Return non-nil if FILE is an existing file."
  (not (if (not (file-exists-p file))
           (message "File \"%s\" does not exist." file)
         (if (file-symlink-p file)
             (message "\"%s\" is a symbolic link." file)
           (if (file-directory-p file)
               (message "\"%s\" is a directory." file))))))

(defsubst uniquify-list (list)
  "Remove duplicates in list LIST.  Comparison is with `eq'."
  (let ((rest  list))
    (while rest
      (setcdr rest (delq (car rest) (cdr rest)))
      (setq rest  (cdr rest)))
    list))

;;(headerable-file-p "AFS")
;;(headerable-file-p "dbiogen.el")
;;(headerable-file-p "dbiogen.elc")

;;; Rest commented out -- Needs Lynn Slater's
;;; customizations to startup.el to allow command-line-hooks.
;;
;;
;; (defvar header-required-mode nil
;;   "The mode we force files to be in, regardless of file suffix.")
;;
;; Define a touch-headers command.  This depends upon Lynn Slater's
;; customizations to startup.el to allow command-line-hooks.
;; ---------------------------------------------------------------
;;;(setq command-line-hooks  (cons 'touch-headers command-line-hooks))
;(defun touch-headers ()
;  (if (or (string= argi "-touch")  (string= argi "-touch-headers"))
;      (let ((trim-versions-without-asking  t)
;            ;; Next line should have a Control-G char, not a space, before `true'.
;            (executing-macro " true"));; suppress "Mark Set" messages
;        ;; Consume all following arguments until one starts with a "-"
;        (while (and command-line-args-left
;                    (not (char-equal ?- (aref (car command-line-args-left) 0))))
;          (if (headerable-file-p (car command-line-args-left))
;              (progn
;                (set-buffer (find-file-noselect (car command-line-args-left)))
;                (make-revision)
;                (write-file nil)
;                (kill-buffer (current-buffer))))
;          (setq command-line-args-left  (cdr command-line-args-left))))))


;; Define a make-headers command line option.
;; ------------------------------------------
;;;(setq command-line-hooks  (cons 'make-headers command-line-hooks))
;(defun make-headers ()
;  (if (or (string= argi "-make-headers")  (string= argi "-make"))
;      (let ((trim-versions-without-asking  t)
;            ;; Next line should have a Control-G char, not a space, before `true'.
;            (executing-macro " true"));; suppress "Mark Set" messages
;        ;; Consume all following arguments until one starts with a "-"
;        (while (and command-line-args-left
;                    (not (char-equal ?- (aref (car command-line-args-left) 0))))

;          (if (headerable-file-p (car command-line-args-left))
;              (progn
;                (set-buffer (find-file-noselect (car command-line-args-left)))
;                (if header-required-mode
;                    (funcall header-required-mode))
;                (make-header)
;                (write-file nil)
;                (message "  Mode was %s" major-mode)
;                (kill-buffer (current-buffer))))
;          (setq command-line-args-left  (cdr command-line-args-left))))))

;; Define a -default-mode command line option.
;; -------------------------------------------
;;;(setq command-line-hooks  (cons 'set-header-mode command-line-hooks))
;(defun set-header-mode ()
;  (if (or (string= argi "-default-mode")  (string= argi "-default"))
;      (let ((trim-versions-without-asking  t)
;            ;; Next line should have a Control-G char, not a space, before `true'.
;            (executing-macro " true");; suppress "Mark Set" messages
;            (mode (intern (car command-line-args-left))))
;        (if (memq mode (mapcar 'cdr auto-mode-alist))
;            (progn
;              (setq default-major-mode  mode)
;              (message "Default mode is %s" default-major-mode)
;              (setq command-line-args-left  (cdr command-line-args-left)))
;          (message "Mode \"%s\" is invalid.  Try one of %s" mode
;                   (uniquify-list (mapcar 'cdr auto-mode-alist)))
;          (kill-emacs 1)))))


;; Define a -required-mode command line option.
;; --------------------------------------------
;;;(setq command-line-hooks  (cons 'set-header-required-mode command-line-hooks))
;(defun set-header-required-mode ()
;  (if (or (string= argi "-required-mode")  (string= argi "-mode"))
;      (let ((trim-versions-without-asking  t)
;            ;; Next line should have a Control-G, not a space, char before `true'.
;            (executing-macro " true");; suppress "Mark Set" messages
;            (mode (intern (car command-line-args-left))))
;        (if (memq mode (mapcar 'cdr auto-mode-alist))
;            (progn
;              (setq header-required-mode  mode)
;              (message "Required mode is %s" header-required-mode)
;              (setq command-line-args-left  (cdr command-line-args-left)))
;          (message "Mode \"%s\" is invalid.  Try one of %s" mode
;                   (uniquify-list (mapcar 'cdr auto-mode-alist)))
;          (kill-emacs 1)))))


;; Things in the works or still to do.
;;------------------------------------
;; effort.el -- allows an "effort" to be resgistered in the mode line much
;; like the mode is.  The effort then determines some header characteristics
;; such as copyright.  Typical efforts would be 'gdb 'gcc, 'g++, 'emacs, etc.
;; This would let the copyright (and c-style) be adjusted even within
;; common modes.
;;
;; need ez access to values in the header
;; need a headerp fcn
;;
;; auto make-revision if current user is not same as last modifier
;;   this would give a history of who touched what.

(provide 'file-header)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; file-header.el ends here



