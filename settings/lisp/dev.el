;; ============================================================
;;  Git
;; ============================================================

;; It's Magit! Git inside Emacs.
(use-package magit
  :hook (git-commit-mode . flyspell-mode))

;; ============================================================
;;  Code Snippet
;; ============================================================

(use-package yasnippet
  :demand t

  :bind
  (:map yas-minor-mode-map
        ("M-/" . yas-expand))

  :custom
  (yas-snippet-dirs (list (locate-user-data-file "snippets")))

  :config
  (yas-global-mode 1))

(use-package consult-yasnippet
  :after (consult yasnippet))

;; ============================================================
;;  Code Completion
;; ============================================================

(use-package company
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
  :after company

  :config
  (company-quickhelp-mode 1)

  :custom
  (company-quickhelp-delay 0))

(use-package consult-company
  :after (consult company)
  
  :bind
  (:map company-active-map
        ("C-i" . consult-company)))

;; ============================================================
;;  Hide Show
;; ============================================================

(use-package hideshow
  :hook
  (prog-mode . hs-minor-mode)
  
  :bind (:map hs-minor-mode-map
              ("C-c h s" . hs-show-all)
              ("C-c h h" . hs-hide-all)
              ("C-c h i" . hs-toggle-hiding)))

;;; Highlight nested parens in different colors.
(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package comint-mode
  :bind (:map comint-mode-map
              ("C-M-l" . comint-clear-buffer)))

(use-package prog-mode
  :bind
  (:map prog-mode-map
        ("<return>" . default-indent-new-line)))

(use-package emacs
  :hook
  (text-mode . display-line-numbers-mode)
  (prog-mode . display-line-numbers-mode))
