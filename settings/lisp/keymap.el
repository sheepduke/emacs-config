(use-package emacs
  :bind

  ;; ============================================================
  ;;  Workspace
  ;; ============================================================

  ("M-1" . persp-switch-to-1)
  ("M-2" . persp-switch-to-2)
  ("M-3" . persp-switch-to-3)
  ("M-4" . persp-switch-to-4)
  ("M-5" . persp-switch-to-5)
  ("M-6" . persp-switch-to-6)
  ("M-7" . persp-switch-to-7)
  ("M-8" . persp-switch-to-8)
  ("M-9" . persp-switch-to-9)

  ;; ============================================================
  ;;  Windows
  ;; ============================================================

  ("M-o" . ace-window)
  ("M-O" . ace-swap-window)
  ("M-p" . windmove-up)
  ("M-n" . windmove-down)
  ("M-l" . windmove-right)
  ("M-h" . windmove-left)
  ("C-x 2" . 'split-window-below-balanced)
  ("C-x 3" . 'split-window-right-balanced)
  ("C-x 0" . 'delete-window-balanced)

  ;; ============================================================
  ;;  Buffer
  ;; ============================================================

  ("C-x b" . switch-to-buffer)
  ("C-x s" . persp-switch-to-scratch-buffer)
  ("C-x k" . kill-current-buffer)
  ("C-x C-k" . bury-buffer)
  ("C-x C-b" . switch-to-other-buffer)
  ("C-x o" . switch-to-other-buffer)

  ;; ============================================================
  ;;  Quick Jump (Goto)
  ;; ============================================================

  ("C-c g b" . 'consult-bookmark)
  ("C-c g r" . 'consult-ripgrep)
  ("C-c g f" . 'consult-fd)
  ("C-c g o" . 'consult-outline)

  ;; ============================================================
  ;;  Editing
  ;; ============================================================

  ("C-'" . avy-goto-char-2)
  ("C-;" . avy-goto-line)
  ("C-x *" . toggle-window-split)

  ("C-c C-SPC" . consult-register-store)
  ("C-c SPC" . consult-register-load)

  ("C-x r e" . mc/edit-lines)
  ("M-u" . upcase-initials-region)
  ("M-q" . fill-paragraph)
  ("M-y" . consult-yank-pop)

  ("C-S-s" . consult-line)
  ("C-M-r" . replace-string)
  ("C-M-S-r" . replace-regexp)
  ("C-M-/" . consult-yasnippet)
  ("C-M-q" . fill-region)
  
  ;; ("C-c j o" . org-journal-open-current-journal-file)
  ;; ("C-c j s" . org-journal-search)
  ;; ("C-c j j" . org-journal-new-entry)
  ;; ("C-c j k" . org-journal-new-scheduled-entry)
  ;; ("C-c j v" . org-journal-schedule-view)

  ;; ============================================================
  ;;  Tools
  ;; ============================================================

  ("C-x v" . 'magit)
  ("C-c o" . 'cfw:open-org-calendar)
  ("C-c O" . 'calendar)
  ("C-c d" . 'sdcv-search-input+)
  ("C-c D" . 'sdcv-search-input)

  ;; ============================================================
  ;;  Toggle
  ;; ============================================================

  ("C-c t a" . 'auto-fill-mode)
  ("C-c t d" . 'toggle-debug-on-error)
  ("C-c t l" . 'display-line-numbers-mode)
  ("C-c t t" . 'toggle-truncate-lines)
  ("C-c t v" . 'visual-line-mode)
  ("C-c t w" . 'toggle-word-wrap)

  ;; ============================================================
  ;;  Music
  ;; ============================================================

  ("C-c e g" . emms-play-directory)
  ("C-c e e" . emms-play-file)
  ("C-c e d" . emms-play-dired)
  ("C-c e f" . emms-shuffle)
  ("C-c e l" . emms-playlist-mode-go)
  ("C-c e x" . emms-start)
  ("C-c e SPC" . emms-pause)
  ("C-c e s" . emms-stop)
  ("C-c e n" . emms-next)
  ("C-c e p" . emms-previous)

  ;; ============================================================
  ;;  Major Modes
  ;; ============================================================

  ("C-c m e" . 'emacs-lisp-mode)
  ("C-c m m" . 'markdown-mode)
  ("C-c m o" . 'org-mode)
  ("C-c m j" . 'js-json-mode)
  ("C-c m x" . 'xml-mode)
  ("C-c m f" . 'fundamental-mode)
  )

(which-key-add-key-based-replacements
  "C-c e" "EMMS"
  "C-c g" "Goto"
  "C-c t" "Toggle")
