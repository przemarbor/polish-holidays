;;; polish-holidays.el --- Polish holidays -*- lexical-binding: t -*-

;; Copyright (C) 2025 marbor

;; Author: marbor
;; URL: https://github.com/przemarbor/polish-holidays
;; Version: 1.0.0
;; Keywords: calendar
;; Package-Requires: ((emacs "24.1"))

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
;; * Description
;; This package adds Polish holidays to the Emacs calendar.
;;
;; If you have ~org-agenda-include-diary~ set to ~t~,
;; these will be also listed in the ~org-agenda~ view.
;;
;; * Installation
;;
;; Replace holidays:
;;     (setq calendar-holidays polish-holidays)
;;
;; Or append holidays:
;;     (setq calendar-holidays (append calendar-holidays polish-holidays))
;;
;; Note that this must be called *before* Emacs calendar is loaded.
;;
;;
;; You can also do the same with functions:
;; After loading the package, in your =init.el= add a call to:
;;     (polish-holidays-set) ;;
;; to enable Polish calendar and disable other calendars,
;;     (polish-holidays-set t) ;;
;; to set ALL Polish calendar holidays and disable other calendars,
;; or add a call to:
;;     (polish-holidays-append)
;; to append Polish calendar to the current list of calendars
;;     (polish-holidays-append t)
;; to append ALL Polish calendar to the current list of calendars


;;; Code:

(eval-when-compile
  (require 'calendar)
  (require 'holidays))

;;;###autoload
(defvar polish-holidays-national
  ;; source: https://pl.wikipedia.org/wiki/Dni_wolne_od_pracy_w_Polsce
  '((holiday-fixed     1  1 "Nowy Rok")                          ;; New Year's Day
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
    (holiday-fixed    12 24 "Wigilia Bożego Narodzenia")         ;; Christmas Eve
    (holiday-fixed    12 25 "Pierwszy dzień Bożego Narodzenia")  ;; Christmas Day
    (holiday-fixed    12 26 "Drugi dzień Bożego Narodzenia; Święto Św. Szczepana")) ;; Boxing Day
  "National Polish holidays - non-working days.")

(defvar polish-holidays-other
  '((holiday-fixed     1 21 "Dzień Babci")
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
    (holiday-fixed    12 31 "Sylwester"))                       ;; New Year's Eve
  "Other special days in Poland - working days.")


;; Fixed-date Great Feasts and Saints in the Catholic Church
(defvar polish-holidays-nonnational-catholic--fixed-holidays
  '((holiday-fixed  1  1 "Uroczystość Świętej Bożej Rodzicielki Maryi") ; "Solemnity of Mary, Mother of God"
    (holiday-fixed  1  6 "Święto Trzech Króli") ; "Epiphany"
    (holiday-fixed  2  2 "Ofiarowanie Pańskie (Matki Bożej Gromnicznej)") ; "Presentation of the Lord (Candlemas)"
    (holiday-fixed  2 11 "Najświętszej Maryi Panny z Lourdes") ; "Our Lady of Lourdes"
    (holiday-fixed  3 19 "Uroczystość Świętego Józefa, Oblubieńca Najświętszej Maryi Panny") ; "Solemnity of Saint Joseph, Spouse of the Blessed Virgin Mary"
    (holiday-fixed  3 25 "Zwiastowanie Pańskie") ; "Annunciation of the Lord"
    (holiday-fixed  4 25 "Świętego Marka Ewangelisty") ; "Saint Mark, the Evangelist"
    (holiday-fixed  4 29 "Święta Katarzyna ze Sieny") ; "Saint Catherine of Siena"
    (holiday-fixed  5 31 "Nawiedzenie Najświętszej Maryi Panny") ; "Visitation of the Blessed Virgin Mary"
    (holiday-fixed  6 24 "Narodzenie Świętego Jana Chrzciciela") ; "Nativity of Saint John the Baptist"
    (holiday-fixed  6 29 "Uroczystość Świętych Apostołów Piotra i Pawła") ; "Solemnity of Saints Peter and Paul, Apostles"
    (holiday-fixed  7 16 "Najświętszej Maryi Panny z Góry Karmel") ; "Our Lady of Mount Carmel"
    (holiday-fixed  8 15 "Wniebowzięcie Najświętszej Maryi Panny") ; "Assumption of the Blessed Virgin Mary"
    (holiday-fixed  9  8 "Narodzenie Najświętszej Maryi Panny") ; "Nativity of the Blessed Virgin Mary"
    (holiday-fixed  9 14 "Podwyższenie Krzyża Świętego") ; "Exaltation of the Holy Cross"
    (holiday-fixed  9 21 "Świętego Mateusza, Apostoła i Ewangelisty") ; "Saint Matthew, Apostle and Evangelist"
    (holiday-fixed 10  18 "Świętego Łukasza Ewangelisty") ; "Saint Luke, the Evangelist"
    (holiday-fixed 10  7 "Najświętszej Maryi Panny Różańcowej") ; "Our Lady of the Rosary"
    (holiday-fixed 11  1 "Uroczystość Wszystkich Świętych") ; "All Saints' Day"
    (holiday-fixed 11  2 "Wspomnienie Wszystkich Wiernych Zmarłych") ; "All Souls' Day"
    (holiday-fixed 11 21 "Ofiarowanie Najświętszej Maryi Panny") ; "Presentation of Mary"
    (holiday-fixed 12  8 "Uroczystość Niepokalanego Poczęcia Najświętszej Maryi Panny") ; "Immaculate Conception of the Blessed Virgin Mary"
    (holiday-fixed 12 12 "Najświętszej Maryi Panny z Guadalupe") ; "Our Lady of Guadalupe"
    (holiday-fixed 12 25 "Boże Narodzenie (Narodzenie Pańskie)") ; "Christmas (Nativity of the Lord)"
    (holiday-fixed 12 26 "Świętego Szczepana, Pierwszego Męczennika") ; "Saint Stephen, the First Martyr"
    (holiday-fixed 12 27 "Świętego Jana, Apostoła i Ewangelisty") ; "Saint John, Apostle and Evangelist"
    (holiday-fixed 12 28 "Święto Młodzianków") ; "Feast of the Holy Innocents"
    (holiday-fixed 12 31 "Świętego Sylwestra I"))) ; "Saint Sylvester I"

