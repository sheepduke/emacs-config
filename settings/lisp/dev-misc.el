(use-package nxml-mode
  :mode "\\.xml\\'"

  :bind
  (:map nxml-mode-map
        ("M-h" . nil))
  
  :hook (nxml-mode . indent-guide-mode))

(use-package yaml-mode
  :ensure
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
  :ensure

  :bind
  (:map powershell-mode-map
        ("C-'" . nil)))

(use-package systemd :ensure)

(use-package ahk-mode
  :ensure
  :mode "\\.ahk\\'")

(use-package site-gentoo
  :if (locate-library "site-gentoo"))

;; Ebuild mode, for Gentoo users.
(use-package ebuild-mode
  :mode "\\.use\\'"
  :mode "\\.mask\\'"
  :mode "\\.unmask\\'")

(use-package kotlin-mode
  :ensure
  :mode "\\.kt\\'")

(use-package dockerfile-mode
  :ensure
  :mode "Dockerfile")
