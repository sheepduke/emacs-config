(use-package nxml-mode
  :mode "\\.xml\\'"
  
  :hook (nxml-mode . indent-guide-mode))

(use-package yaml-mode
  :mode "\\.yml\\'"
  :mode "\\.yaml\\'"
  :mode "\\.yml.j2\\'"

  :hook (yaml-mode . indent-guide-mode)

  :bind (:map yaml-mode-map
              ("<return>" . smart-newline)))

(use-package conf-mode
  :bind (:map conf-mode-map
              ("<return>" . smart-newline)))

(use-package powershell
  :mode "\\.ps1\\'")

(use-package systemd)

(use-package ahk-mode
  :mode "\\.ahk\\'")

(use-package site-gentoo
  :if (locate-library "site-gentoo"))

;; Ebuild mode, for Gentoo users.
(use-package ebuild-mode
  :mode "\\.use\\'"
  :mode "\\.mask\\'"
  :mode "\\.unmask\\'")

(use-package kotlin-mode
  :mode "\\.kt\\'")

(use-package dockerfile-mode
  :mode "Dockerfile")
