(use-package ivy
  :init
  ;; Add `recentf-mode' and bookmarks to `ivy-switch-buffer'.
  (setq ivy-use-virtual-buffers t)
  
  ;; Number of result lines to display
  (setq ivy-height 10)
  
  ;; Change the way ivy displays the count of alternatives.
  (setq ivy-count-format "(%d/%d) ")

  ;; Do not ignore VCS files.
  (setq counsel-ag-base-command "ag --nocolor --nogroup -U --ignore .git %s")

  ;; Set regex engine for different scenario.
  (setq ivy-re-builders-alist
      '((ivy-switch-buffer . ivy--regex-plus)
        (t . ivy--regex-fuzzy)))

  :bind
  (:map ivy-mode-map
        ("C-s" . swiper)
        ("M-i" . counsel-yank-pop)
        ("C-:" . counsel-company)
        ;; Global
        ("C-c c a" . counsel-ag)
        ("C-c c t" . counsel-load-theme)
        ;; Projectile
        ("C-c p p" . counsel-projectile-switch-project)
        ("C-c p h" . counsel-projectile)
        ("C-c p a" . counsel-projectile-ag)
        ;; Misc
        ("C-h b" . counsel-descbinds))
  
  :config
  (ivy-mode 1))
