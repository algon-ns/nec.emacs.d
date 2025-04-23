;;; misc.el --- Miscellaneous Configurations   -*- lexical-binding: t; coding: utf-8 -*-
;;; Commentary:
;; This file contains various package configurations that enhance
;; the Emacs experience, including utilities for navigation and
;; clipboard management.

;;; Code:

(defun load-env-file (filepath)
  "Load .env and define in Emacs environment from FILEPATH."
  (when (file-exists-p filepath)
    (with-temp-buffer
      (insert-file-contents filepath)
      (dolist (line (split-string (buffer-string) "\n" t))
        (let ((parts (split-string line "=")))
          (when (= (length parts) 2)
            (setenv (car parts) (cadr parts))))))))

(load-env-file "~/.emacs.d/.env")

(straight-use-package 'web-server)

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :init
  (which-key-mode 1)
  :config
  (setq which-key-separator " → "))

(use-package ace-window
  :ensure t
  :bind (("M-o" . ace-window)))

(use-package xclip
  :ensure t
  :config
  (xclip-mode 1))

(use-package counsel-spotify
  :ensure t
  :config
  (setq counsel-spotify-client-id (getenv "SPOTIFY_CLIENT_ID"))
  (setq counsel-spotify-client-secret (getenv "SPOTIFY_CLIENT_SECRET")))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(use-package keyfreq
  :ensure t
  :config
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

(setq keyfreq-excluded-commands
      '(self-insert-command
	mouse-wheel-text-scale
	mwheel-scroll
	vertico-exit
	delete-backward-char
        forward-char
        backward-char
        previous-line
        next-line
	vertico-next
	vertico-insert))

(use-package centered-cursor-mode
  :ensure t
  :init
  (global-centered-cursor-mode 1)
  )

(use-package expand-region
  :ensure t
  :bind ("C-9" . er/expand-region))

(use-package emojify
  :hook (prog-mode . emojify-mode))

(use-package yaml-mode
  :ensure t
  :config
      (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
      (add-hook 'yaml-mode-hook
      '(lambda ()
        (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
      )
(if nec/measure-time (nec/sstimer "misc"))
(provide 'misc)
;;; misc.el ends here
