;;; -*- lexical-binding: t; -*-
;;; package --- Summary
;; NEC -- Danish language org-agenda setup
;;
  ;; This code is Free Software you can redistribute it and/or modify it
  ;; under the terms of the GNU GPL version 3, or (at your option) any
  ;; later version, distributed in the hope that it will be useful, but
  ;; WITHOUT ANY WARRANTY; without even the implied warranty of
  ;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
  ;; <https://www.gnu.org/licenses/> for the complete license text.
  ;;
  ;; Author: Niels Søndergaard <niels@algon.dk>
  ;; Created: <<timestamp-created>>
  ;; Updated: <<timestamp-now()>>

  ;;; Commentary:
  ;; Just days, months names, holidays, festivities etc.

  ;;; Code:
  (eval-when-compile
    (require 'holidays))
  (require 'use-package nil t)

;; We use european date style, i.e. date/month
(setq european-calendar-style 'european)
(setq diary-date-forms
   '((month "/" day "[^/0-9]")
     (month "/" day "/" year "[^0-9]")
     (monthname " *" day "[^,0-9]")
     (monthname " *" day ", *" year "[^0-9]")
     (dayname "\\W")))
;; Week starts on monday
(setq calendar-week-start-day 1)
;; Date format
(setq calendar-date-display-form
   '((if dayname
      (concat dayname ", "))
    day " " monthname " " year))
;; 24 hour clock format
(setq calendar-time-display-form
   '(24-hours ":" minutes))
;; Weekday
(setq calendar-day-name-array
   ["søndag" "mandag" "tirsdag" "onsdag" "torsdag" "fredag" "lørdag"])
(setq calendar-day-abbrev-array
   ["søn" "man" "tirs" "ons" "tors" "fre" "lør"])
(setq calendar-day-header-array
   ["sø" "ma" "ti" "on" "to" "fr" "lø"])
;; Month names
(setq calendar-month-name-array
   ["januar" "februar" "marts" "april" "maj" "juni"
    "juli" "august" "september" "oktober" "november" "december"])
(setq calendar-month-abbrev-array
   ["jan" "feb" "mar" "apr" "maj" "jun" "jul" "aug" "sep" "okt" "nov" "dec"])

;; Calculation of easter, the fix point for many holidays (taken from
;; sv-kalender.el, originally from holiday-easter-etc)
(defun easter (year)
  "Calculate the date for Easter in YEAR."
  (let* ((century (1+ (/ year 100)))
         (shifted-epact (% (+ 14 (* 11 (% year 19))
                              (- (/ (* 3 century) 4))
                              (/ (+ 5 (* 8 century)) 25)
                              (* 30 century))
                           30))
         (adjusted-epact (if (or (= shifted-epact 0)
                                 (and (= shifted-epact 1)
                                      (< 10 (% year 19))))
                             (1+ shifted-epact)
                           shifted-epact))
         (paschal-moon (- (calendar-absolute-from-gregorian
                           (list 4 19 year))
                          adjusted-epact)))
    (calendar-dayname-on-or-before 0 (+ paschal-moon 7))))

(defvar danish-statutory-holidays
  '((holiday-fixed 1 1 "Nytårsdag")
    (holiday-fixed 1 6 "Hellige 3 konger")
    (holiday-fixed 3 8 "Kvindernes internationale kampdag")
    (holiday-fixed 4 16 "Dronning Margrethe")
    (holiday-fixed 5 1 "Arbejdernes internationale kampdag")
    (holiday-fixed 5 4 "Danmarks befrielse")
    (holiday-float 5 0 2 "Mors dag")
    (holiday-fixed 6 5 "Grundlovsdag")
    (holiday-fixed 6 5 "Fars dag")
    (holiday-fixed 6 15 "Valdemarsdag (Dannebrog)")
    (holiday-fixed 6 24 "Skt. Hans dag")
    (holiday-fixed 12 24 "Juleaften")
    (holiday-fixed 12 25 "Juledag")
    (holiday-fixed 12 26 "Anden juledag")
    (holiday-fixed 12 31 "Nytårsaften")))

;; Easter, Pentecost and other religous holidays
 (holiday-filter-visible-calendar
    (mapcar
       (lambda (dag)
          (list (calendar-gregorian-from-absolute
                   (+ (easter displayed-year) (car dag)))
                (cadr dag)))
        '(( -49 "Fastelavn")
          (  -7 "Palmesøndag")
          (  -3 "Skærtorsdag")
          (  -2 "Langfredag")
          (   0 "Påskedag")
          (  +1 "Anden påskedag")
          ( +26 "Store bededag")
          ( +39 "Kristi himmelfartsdag")
          ( +49 "Pinsedag")
          ( +50 "Anden pinsedag"))))

(eval-after-load "solar"
      '(progn
       (setq solar-n-hemi-seasons
          '("Forårsjævndøgn" "Sommersolhverv"
            "Efterårsjævndøgn" "Vintersolhverv"))
       (setq solar-s-hemi-seasons
           '("Efterårsjævndøgn" "Vintersolhverv"
             "Forårsjævndøgn" "Sommersolhverv"))))

 ;; Moon phace names
  (defadvice lunar-phase-name (around da-lunar-phase-name activate)
     "Phases of the moon in danish."
     (setq ad-return-value
        (let ((phase (ad-get-arg 0)))
              (cond ((= 0 phase) "Nymåne")
                    ((= 1 phase) "Tiltagende Halvmåne")
                    ((= 2 phase) "Fuldmåne")
                    ((= 3 phase) "Aftagende Halvmåne")))))

;; Sunrise and sunset
 (defadvice solar-sunrise-sunset-string (around da-solar-sunrise-sunset-string
                                         activate)
    "Sunrise and sunset in danish."
    (setq ad-return-value
       (let ((l (solar-sunrise-sunset date)))
             (format "%s, %s i %s (%s timers dagslys)"
               (if (car l)
                   (concat "Sol op " (apply 'solar-time-string (car l)))
                           "Ingen solopgang")
                (if (car (cdr l))
                    (concat "ned " (apply 'solar-time-string (car (cdr l))))
                            "ingen solnedgang")
                      (eval calendar-location-name)
                          (car (cdr (cdr l)))))))
;; Adapted from http://stackoverflow.com/questions/21364948/how-to-align-the-calendar-with-week-number-as-the-intermonth-text
(setq calendar-intermonth-text
      '(propertize
        (format "%2d"
                (car
                 (calendar-iso-from-absolute
                  (calendar-absolute-from-gregorian (list month day year)))))
        'font-lock-face 'font-lock-doc-face))

(provide 'agenda-danish)
(if nec/measure-time (nec/timer "agenda-danish "))
  ;;; agenda-danish.el ends here
