;;; Package --- Common settings for development environments

;;; Commentary:

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Company                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package company :ensure
  :delight " CO"
  
  :preface
  (cl-defun company-mode-setup-yasnippet (hook-name)
    (setq company-backends
          (mapcar (lambda (backend)
                    (if (and (listp backend)
                             (member 'company-yasnippet backend))
                        backend
                      (flatten-list `(,backend :with company-yasnippet))))
                  company-backends)))

  :init
  ;; Make company mode complete immediately.
  (setq company-idle-delay 0)

  :bind
  (:map company-mode-map
  		("<tab>" . company-indent-or-complete-common))

  :hook
  ;; Enable company-mode for all programming languages.
  (prog-mode . company-mode))

(use-package company-quickhelp
  :ensure
  :init
  (setq company-quickhelp-delay 0)

  :config
  (call-when-defined 'company-quickhelp-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                         projectile                           ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package projectile
  :ensure
  :delight (projectile "")
  
  :init
  ;; Offline SVN.
  (setq projectile-svn-command "find . -type f -not -iwholename '*.svn/*' -print0")

  :config
  (call-when-defined 'projectile-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Yasnippet                           ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package yasnippet
  :ensure
  :init
  (setq yas-snippet-dirs (list (concat *data-path* "yasnippets")))

  :bind
  (:map yas-keymap
        ("<tab>" . nil))

  :config
  (call-when-defined 'yas-global-mode 1)

  :delight (yasnippet ""))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                        Syntax Checking                       ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package flycheck :ensure
  :config
  (call-when-defined 'global-flycheck-mode)

  :delight " FC")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                        Spell Checking                        ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package flyspell :ensure
  :config
  (add-hook 'prog-mode-hook 'flyspell-prog-mode)

  :delight " FS")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                        Indentation                           ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package highlight-indent-guides
  :ensure
  :init
  (setq highlight-indent-guides-method 'character)
  ;; Set how obvious the indicator character is. Higher, more obvious.
  (setq highlight-indent-guides-auto-character-face-perc 10)

  :preface
  (defun enable-highlight-indent-guides ()
    "Conditionally enable highlight-indent-guides-mode when under X system."
    (when (x?)
      (highlight-indent-guides-mode 1)))

  :hook
  (prog-mode . enable-highlight-indent-guides)

  :delight "")

(use-package fill-column-indicator
  :ensure
  :after company

  :preface
  (defvar-local company-fci-mode-on-p nil
    "Used by hack between company-mode and fci-mode inside dev-common.el")

  (defun company-turn-off-fci (&rest ignore)
    (when (boundp 'fci-mode)
      (setq company-fci-mode-on-p fci-mode)
      (when fci-mode (call-when-defined 'fci-mode -1))))

  (defun company-maybe-turn-on-fci (&rest ignore)
    (when company-fci-mode-on-p (call-when-defined 'fci-mode 1)))

  :init
  (setq-default fill-column 79)
  ;; Do not truncate long lines.
  (setq fci-handle-truncate-lines nil)

  :hook
  (company-completion-started . company-turn-off-fci)
  (company-completion-finished . company-maybe-turn-on-fci)
  (company-completion-cancelled . company-maybe-turn-on-fci))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                         HS Mode                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'hideshow)
(use-package hideshow
  :ensure
  
  :hook
  (prog-mode . hs-minor-mode)
  
  :bind
  (:map hs-minor-mode-map
        ("C-c h S" . hs-show-all)
        ("C-c h H" . hs-hide-all)
        ("C-c h h" . hs-toggle-hiding))

  :delight (hideshow "HS"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Misc                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package prog-mode
  :bind
  (:map prog-mode-map
        ("<return>" . newline-smart-comment))

  :hook
  (prog-mode . turn-linum-mode-on))


;;; d1-dev-common.el ends here
