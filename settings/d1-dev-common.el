;;; Package --- Common settings for development environments

;;; Commentary:

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Company                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package company
  :ensure t

  :bind
  (:map company-mode-map
        ("<tab>" . company-indent-or-complete-common))

  :hook
  ;; Enable company-mode for all programming languages.
  (prog-mode . company-mode)

  :delight " CO"

  :custom
  ;; Make company mode complete immediately.
  (company-idle-delay 0))


(use-package company-quickhelp
  :ensure t

  :config
  (company-quickhelp-mode 1)

  :custom
  (company-quickhelp-delay 0))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                         projectile                           ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package projectile
  :ensure t

  :config
  (projectile-mode 1)

  :custom
  ;; Offline SVN.
  (projectile-svn-command "find . -type f -not -iwholename '*.svn/*' -print0")

  :delight (projectile ""))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Yasnippet                           ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package yasnippet
  :ensure t

  :config
  (yas-global-mode 1)

  :delight ""

  :custom
  (yas-snippet-dirs (list (concat *data-path* "yasnippets"))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                        Syntax Checking                       ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package flycheck :ensure
  :config
  (global-flycheck-mode)

  :delight " FC")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                        Spell Checking                        ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package flyspell
  :ensure t
  
  :config
  (add-hook 'prog-mode-hook 'flyspell-prog-mode)

  :delight " FS")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                        Indentation                           ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package highlight-indent-guides
  :ensure t

  :hook
  (prog-mode . enable-highlight-indent-guides)

  :config
  (defun enable-highlight-indent-guides ()
    "Conditionally enable highlight-indent-guides-mode when under X system."
    (when (x?)
      (highlight-indent-guides-mode 1)))

  :delight ""

  :custom
  (highlight-indent-guides-method 'character)
  ;; Set how obvious the indicator character is. Higher, more obvious.
  (highlight-indent-guides-auto-character-face-perc 10))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                         HS Mode                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package hideshow
  :hook
  (prog-mode . hs-minor-mode)
  
  :bind (:map hs-minor-mode-map
              ("C-c h s" . hs-show-all)
              ("C-c h h" . hs-hide-all)
              ("C-c h i" . hs-toggle-hiding)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Misc                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package prog-mode
  :bind (:map prog-mode-map
              ("<return>" . newline-smart-comment)))


;;; d1-dev-common.el ends here
