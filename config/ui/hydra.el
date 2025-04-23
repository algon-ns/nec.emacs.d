;; init-hydra.el --- Initialize hydra configurations.	-*- lexical-binding: t -*-

;; Copyright (C) 2019-2024 Vincent Zhang

;; Author: Vincent Zhang <seagle0128@gmail.com>
;; URL: https://github.com/seagle0128/.emacs.d

;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;

;;; Commentary:
;;
;; Nice looking hydras.
;;

;;; Code:
(use-package hydra
  :hook (emacs-lisp-mode . hydra-add-imenu)
  :init
  (when (childframe-workable-p)
	(setq hydra-hint-display-type 'posframe)
	(with-eval-after-load 'posframe
	  (defun hydra-set-posframe-show-params ()
		"Set hydra-posframe style."
		(setq hydra-posframe-show-params
			  `(:left-fringe 8
                            :right-fringe 8
                            :internal-border-width 2
                            :internal-border-color ,(face-background 'tooltip nil t)
                            :background-color ,(face-background 'tooltip nil t)
                            :foreground-color ,(face-foreground 'tooltip nil t)
                            :lines-truncate t
                            :poshandler posframe-poshandler-frame-center-near-bottom
                            )))
	  (hydra-set-posframe-show-params)
	  (add-hook 'after-load-theme-hook #'hydra-set-posframe-show-params t))))


(defhydra hydra-apropos (:color blue :hint nil)
  "
_a_propos        _c_ommand
_d_ocumentation  _l_ibrary
_v_ariable       _u_ser-option
^ ^              valu_e_"
  ("a" apropos)
  ("d" apropos-documentation)
  ("v" apropos-variable)
  ("c" apropos-command)
  ("l" apropos-library)
  ("u" apropos-user-option)
  ("e" apropos-value))
;; Recommended binding:
(global-set-key (kbd "C-c C-s-h") 'hydra-apropos/body)


(use-package pretty-hydra
  :custom (pretty-hydra-default-title-body-format-spec " %s%s")
  :bind ("<f6>" . toggles-hydra/body)
  :hook (emacs-lisp-mode . (lambda ()
                             (add-to-list
                              'imenu-generic-expression
                              '("Hydras"
                                "^.*(\\(pretty-hydra-define\\) \\([a-zA-Z-]+\\)"
                                2))))
  :init
  (cl-defun pretty-hydra-title (title &optional icon-type icon-name
                                      &key face height v-adjust)
    "Add an icon in the hydra title."
    (let ((face (or face `(:inherit highlight :reverse-video t)))
          (height (or height 1.2))
          (v-adjust (or v-adjust 0.0)))
      (concat
       (when (and (icons-displayable-p) icon-type icon-name)
         (let ((f (intern (format "nerd-icons-%s" icon-type))))
           (when (fboundp f)
             (concat
              (apply f (list icon-name :face face :height height :v-adjust v-adjust))
              " "))))
       (propertize title 'face face))))

  ;; Global toggles
  (with-no-warnings
	(defhydra hydra-toggle (:color teal)
      "
   ^Modes^                   ^Actions^
  -----------------------------------------  
   _f_: auto-fill-mode      _t_: truncate-lines
   _w_: whitespace-mode     _l_: org link display
   _a_: abbrev-mode         _d_: debug-on-error
   _q_  quit                "
      ;;  ("q" nil "quit")
      ("a" abbrev-mode nil)
      ("d" toggle-debug-on-error nil)
      ("f" auto-fill-mode nil)
      ("t" toggle-truncate-lines nil)
      ("w" whitespace-mode nil)
      ("l" org-toggle-link-display nil)
      ("q" nil "quit")
      )))

(if nec/measure-time (nec/sstimer "hydra"))

(provide 'ui/hydra)

;;; init-hydra.el ends here
