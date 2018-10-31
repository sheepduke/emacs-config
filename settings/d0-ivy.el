(use-package ivy
  :init
  ;; Add `recentf-mode' and bookmarks to `ivy-switch-buffer'.
  (setq ivy-use-virtual-buffers t)
  ;; Number of result lines to display
  (setq ivy-height 10)
  ;; Change the way ivy displays the count of alternatives.
  (setq ivy-count-format "(%d/%d) ")

  :bind
  (:map ivy-mode-map
        ("C-s" . swiper)
        ("C-c c t" . counsel-load-theme)
        ("C-'" . ivy-avy))
  
  :config
  (ivy-mode 1))
