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

  ;; Redefine C-s to save.
  (evil-define-key 'normal 'global (kbd "C-s") 'save-buffer)
  (evil-define-key 'insert 'global (kbd "C-s") 'save-buffer)
  
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
    "wc" 'persp-kill-current
    "wq" 'persp-kill-current
    "wh" 'persp-prev
    "wl" 'persp-next
    "wH" 'persp-swap-previous
    "wL" 'persp-swap-next

    ;; Project.
    "pd" 'project-dired
    "pf" 'project-find-file
    "pp" 'project-switch-project

    ;; Jump.
    "jb" 'consult-bookmark
    "jc" 'avy-goto-char-timer
    "jf" 'consult-fd
    "jl" 'avy-goto-line
    "jo" 'consult-outline
    "jr" 'consult-ripgrep
    "js" 'consult-line

    ;; Utilities.
    "uc" 'copy-buffer-content
    "ud" 'delete-duplicate-lines
    "ue" 'erase-buffer
    "um" 'mc/edit-lines
    "ur" 'evil-show-registers
    "us" 'sort-lines
    "u=" 'indent-whole-buffer

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
    "hc" 'describe-char
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
  (evil-collection-init)

  (evil-define-key 'normal dired-mode-map
    "O" 'dired-open-externally
    "," 'dired-kill-subdir))
