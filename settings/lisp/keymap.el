;; ============================================================
;;  Keymap
;; ============================================================

(use-package emacs
  :bind
  ;; Buffer.
  ("C-x b" . switch-to-buffer)
  ("C-x B" . persp-switch-to-scratch-buffer)
  ("C-x k" . kill-current-buffer)
  ("C-x C-k" . bury-buffer)
  ("C-x C-b" . switch-to-other-buffer)
  ("C-x o" . switch-to-other-buffer)

  ;; File.
  ("C-x f" . find-file)

  ;; Bookmark.
  ("C-x r b" . consult-bookmark)

  ("C-'" . avy-goto-char-timer)
  ("C-x *" . toggle-window-split)

  ;; ("C-c SPC" . consult-register-store)
  ;; ("C-c C-SPC" . consult-register-load)

  ;; ("C-c 3" . w3m)
  ;; ("C-c d" . sdcv-search-input)  

  ;; ("C-c e g" . emms-play-directory)
  ;; ("C-c e e" . emms-play-file)
  ;; ("C-c e d" . emms-play-dired)
  ;; ("C-c e f" . emms-shuffle)
  ;; ("C-c e l" . emms-playlist-mode-go)
  ;; ("C-c e x" . emms-start)
  ;; ("C-c e SPC" . emms-pause)
  ;; ("C-c e s" . emms-stop)
  ;; ("C-c e n" . emms-next)
  ;; ("C-c e p" . emms-previous)

  ;; ("C-c m" . notmuch)

  ;; ("C-c j o" . org-journal-open-current-journal-file)
  ;; ("C-c j s" . org-journal-search)
  ;; ("C-c j j" . org-journal-new-entry)
  ;; ("C-c j k" . org-journal-new-scheduled-entry)
  ;; ("C-c j v" . org-journal-schedule-view)

  ;; ("C-c o" . cfw:open-org-calendar)
  ;; ("C-c O" . calendar)
  ;; ("C-c s" . shell)

  ("C-x r e" . mc/edit-lines)

  ("M-1" . persp-switch-to-1)
  ("M-2" . persp-switch-to-2)
  ("M-3" . persp-switch-to-3)
  ("M-4" . persp-switch-to-4)
  ("M-5" . persp-switch-to-5)
  ("M-6" . persp-switch-to-6)
  ("M-7" . persp-switch-to-7)
  ("M-8" . persp-switch-to-8)
  ("M-9" . persp-switch-to-9)
  
  ("M-o" . ace-window)
  ("M-O" . ace-swap-window)
  
  ("M-P" . windmove-up)
  ("M-N" . windmove-down)
  ("M-L" . windmove-right)
  ("M-H" . windmove-left)
  
  ("M-u" . upcase-initials-region)
  ("M-q" . fill-paragraph)
  ("M-y" . consult-yank-pop)
  
  ("M-g e" . consult-compile-error)
  ("M-g f" . consult-flymake)
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
  ("C-M-q" . fill-region))

;; Unbind C-c key bindings.
(dolist (keymap (list flyspell-mode-map))
  (define-key keymap (kbd "C-c") nil))

;; ============================================================
;;  Evil
;; ============================================================

(use-package evil
  :ensure t
  :demand t

  :init
  ;; Required by evil-collection.
  (setq evil-want-keybinding nil)
  (setq evil-want-integration t)

  :custom
  (evil-undo-system 'undo-tree)
  (evil-want-C-u-scroll t)
  (evil-want-C-u-delete t)
  (evil-disable-insert-state-bindings nil)
  (evil-search-module 'evil-search)

  :config
  (evil-define-key 'normal 'global (kbd "M-u") 'universal-argument)

  ;; Use Corfu for completion, disabling these keys.
  (evil-define-key 'insert 'global (kbd "C-n") nil)
  (evil-define-key 'insert 'global (kbd "C-p") nil)

  (setq display-line-numbers-type 'relative)
  
  (define-prefix-command 'evil-custom-global-leader-map)
  (keymap-set evil-motion-state-map "SPC" 'evil-custom-global-leader-map)
  (keymap-set evil-normal-state-map "SPC" 'evil-custom-global-leader-map)

  (evil-define-key nil evil-custom-global-leader-map
    ;; Buffer.
    "bb" 'switch-to-buffer
    "bc" 'kill-current-buffer
    "bl" 'persp-list-buffers
    "bo" 'switch-to-other-buffer
    "bq" 'bury-buffer
    "br" 'rename-buffer
    "bs" 'persp-switch-to-scratch-buffer

    ;; File.
    "ff" 'find-file
    "fs" 'save-buffer
    "fD" 'delete-file-and-kill-buffer

    ;; Workspace.
    "wn" 'persp-create
    "wr" 'persp-rename
    "wq" 'persp-kill-current
    "wh" 'persp-prev
    "wl" 'persp-next
    "wH" 'persp-swap-previous
    "wL" 'rsp-swap-next

    ;; Project.
    "pd" 'project-dired
    "pf" 'project-find-file
    "pp" 'project-switch-project

    ;; Jump.
    "jb" 'consult-bookmark
    "jc" 'avy-goto-char-timer
    "jf" 'consult-fd
    "jl" 'consult-line
    "jo" 'consult-outline
    "jr" 'consult-ripgrep

    ;; Utilities.
    "ue" 'erase-buffer
    "um" 'mc/edit-lines
    "ur" 'evil-show-registers
    "us" 'sort-lines

    ;; Set.
    "sa" 'auto-fill-mode
    "sd" 'toggle-debug-on-error
    "sh" 'evil-ex-nohighlight
    "st" 'toggle-truncate-lines
    "sv" 'visual-line-mode
    "sw" 'toggle-word-wrap

    ;; Tools.
    "tL" 'calendar
    "tc" 'calculator
    "td" 'sdcv-search-input
    "tl" 'cfw:open-org-calendar
    "tm" 'magit
    "tw" 'w3m

    ;; Emms.
    "ed" 'emms-play-dired
    "ee" 'emms-pause
    "ef" 'emms-play-file
    "eg" 'emms-play-directory
    "el" 'emms-playlist-mode-go
    "en" 'emms-next
    "ep" 'emms-previous
    "es" 'emms-shuffle
    "et" 'emms-stop

    ;; Help.
    "hk" 'evil-collection-describe-bindings)

  (which-key-add-key-based-replacements
    "SPC b" "Buffer"
    "SPC e" "Emms"
    "SPC f" "File"
    "SPC h" "Help"
    "SPC j" "Jump"
    "SPC p" "Project"
    "SPC s" "Settings"
    "SPC t" "Tools"
    "SPC u" "Utilities"
    "SPC w" "Workspace")

  (evil-mode 1)
  (global-undo-tree-mode 1))

(use-package evil-collection
  :ensure t
  :after evil
  :demand t

  :custom
  (evil-collection-key-blacklist '("SPC"))

  :config
  (evil-collection-init))
