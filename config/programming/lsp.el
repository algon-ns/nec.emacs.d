;;; lsp.el ---   -*- lexical-binding: t; coding: utf-8 -*-

;; Copyright (C),  2024 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@macal.local>

;; Package-Requires: ((emacs "29.2"))
;; Keywords:
;; Homepage:

;; init-lsp is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; init-lsp is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with init-lsp.  If not, see http://www.gnu.org/licenses.

;;; Commentary:


;;; Code:
(straight-use-package '(eglot :type git
                              :host github
                              :repo "emacs-straight/eglot"
                              :files ("*" (:exclude ".git"))))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               `(c++-mode . ("clangd" "--compile-commands-dir=/tmp"))))

(add-hook 'x-mode-hook 'eglot-ensure)

;; (require 'sideline-eglot)
;; (setq sideline-backends-right '(sideline-eglot))
;; (use-package eglot :hook (eglot-mode . sideline-mode))  ; enable it when eglot is on

;; (define-key eglot-mode-map (kbd "C-c r") 'eglot-rename)  ;; general-define-key
;; (define-key eglot-mode-map (kbd "C-c o") 'eglot-code-action-organize-imports)
;; (define-key eglot-mode-map (kbd "C-c h") 'eldoc)
;; (define-key eglot-mode-map (kbd "<f6>") 'xref-find-definitions)


(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (((c-mode c++-mode java-mode json-mode python-mode typescript-mode
				  xml-mode ruby-mode rust-mode php-mode eslint-mode latex-mode) . lsp))
  :custom
  (lsp-clients-typescript-server-args '("--stdio" "--tsserver-log-file" "/dev/stderr"))
  (lsp-enable-folding nil)
  (lsp-enable-links nil)
  (lsp-enable-snippet nil)
  (lsp-prefer-flymake nil)
  (lsp-session-file "~/var/lsp-session-v1")
  (lsp-restart 'auto-restart)
  :commands (lsp lsp-deferred))

(straight-use-package '(lsp-latex :type git
				  :flavor melpa
				  :host github
				  :repo "ROCKTAKEY/lsp-latex"))
(with-eval-after-load "tex-mode"
  (add-hook 'tex-mode-hook 'lsp)
  (add-hook 'latex-mode-hook 'lsp))


(with-eval-after-load "tex-mode"
  (add-hook 'tex-mode-hook 'lsp)
  (add-hook 'latex-mode-hook 'lsp))

(use-package flycheck-eglot
  :straight t
  :after (flycheck eglot)
  :config
  (global-flycheck-eglot-mode 1))


;; optionally
;; (use-package lsp-ui :commands lsp-ui-mode)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

(if nec/measure-time (nec/stimer "programming/lsp"))

(provide 'programming/lsp)
;;; init-lsp.el ends here
