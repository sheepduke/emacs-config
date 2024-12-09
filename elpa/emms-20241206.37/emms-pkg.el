;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "emms" "20241206.37"
  "The Emacs Multimedia System."
  '((cl-lib  "0.5")
    (nadvice "0.3")
    (seq     "0"))
  :url "https://git.savannah.gnu.org/git/emms.git"
  :commit "e956f7aa0103211f4daa0e8c4a9db4e1206c69dc"
  :revdesc "e956f7aa0103"
  :keywords '("emms" "mp3" "ogg" "flac" "music" "mpeg" "video" "multimedia")
  :authors '(("Jorgen Schäfer" . "forcer@forcix.cx"))
  :maintainers '(("Yoni Rabkin" . "yrk@gnu.org")))
