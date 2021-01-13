(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(comint-terminfo-terminal "xterm-256color")
 '(company-backends
   '(company-lsp
     (company-files company-keywords company-capf)
     (company-abbrev company-dabbrev)))
 '(dashboard-buffer-last-width 214)
 '(diredc-shell-default "zsh shell")
 '(doom-modeline-gnus-timer 0)
 '(eww-bookmarks-directory "~/.emacs.d/private/")
 '(exec-path
   '("/bin/" "/usr/bin/" "/usr/local/bin/" "/usr/local/texlive/bin/" "/opt/local/bin/" "/Library/TeX/texbin/" "/usr/sbin/" "/sbin/" "/opt/X11/bin/" "/Applications/Emacs.app/Contents/MacOS/libexec/" "/usr/local/Cellar/pyenv-virtualenv/1.1.5/shims/" "/usr/local/opt/coreutils/libexec/gnubin/"))
 '(file-template-insert-automatically t)
 '(flycheck-checker-error-threshold nil)
 '(focus-follows-mouse 'auto-raise)
 '(font-latex-fontify-sectioning 1.2)
 '(helm-allow-mouse t)
 '(is-all-the-icons-installed t)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-yank-at-point t)
 '(nxml-bind-meta-tab-to-complete-flag nil)
 '(preview-TeX-style-dir "/Users/niels/.emacs.d/straight/build/auctex/latex" t)
 '(projectile-known-projects-file "/Users/niels/.emacs.d/private/projectile-bookmarks.eld")
 '(projectile-mode-line-prefix " ✐")
 '(reftex-plug-into-AUCTeX t t)
 '(sane-term-shell-command "/bin/zsh")
 '(set-mark-command-repeat-pop t)
 '(smartparens-global-mode t)
 '(sp-show-pair-from-inside t)
 '(xterm-mouse-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cfw:face-toolbar-button-off ((t (:foreground "gray76" :weight bold))))
 '(dashboard-banner-logo-title ((t (:family "Love LetterTW" :height 123))))
 '(lsp-ui-doc-background ((t (:background nil))))
 '(lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic)))))
 '(org-journal-calendar-entry-face ((t (:foreground "#ee3b3b" :slant italic))))
 '(org-journal-calendar-scheduled-face ((t (:foreground "#c00000" :slant italic))))
 '(org-link ((t (:foreground "light blue" :underline t))))
 '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-pomodoro-mode-line ((t (:inherit warning))))
 '(org-pomodoro-mode-line-break ((t (:inherit success))))
 '(org-pomodoro-mode-line-overtime ((t (:inherit error))))
 '(org-property-value ((t (:inherit fixed-pitch))) t)
 '(org-roam-link ((t (:foreground "lime green" :underline t))))
 '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-table ((t (:inherit fixed-pitch))))
 '(spaceline-modified ((t (:foreground "black" :background "red"))))
 '(spaceline-unmodified ((t (:foreground "black" :background "gold")))))

