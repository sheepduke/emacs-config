(use-package evil
  :functions (evil-local-set-key)

  :init
  (setq evil-want-keybinding nil)
  (global-undo-tree-mode 1)

  ;; Define the leader-map.
  (define-prefix-command 'evil-leader-map)

  :custom
  ;; Regex to match buffer name and the initial state. State can be one of:
  ;; normal, insert, visual, replace, operator, motion, emacs and nil
  (evil-buffer-regexps '(("\\*w3m" . nil)))

  ;; Use C-u to delete to indentation in editing mode.
  (evil-want-C-u-delete t)

  ;; Use undo-tree as the undo system.
  (evil-undo-system 'undo-tree)

  :config
  (defun evil-setup-emacs-lisp-mode-keymap()
    "Setup keymap for emacs-lisp-mode."
    (evil-local-set-key 'normal (kbd "<SPC>lb") #'eval-buffer)
    (evil-local-set-key 'normal (kbd "<SPC>ld") #'eval-defun)
    (evil-local-set-key 'normal (kbd "<SPC>ll") #'eval-last-sexp)
    (evil-local-set-key 'normal (kbd "<SPC>lr") #'eval-region))

  (defun evil-setup-lisp-mode-keymap()
    "Setup keymap for lisp-mode."
    (evil-local-set-key 'normal (kbd "<SPC>lh") #'hyperspec-lookup)
    (evil-local-set-key 'normal (kbd "<SPC>lb") #'sly-eval-buffer)
    (evil-local-set-key 'normal (kbd "<SPC>ld") #'sly-eval-defun)
    (evil-local-set-key 'normal (kbd "<SPC>ll") #'sly-eval-last-expression)
    (evil-local-set-key 'normal (kbd "<SPC>lp") #'sly-eval-print-last-expression)
    (evil-local-set-key 'normal (kbd "<SPC>lD") #'sly-delete-package)
    (evil-local-set-key 'normal (kbd "<SPC>lc") #'sly-repl-clear-buffer-anywhere))

  (defun evil-setup-fsharp-mode-keymap ()
    "Setup keymap for F#."
    (evil-local-set-key 'normal (kbd "<SPC>lb") #'fsharp-eval-buffer)
    (evil-local-set-key 'normal (kbd "<SPC>ll") #'fsharp-eval-phrase)
    (evil-local-set-key 'normal (kbd "<SPC>lr") #'fsharp-eval-region))

  (evil-set-leader 'normal (kbd "SPC"))
  (evil-ex-define-cmd "q" #'kill-this-buffer)
  (evil-ex-define-cmd "wq" #'save-and-kill-this-buffer)
  (evil-mode 1)

  :bind
  (:map evil-leader-map
        ;; Buffer - B
        ("b q" . #'bury-buffer)
        ("b s" . #'save-buffer)
        ("b b" . #'switch-to-buffer)
        ("b o" . #'switch-to-other-buffer)
        ("b l" . #'consult-bookmark)
        ("b p" . #'consult-projectile)
        ("b d" . #'dired)
        ("b f" . #'find-file)
        ("b k" . #'kill-this-buffer)

        ;; Editing - E
        ("e c" . #'copy-whole-buffer)
        
        ;; Goto - G
        ("g l" . #'avy-goto-line)
        ("g s" . #'consult-line)
        ("g m" . #'consult-mark)
        ("g o" . #'consult-outline)

        ;; Help - H
        ("h f" . #'describe-function)
        ("h k" . #'describe-key)
        ("h m" . #'describe-mode)
        ("h s" . #'describe-symbol)
        ("h v" . #'describe-variable)
        ("h i" . #'info)

        ;; Org - O
        ("o a" . #'org-agenda)
        ("o c" . #'org-capture)
        ("o o" . #'org-journal-open-current-journal-file)
        ("o j" . #'org-journal-new-entry)

        ;; Perspecitve - P
        ("p" . #'perspective-map)

        ;; Tools - T
        ("t f" . #'auto-fill-mode)
        ("t c" . #'calendar)
        ("t n" . #'compose-mail)
        ("t e" . #'eshell)
        ("t l" . #'linum-mode)
        ("t v" . #'magit)
        ("t m" . #'notmuch)
        ("t s" . #'sdcv-search-input)
        ("t d" . #'dired-sidebar-jump-to-sidebar)
        ("t t" . #'toggle-truncate-lines)
        ("t w" . #'toggle-word-wrap)
        ("t u" . #'undo-tree-visualize)

        ;; Window - W
        ("w" . #'evil-window-map)

        ;; Command - X
        ("x" . #'execute-extended-command))
  
  (:map evil-window-map
        ("C-d" . #'toggle-window-dedicated)
        ("C-w" . #'ace-window)
        ("M-w" . #'ace-swap-window)
        ("u" . #'winner-undo))

  (:map evil-normal-state-map
        ("SPC" . evil-leader-map))

  :hook
  (emacs-lisp-mode . evil-setup-emacs-lisp-mode-keymap)
  (fsharp-mode . evil-setup-fsharp-mode-keymap)
  (lisp-mode . evil-setup-lisp-mode-keymap))

(use-package evil-collection
  :after evil

  :config
  (evil-collection-init))

;; Make leader key in special buffers, such as dired.
(use-package general
  :after evil
  :init
  (setq general-override-states '(insert
                                  emacs
                                  hybrid
                                  normal
                                  visual
                                  motion
                                  operator
                                  replace))
  :config
  (general-define-key :states '(normal visual motion)
                      :keymaps 'override
                      "SPC"
                      'evil-leader-map)

  (evil-collection-define-key 'normal 'dired-mode-map
    "gk" #'dired-kill-subdir
    "a" #'dired-find-alternate-file))

(use-package lispyville
  :disabled
  :after evil lispy

  :hook
  (emacs-lisp-mode . #'lispyville-mode)
  (lisp-mode . #'lispyville-mode))
