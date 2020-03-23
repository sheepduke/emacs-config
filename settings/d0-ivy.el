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
        ("C-h b" . counsel-descbinds)
        ("C-h f" . counsel-describe-function)
        ("C-h v" . counsel-describe-variable)
        ("C-h a" . counsel-apropos)
        ("C-h S" . counsel-info-lookup-symbol)
        ("C-x C-f" . counsel-find-file)
        ("C-x r b" . counsel-bookmark)
        ("C-s" . swiper)
        ("M-i" . counsel-yank-pop)
        ("C-:" . counsel-company)
        ;; Global
        ("C-x c a" . counsel-rg)
        ("C-x c t" . counsel-load-theme)
        ;; Projectile
        ("C-c p p" . counsel-projectile-switch-project)
        ("C-c p h" . counsel-projectile)
        ("C-c p a" . counsel-projectile-ag)
        ;; Misc
        ("C-x 8 <return>" . counsel-unicode-char)
        ("C-h b" . counsel-descbinds)
        ("C-c C-j" . counsel-outline)))

;;; d0-ivy.el ends here
