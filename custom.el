(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(battery-update-interval 15)
 '(beacon-blink-when-focused t)
 '(beacon-color "#666600")
 '(beacon-mode t)
 '(bookmark-default-file "~/.emacs.d/private/bookmarks")
 '(browse-url-text-browser "safari")
 '(calendar-intermonth-text
   '(propertize
     (format "%2d"
             (car
              (calendar-iso-from-absolute
               (calendar-absolute-from-gregorian
                (list month day year)))))
     'font-lock-face 'font-lock-doc-face))
 '(comint-terminfo-terminal "xterm-256color")
 '(company-statistics-file "~/.emacs.d/private/company-statistics-cache.el")
 '(company-statistics-size 500)
 '(dashboard-set-file-icons t)
 '(dashboard-set-heading-icons t)
 '(dashboard-set-navigator t)
 '(doom-modeline-gnus-timer 0)
 '(elfeed-goodies/powerline-default-separator 'slant)
 '(eww-bookmarks-directory "~/.emacs.d/private/")
 '(exec-path
   '("/usr/local/opt/coreutils/libexec/gnubin/" "/bin/" "/usr/bin/" "/usr/local/bin/" "/usr/local/texlive/bin/" "/opt/local/bin/" "/Library/TeX/texbin/" "/usr/sbin/" "/sbin/" "/opt/X11/bin/" "/Applications/Emacs.app/Contents/MacOS/libexec/" "/usr/local/Cellar/pyenv-virtualenv/1.1.5/shims/"))
 '(focus-follows-mouse 'auto-raise)
 '(font-latex-fontify-sectioning 1.2)
 '(gnus-default-charset 'utf-8)
 '(gnus-default-directory "/Users/niels/.emacs.d/private")
 '(gnus-default-nntp-server "dr.dk/nyheder/service/feeds/viden")
 '(helm-allow-mouse t)
 '(is-all-the-icons-installed t)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-yank-at-point t)
 '(nec/keyfreq nil)
 '(org-bookmark-names-plist nil)
 '(org-export-creator-string "\\tiny{Emacs 27.1 (Org mode 9.5)}")
 '(org-id-link-to-org-use-id t)
 '(org-journal-date-format "%A, %d %B %Y" t)
 '(org-journal-date-prefix "#+TITLE: " t)
 '(org-journal-dir "~/Dropbox/org/journal/" t)
 '(org-journal-enable-agenda-integration t t)
 '(org-journal-file-format "%Y-%m-%d.org" t)
 '(org-roam-bibtex-mode nil)
 '(org-roam-directory "~/Dropbox/org/roam/")
 '(org-roam-graph-viewer "/usr/local/bin/brave-browser")
 '(org-roam-index-file "Index.org")
 '(org-roam-server-mode t)
 '(powerline-default-separator 'arrow)
 '(preview-TeX-style-dir "/Users/niels/.emacs.d/straight/build/auctex/latex" t)
 '(projectile-known-projects-file "/Users/niels/.emacs.d/private/projectile-bookmarks.eld")
 '(reftex-plug-into-AUCTeX t t)
 '(sane-term-shell-command "/bin/zsh")
 '(set-mark-command-repeat-pop t)
 '(smtpmail-smtp-server "mail.algon.dk" t)
 '(smtpmail-smtp-service 587 t)
 '(spaceline-buffer-encoding-abbrev-p nil t)
 '(spaceline-highlight-face-func 'spaceline-highlight-face-modified t)
 '(spaceline-line-column-p t t)
 '(with-editor-emacsclient-executable "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient")
 '(with-editor-shell-command-use-emacsclient nil)
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
 '(org-pomodoro-mode-line ((t (:inherit warning))))
 '(org-pomodoro-mode-line-break ((t (:inherit success))))
 '(org-pomodoro-mode-line-overtime ((t (:inherit error))))
 '(spaceline-modified ((t (:foreground "black" :background "red"))))
 '(spaceline-unmodified ((t (:foreground "black" :background "gold")))))

