;;; polish-holidays.el --- Polish holidays
;;; inspired by: https://github.com/abo-abo/netherlands-holidays/blob/master/netherlands-holidays.el

;; Copyright (C) 2025 marbor

;; Author: marbor
;; URL: https://github.com/przemarbor/polish-holidays
;; Version: 1.0.0
;; Keywords: calendar

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Replace holidays:
;;
;; (setq calendar-holidays polish-holidays)
;;
;; Or append holidays:
;;
;; (setq calendar-holidays (append calendar-holidays polish-holidays))

;;; Code:

(eval-when-compile
  (require 'calendar)
  (require 'holidays))

;;;###autoload
(defvar polish-holidays-national
  '(
    ;; National and catholic holidays - non-working days
    (holiday-fixed     1  1 "Nowy Rok")                          ;; New Year's Day
    (holiday-fixed     1  6 "Święto Trzech Króli")               ;; Epiphany
    (holiday-easter-etc   0 "Wielkanoc")                         ;; Easter Sunday
    (holiday-easter-etc   1 "Poniedziałek Wielkanocny")          ;; Easter Monday
    (holiday-fixed     5  1 "Święto Pracy")                      ;; Labor Day
    (holiday-fixed     5  3 "Święto Konstytucji 3 Maja")         ;; Constitution Day
    (holiday-easter-etc  49 "Zielone Świątki")                   ;; Whitsun (Pentecost)
    (holiday-easter-etc  60 "Boże Ciało")                        ;; Corpus Christi
    (holiday-fixed     8 15 "Wniebowzięcie Najświętszej Maryi Panny; Święto Wojska Polskiego") ;; Assumption of Mary; Polish Army Day
    (holiday-fixed    11  1 "Dzień Wszystkich Świętych")         ;; All Saints' Day
    (holiday-fixed    11 11 "Narodowe Święto Niepodległości")    ;; Independence Day
    (holiday-fixed    12 25 "Pierwszy dzień Bożego Narodzenia")  ;; Christmas Day
    (holiday-fixed    12 26 "Drugi dzień Bożego Narodzenia - Św. Szczepana")   ;; Boxing Day
    )
  "National Polish holidays - non-working days.")

(defvar polish-holidays-other
  '(
    ;; other special days
    (holiday-fixed     1 21 "Dzień Babci")
    (holiday-fixed     1 22 "Dzień Dziadka")
    (holiday-fixed     2 14 "Walentynki")
    (holiday-easter-etc -52 "Tlusty Czwartek")
    (holiday-fixed     3  8 "Dzień Kobiet")
    (holiday-fixed     5  2 "Dzień Flagi Rzeczypospolitej Polskiej")
    (holiday-fixed     5 26 "Dzień Matki")
    (holiday-fixed     6  1 "Dzień Dziecka")
    (holiday-fixed     6 23 "Dzień Ojca")
    (holiday-fixed     9 30 "Dzień Chłopaka")
    (holiday-fixed    12  6 "Mikołajki")
    (holiday-fixed    12 24 "Wigilia Bożego Narodzenia")         ;; Christmas Eve
    (holiday-fixed    12 31 "Sylwester")                         ;; New Year's Eve
    )
  "Other special days in Poland - working days.")

;; ;; TODO
;; (defvar polish-holidays-catholic
;;  "Catholic holidays"
;;   '(
;;     ;; catholic holidays...
;;     )
;; )

;; ;; TODO
;; (defvar polish-holidays-other-national
;;  "Other national holidays - working days"
;;   '(
;; other national holidays
;; (holiday-fixed     8  1 "Narodowy Dzień Pamięci Powstania Warszawskiego")
;; ... etc.
;;     )
;; )

;; ;; TODO
;; (defvar polish-holidays-minor
;;  "Other minor holidays - working days"
;;   '(
;; 
;; (holiday-fixed    10 14 "Dzień Nauczyciela")
;; ... etc.
;;     )
;; )


(defvar polish-holidays-notable
  (append polish-holidays-national
          polish-holidays-other
          nil)
  "Notable holidays and commemoration dates in Poland.")

(defvar polish-holidays-all
  (append polish-holidays-national
          polish-holidays-other
          ;; polish-holidays-catholic -- TODO
          ;; polish-holidays-other-national -- TODO
          ;; polish-holidays-minor -- TODO
          nil)
  "All (?) holidays and commemoration dates in Poland.")




(defun polish-holidays-set()
  "Enable Polish default calendar and disable other calendars."
  
  ;; disable predefined calendars
  (setq holiday-general-holidays nil
        holiday-bahai-holidays nil
        holiday-hebrew-holidays nil
        holiday-christian-holidays nil
        holiday-islamic-holidays nil
        holiday-oriental-holidays nil)
  
  ;; set Polish default calendar
  (setq calendar-holidays polish-holidays-notable))

(defun polish-holidays-append()
  "Append Polish default calendar."
  (setq calendar-holidays (append calendar-holidays polish-holidays-notable)))


(provide 'polish-holidays)

;;; polish-holidays.el ends here