;; Holidays based on the Easter date (Paschal cycle)
(defvar polish-holidays-nonnational-catholic--paschal-cycle
  '((holiday-easter-etc -46 "Środa Popielcowa (Początek Wielkiego Postu)") ; "Ash Wednesday (Beginning of Lent)"
    (holiday-easter-etc -21 "Niedziela Laetare") ; "Laetare Sunday"
    (holiday-easter-etc -7  "Niedziela Palmowa") ; "Palm Sunday"
    (holiday-easter-etc -3  "Wielki Czwartek") ; "Holy Thursday"
    (holiday-easter-etc -2  "Wielki Piątek") ; "Good Friday"
    (holiday-easter-etc -1  "Wielka Sobota") ; "Holy Saturday"
    (holiday-easter-etc   0 "Niedziela Wielkanocna") ; "Easter Sunday"
    (holiday-easter-etc   1 "Poniedziałek Wielkanocny") ; "Easter Monday"
    (holiday-easter-etc  39 "Wniebowstąpienie Pańskie") ; "Ascension of the Lord"
    (holiday-easter-etc  49 "Niedziela Zesłania Ducha Świętego (Zielone Świątki)") ; "Pentecost Sunday"
    (holiday-easter-etc  50 "Poniedziałek Zesłania Ducha Świętego") ; "Pentecost Monday"
    (holiday-easter-etc  60 "Uroczystość Najświętszego Ciała i Krwi Chrystusa (Boże Ciało)") ; "Corpus Christi (Most Holy Body and Blood of Christ)"
    (holiday-easter-etc  68 "Uroczystość Najświętszego Serca Pana Jezusa") ; "Solemnity of the Sacred Heart of Jesus"
    (holiday-easter-etc  69 "Niepokalane Serce Najświętszej Maryi Panny"))) ; "Immaculate Heart of Mary"

;; https://pl.wikipedia.org/wiki/%C5%9Awi%C4%99ta_katolickie_w_Polsce
(defvar polish-holidays-catholic
  (append polish-holidays-nonnational-catholic--fixed-holidays
          polish-holidays-nonnational-catholic--paschal-cycle)
  "Catholic Holidays")

;; ;; TODO:
;; (defvar polish-holidays-other-minor
;;  "Other national holidays - working days"
;;   '(
;; other national holidays
;; (holiday-fixed     8  1 "Narodowy Dzień Pamięci Powstania Warszawskiego")
;; (holiday-fixed    10 14 "Dzień Nauczyciela")
;; ... etc.
;;     )
;; )


(defvar polish-holidays-notable
  (append polish-holidays-national
          polish-holidays-other)
  "Notable holidays and commemoration dates in Poland.")

(defvar polish-holidays-all
  (append polish-holidays-notable
          polish-holidays-catholic
          ;; polish-holidays-other-minor -- TODO
          )
  "All (?) holidays and commemoration dates in Poland.")

(defun polish-holidays-get (&optional all?)
  (if all?
      polish-holidays-all
    polish-holidays-notable))

(defun polish-holidays-set (&optional all?)
  "Enable Polish default calendar and disable other calendars."
  ;; disable predefined calendars
  (setq holiday-general-holidays nil
        holiday-bahai-holidays nil
        holiday-hebrew-holidays nil
        holiday-christian-holidays nil
        holiday-islamic-holidays nil
        holiday-oriental-holidays nil)

  ;; set Polish default calendar
  (setq calendar-holidays (polish-holidays-get all?)))


(defun polish-holidays-append (&optional all?)
  "Append Polish default calendar."
  (setq calendar-holidays (append calendar-holidays (polish-holidays-get all?))))


(provide 'polish-holidays)

;;; polish-holidays.el ends here
