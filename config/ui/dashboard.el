;;; dashboard.el --- Emacs Dashboard Configuration  -*- lexical-binding: t; coding: utf-8 -*-
;;; Commentary:

;;; Code:

(require 'cl-lib)

(use-package nerd-icons
  :ensure t
  :config
  (setq nerd-icons-font-family "Symbols Nerd Font Mono"))

(defun select-random-banner ()
  (let* ((banners-dir "~/.emacs.d/images/")
         (files (directory-files banners-dir t "^[^.]")))
    (when files
      (nth (random (length files)) files))))

(use-package dashboard
  :ensure t
  :demand t
  :custom
  (dashboard-setup-startup-hook)
  (dashboard-icon-type 'nerd-icons)
  (dashboard-heading-icons '((recents   . "nf-oct-history")
                             (bookmarks . "nf-oct-bookmark")
                             (agenda    . "nf-oct-calendar")
                             (projects  . "nf-oct-briefcase")
                             (registers . "nf-oct-database")))
  (dashboard-set-file-icons t)
  (dashboard-center-content t)
  (dashboard-banner-logo-title "I use emacs btw 🤓👣🏹")
  (dashboard-startup-banner (expand-file-name "images/ringe.png" user-emacs-directory))
  (dashboard-footer-messages '("vim's kinda cute, but I need much more."))
  (dashboard-footer-icon
   (nerd-icons-mdicon "nf-md-coffee" :height 1.0 :v-adjust -0.05))
  (dashboard-items '((agenda . 6)
                     (bookmarks . 9)))   
  (dashboard-startupify-list
   '(dashboard-insert-newline
     dashboard-insert-newline
     dashboard-insert-newline
     dashboard-insert-banner
     dashboard-insert-newline
     dashboard-insert-banner-title
     dashboard-insert-newline
     dashboard-insert-navigator
     dashboard-insert-items
     dashboard-insert-newline
     dashboard-insert-footer
     dashboard-insert-newline
     dashboard-insert-init-info))
  (dashboard-navigator-buttons
   `(((,(nerd-icons-mdicon "nf-md-github" :height 1.1 :v-adjust 0.0)
       "Github" "Browse GitHub profile"
       (lambda (&rest _) (browse-url "https://github.com/algon-ns")))
      (,(nerd-icons-mdicon "nf-md-cog" :height 1.1 :v-adjust 0.0)
       "Settings" "Open init.el"
       (lambda (&rest _) (find-file user-init-file))))))
  :config
  (dashboard-setup-startup-hook)
  (set-face-attribute 'dashboard-banner-logo-title nil :height 180 :weight 'bold)
  (set-face-foreground 'dashboard-banner-logo-title "#cba6f7"))

;; (setq dashboard-projects-backend 'projectile)
(setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))

(defun my/dashboard-project-name (project-path)
  (file-name-nondirectory (directory-file-name project-path)))

(advice-add 'dashboard-insert-projects :around
            (lambda (orig-fun &rest args)
              (cl-letf (((symbol-function 'abbreviate-file-name) #'my/dashboard-project-name))
                (apply orig-fun args))))
(if nec/measure-time (nec/sstimer "ui/dashboard"))
(provide 'ui/dashboard)
;;; dashboard.el ends here
