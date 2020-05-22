;;; Package --- Settings for Ivy/Counsel as completion framework

;;; Commentary:

;;; Code:

;; When smex is installed, ivy will behave differently.
(use-package smex
  :ensure
  :config
  (call-when-defined 'smex-initialize))

(use-package ivy
  :ensure
  :init
  ;; Add `recentf-mode' and bookmarks to `ivy-switch-buffer'.
  (setq ivy-use-virtual-buffers t)
  
  ;; Number of result lines to display
  (setq ivy-height 10)
  
  ;; Change the way ivy displays the count of alternatives.
  (setq ivy-count-format "(%d/%d) ")

  ;; Set regex engine for different scenario.
  (setq ivy-re-builders-alist
        '((t . ivy--regex-plus)))

  ;; Enable Ivy mode.
  (ivy-mode 1)

  :bind
  (:map ivy-mode-map
        ;; Utilities
        ("M-x" . counsel-M-x)
        ("C-x C-f" . counsel-find-file)
        ("C-x b" . ivy-switch-buffer)
        ("C-x B" . counsel-buffer-or-recentf)
        ("C-x r b" . counsel-bookmark)
        ("M-i" . counsel-yank-pop)
        ("C-:" . counsel-company)
        ("C-x c t" . counsel-load-theme)
        ;; Search
        ("C-s" . swiper)
        ("C-x c a" . counsel-rg)
        ;; Help
        ("C-h b" . counsel-descbinds)
        ("C-h f" . counsel-describe-function)
        ("C-h v" . counsel-describe-variable)
        ("C-h a" . counsel-apropos)
        ("C-h b" . counsel-descbinds)
        ("C-h S" . counsel-info-lookup-symbol)
        ;; Misc
        ("C-x 8 <return>" . counsel-unicode-char)
        ("C-c C-j" . counsel-outline))

  :delight)

(use-package ivy-rich :ensure
  :config
  (ivy-rich-mode 1))

(use-package counsel-projectile :ensure
  :bind
  (:map ivy-mode-map
        ("C-c p p" . counsel-projectile-switch-project)
        ("C-c p h" . counsel-projectile)
        ("C-c p a" . counsel-projectile-ag)))

;;; d0-ivy.el ends here
