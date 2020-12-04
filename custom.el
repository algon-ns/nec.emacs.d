(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(comint-terminfo-terminal "xterm-256color")
 '(dashboard-banner-logo-title "Open EMACS for a new world...")
 '(dashboard-buffer-last-width 214)
 '(dashboard-center-content t)
 '(dashboard-footer "Vi Vi Vi, the editor of the beast")
 '(dashboard-footer-messages
   '("The one true editor, Emacs!" "Who the hell uses VIM anyway? Go Evil!" "Free as free speech, free as free Beer" "Richard Stallman is proud of you" "Happy coding!" "Vi Vi Vi, the editor of the beast" "Welcome to the church of Emacs" "While any text editor can save your files, only Emacs can save your soul" "I showed you my source code, pls respond"))
 '(dashboard-heading-icons
   '((bookmarks . "book")
     (recents . "file-text")
     (recents . "history")
     (bookmarks . "bookmark")
     (agenda . "calendar")
     (projects . "rocket")
     (registers . "database")))
 '(dashboard-init-info "217 packages loaded in 4.89729 seconds")
 '(dashboard-item-generators
   '((recents . dashboard-insert-recents)
     (bookmarks . dashboard-insert-bookmarks)
     (projects . dashboard-insert-projects)
     (agenda . dashboard-insert-agenda)
     (registers . dashboard-insert-registers)))
 '(dashboard-navigator-buttons
   '(((#("" 0 1
         (rear-nonsticky t display
                         (raise -0.06)
                         font-lock-face
                         (:family "github-octicons" :height 1.32)
                         face
                         (:family "github-octicons" :height 1.32)))
       "ALGON" "Browse ALGON Homepage"
       (lambda
         (&rest _)
         (browse-url "https://algon.dk"))))))
 '(dashboard-set-file-icons t)
 '(dashboard-set-heading-icons t)
 '(dashboard-set-navigator t)
 '(dashboard-startup-banner "/Users/niels/.emacs.d/images/ohands.png")
 '(doom-modeline-gnus-timer 0)
 '(eww-bookmarks-directory "~/.emacs.d/private/")
 '(exec-path
   '("/bin/" "/usr/bin/" "/usr/local/bin/" "/usr/local/texlive/bin/" "/opt/local/bin/" "/Library/TeX/texbin/" "/usr/sbin/" "/sbin/" "/opt/X11/bin/" "/Applications/Emacs.app/Contents/MacOS/libexec/" "/usr/local/Cellar/pyenv-virtualenv/1.1.5/shims/" "/usr/local/opt/coreutils/libexec/gnubin/"))
 '(file-template-insert-automatically t)
 '(focus-follows-mouse 'auto-raise)
 '(font-latex-fontify-sectioning 1.2)
 '(helm-allow-mouse t)
 '(is-all-the-icons-installed t)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-yank-at-point t)
 '(nxml-bind-meta-tab-to-complete-flag nil)
 '(org-roam-server-mode t)
 '(org-roam-server-served-file-extensions '("pdf" "mp4" "ogv"))
 '(preview-TeX-style-dir "/Users/niels/.emacs.d/straight/build/auctex/latex" t)
 '(projectile-known-projects-file "/Users/niels/.emacs.d/private/projectile-bookmarks.eld")
 '(projectile-mode-line-prefix " ✐")
 '(reftex-plug-into-AUCTeX t t)
 '(sane-term-shell-command "/bin/zsh")
 '(set-mark-command-repeat-pop t)
 '(smartparens-global-mode t)
 '(sp-show-pair-from-inside t)
 '(spaceline-highlight-face-func 'spaceline-highlight-face-modified t)
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

