(use-package emacs
  :bind
  ("C-x b" . switch-to-buffer)
  ("C-x B" . persp-switch-to-scratch-buffer)
  ("C-x f" . find-file)
  ("C-x H" . copy-whole-buffer)
  ("C-x k" . kill-this-buffer)
  ("C-x o" . switch-to-other-buffer)

  ("C-x r b" . consult-bookmark)
  ("C-x r e" . mc/edit-lines)

  ("C-x s" . save-buffer)
  ("C-'" . avy-goto-char-timer)
  ("C-x *" . toggle-window-split)


  ("C-x C-k" . bury-buffer)

  ("C-c C-SPC" . consult-register-store)
  ("C-c SPC" . consult-register)

  ("C-c 3" . w3m)
  ("C-c d" . sdcv-search-input)  

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

  ("C-c m" . notmuch)

  ("C-c j o" . org-journal-open-current-journal-file)
  ("C-c j s" . org-journal-search)
  ("C-c j j" . org-journal-new-entry)
  ("C-c j k" . org-journal-new-scheduled-entry)
  ("C-c j v" . org-journal-schedule-view)

  ("C-c o" . cfw:open-org-calendar)
  ("C-c s" . shell)

  ("C-c t a" . auto-fill-mode)
  ("C-c t d" . toggle-debug-on-error)
  ("C-c t i" . auto-revert-tail-mode)
  ("C-c t t" . toggle-truncate-lines)
  ("C-c t w" . toggle-word-wrap)
  ("C-c t v" . visual-line-mode)

  ("M-1" . persp-switch-to-1)
  ("M-2" . persp-switch-to-2)
  ("M-3" . persp-switch-to-3)
  ("M-4" . persp-switch-to-4)
  ("M-5" . persp-switch-to-5)
  ("M-6" . persp-switch-to-6)
  ("M-7" . persp-switch-to-7)
  ("M-8" . persp-switch-to-8)
  ("M-9" . persp-switch-to-9)
  
  ("M-u" . upcase-initials-region)
  ("M-;" . toggle-comment-in-line)
  ("M-q" . fill-paragraph)
  ("M-y" . consult-yank-pop)
  ("M-g e" . consult-compile-error)
  ("M-g f" . consult-flymake)   ;; Alternative: consult-flycheck
  ("M-g g" . avy-goto-line)
  ("M-g M-g" . consult-goto-line) ;; orig. goto-line
  ("M-g i" . consult-imenu)
  ("M-g I" . consult-imenu-multi)
  ("M-g k" . consult-global-mark)
  ("M-g m" . consult-mark)
  ("M-g o" . consult-outline)     ;; Alternative: consult-org-heading

  ("M-s d" . consult-find)
  ("M-s D" . consult-locate)
  ("M-s g" . consult-grep)
  ("M-s G" . consult-git-grep)
  ("M-s r" . consult-ripgrep)
  ("M-s l" . consult-line-multi)
  ("M-s k" . consult-keep-lines)
  ("M-s u" . consult-focus-lines)
  
  ("C-S-s" . consult-line)
  ("C-M-r" . replace-string)
  ("C-M-S-r" . replace-regexp)
  ("C-M-/" . consult-yasnippet)
  ("C-M-q" . fill-region)
)

(use-package devil
  :config
  (global-devil-mode 1))
