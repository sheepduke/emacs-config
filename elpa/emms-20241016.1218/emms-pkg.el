;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "emms" "20241016.1218"
  "The Emacs Multimedia System."
  '((cl-lib  "0.5")
    (nadvice "0.3")
    (seq     "0"))
  :url "https://git.savannah.gnu.org/git/emms.git"
  :commit "5d4464c08481a8fbd584326ede99ff718aab40ad"
  :revdesc "5d4464c08481"
  :keywords '("emms" "mp3" "ogg" "flac" "music" "mpeg" "video" "multimedia")
  :authors '(("Jorgen Schäfer" . "forcer@forcix.cx"))
  :maintainers '(("Yoni Rabkin" . "yrk@gnu.org")))
