;; initiate diary
(setq view-diary-entries-initially t
      mark-diary-entries-in-calendar t
      number-of-diary-entries 7)
(add-hook 'diary-display-hook 'fancy-diary-display)
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)
;;;;;;;;
(add-hook 'fancy-diary-display-mode-hook
          '(lambda ()
             (alt-clean-equal-signs)))

(defun alt-clean-equal-signs ()
  "This function makes lines of = signs invisible."
  (goto-char (point-min))
  (let ((state buffer-read-only))
    (when state (setq buffer-read-only nil))
    (while (not (eobp))
      (search-forward-regexp "^=+$" nil 'move)
      (add-text-properties (match-beginning 0)
                           (match-end 0)
                           '(invisible t)))
    (when state (setq buffer-read-only t))))
;;;;
(if (not (featurep 'appt))(require 'appt))
(appt-activate 1)                                             ; XEmacs; use (appt-activate 1) for GNU Emacs
(setq ;;appt-msg-countdown-list '(10 5 1)                       ; XEmacs
 appt-audible (cons 3 .5)
 ;;      appt-check-time-syntax nil                              ; XEmacs
 ;;      appt-announce-method 'appt-persistent-message-announce  ; XEmacs
 appt-display-duration 59)
(defun diary-save-hook ()
  "Stuff to do when saving the diary files."
  (appt-initialize))
(defun add-diary-save-hook ()
  "find-file-hooks hook to add the diary-save-hook when appropriate"
  (if (string-match "diary" (buffer-name))
      (add-hook 'after-save-hook 'diary-save-hook)))
(add-hook 'find-file-hooks 'add-diary-save-hook)
;;
;; ---great bit of code from Jeff Miller to highlight appointments in red on modeline---
(defface appt-face
  '((t (:foreground "red" :background "white")))
  "Face to indicate a current appointment."
  :group 'appt)

(defadvice appt-disp-window (before appt-hilite-more activate)
  (when appt-mode-string
    (put-text-property 1 (- (length appt-mode-string) 1)
                       'face 'appt-face appt-mode-string)))

(defadvice appt-check (after appt-hilite activate)
  (when appt-mode-string
    (put-text-property 1 (- (length appt-mode-string) 1)
                       'face 'appt-face appt-mode-string)
    (force-mode-line-update)))

;; ---------------------------------
;; compatability - we don't really miss the aliases appt defines anyway.
;; there's no need for this in xemacs or emacs 21.3+
(when (not (fboundp 'defvaralias))
  (defun defvaralias (&rest args)))

(when (require 'appt nil t)
  (setq appt-msg-countdown-list '(10 5 1 0)
        appt-audible (cons 3 .5)
        appt-check-time-syntax nil
        appt-announce-method 'appt-persistant-message-announce
        appt-display-duration 360)

  ;; ding takes a different number of args in gnu emacs - eventually i'll
  ;; redefine this to use my soundcard anyway
  (when (not (featurep 'xemacs))
    (defun appt-beep (&rest args)))

  (defun diary-save-hook ()
    "Stuff to do when saving the diary files."
    (appt-activate 1))

  (defun add-diary-save-hook ()
    "find-file-hooks hook to add the diary-save-hook when appropriate"
    (let* ((diary-file-components (split-string diary-file "/"))
           (diary-buffer-name
            (nth (1- (length diary-file-components)) diary-file-components)))
      (if (string= (buffer-name) diary-buffer-name)
          (add-hook (make-variable-buffer-local 'after-save-hook)
                    'diary-save-hook))))

  (add-hook 'find-file-hooks 'add-diary-save-hook)
  (appt-activate 1))

;;
(provide 'init-diary)
