;;; yatemplate-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:



;;; Generated autoloads from yatemplate.el

(defvar yatemplate-dir (locate-user-emacs-file "templates") "\
The directory containing file templates.")
(custom-autoload 'yatemplate-dir "yatemplate" t)
(defvar yatemplate-separator ":" "\
Separator used for splitting filenames.

This is the separator that is used to split template filenames into
the ordering and regular expression parts.

Note that this will be used as the SEPARATORS argument of
`split-string', so be careful when setting this to a value that
has special meaning in regular expressions.")
(custom-autoload 'yatemplate-separator "yatemplate" t)
(defvar yatemplate-ignored-files-regexp "README.md$" "\
Regular expression matching files that do not contain `yatemplate-separator', but will generate no warning.")
(custom-autoload 'yatemplate-ignored-files-regexp "yatemplate" t)
(put 'yatemplate-owner 'safe-local-variable #'stringp)
(put 'yatemplate-license 'safe-local-variable #'stringp)
(autoload 'yatemplate-fill-alist "yatemplate" "\
Fill `auto-insert-alist'.")
(register-definition-prefixes "yatemplate" '("yatemplate-"))

;;; End of scraped data

(provide 'yatemplate-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; yatemplate-autoloads.el ends here
