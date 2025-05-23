;;; centered-cursor-mode-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:



;;; Generated autoloads from centered-cursor-mode.el

(autoload 'ccm-visible-text-lines "centered-cursor-mode" "\
Visible text lines")
(autoload 'centered-cursor-mode "centered-cursor-mode" "\
Makes the cursor stay vertically in a defined

position (usually centered).

This is a minor mode.  If called interactively, toggle the
`Centered-Cursor mode' mode.  If the prefix argument is positive, enable
the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable the
mode if ARG is nil, omitted, or is a positive number.  Disable the mode
if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate the variable `centered-cursor-mode'.

The mode's hook is called both when the mode is enabled and when it is
disabled.

(fn &optional ARG)" t)
(put 'global-centered-cursor-mode 'globalized-minor-mode t)
(defvar global-centered-cursor-mode nil "\
Non-nil if Global Centered-Cursor mode is enabled.
See the `global-centered-cursor-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-centered-cursor-mode'.")
(custom-autoload 'global-centered-cursor-mode "centered-cursor-mode" nil)
(autoload 'global-centered-cursor-mode "centered-cursor-mode" "\
Toggle Centered-Cursor mode in all buffers.
With prefix ARG, enable Global Centered-Cursor mode if ARG is
positive; otherwise, disable it.

If called from Lisp, toggle the mode if ARG is `toggle'.
Enable the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

Centered-Cursor mode is enabled in all buffers where
`centered-cursor-mode' would do it.

See `centered-cursor-mode' for more information on Centered-Cursor
mode.

(fn &optional ARG)" t)
(register-definition-prefixes "centered-cursor-mode" '("animate-first-start-p" "ccm-" "recenter-sequence"))

;;; End of scraped data

(provide 'centered-cursor-mode-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; centered-cursor-mode-autoloads.el ends here
