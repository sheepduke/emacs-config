(use-package evil
  :functions (evil-local-set-key)

  :init
  (setq evil-want-keybinding nil)

  ;; Define the leader-map.
  (define-prefix-command 'evil-leader-map)

  (defun evil-setup-emacs-lisp-mode-keymap()
    "Setup keymap for emacs-lisp-mode."
    (evil-local-set-key 'normal (kbd "<SPC>lb") #'eval-buffer)
    (evil-local-set-key 'normal (kbd "<SPC>ld") #'eval-defun)
    (evil-local-set-key 'normal (kbd "<SPC>le") #'eval-last-sexp)
    (evil-local-set-key 'normal (kbd "<SPC>lr") #'eval-region))

  (defun evil-setup-lisp-mode-keymap()
    "Setup keymap for lisp-mode."
    (evil-local-set-key 'normal (kbd "<SPC>lh") #'hyperspec-lookup)
    (evil-local-set-key 'normal (kbd "<SPC>lb") #'sly-eval-buffer)
    (evil-local-set-key 'normal (kbd "<SPC>ld") #'sly-eval-defun)
    (evil-local-set-key 'normal (kbd "<SPC>le") #'sly-eval-last-expression)
    (evil-local-set-key 'normal (kbd "<SPC>lp") #'sly-eval-print-last-expression)
    (evil-local-set-key 'normal (kbd "<SPC>lD") #'sly-delete-package)
    (evil-local-set-key 'normal (kbd "<SPC>lc") #'sly-repl-clear-buffer-anywhere)
    (evil-local-set-key 'insert (kbd "<SPC>lc") #'sly-repl-clear-buffer-anywhere))

  :custom
  ;; Regex to match buffer name and the initial state. State can be one of:
  ;; normal, insert, visual, replace, operator, motion, emacs and nil
  (evil-buffer-regexps '(("\\*w3m" . nil)))

  ;; Use C-u to delete to indentation in editing mode.
  (evil-want-C-u-delete t)

  ;; Use undo-tree as the undo system.
  (evil-undo-system 'undo-tree)

  :config
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-mode 1)

  :bind
  (:map evil-leader-map
        ;; Buffer - B
        ("bq" . #'bury-buffer)
        ("bb" . #'consult-bookmark)
        ("bl" . #'consult-buffer)
        ("bk" . #'kill-this-buffer)

        ;; Editing - E
        ("ec" . #'copy-whole-buffer)
        
        ;; File - F
        ("fo" . #'find-file)
        ("fd" . #'dired)

        ;; Goto - G
        ("gl" . #'avy-goto-line)
        ("gs" . #'consult-line)
        ("gm" . #'consult-mark)
        ("go" . #'consult-outline)
        ("gp" . #'consult-projectile)

        ;; Help - H
        ("hf" . #'describe-function)
        ("hk" . #'describe-key)
        ("hm" . #'describe-mode)
        ("hs" . #'describe-symbol)
        ("hv" . #'describe-variable)
        ("hi" . #'info)

        ;; Tools - T
        ("tf" . #'auto-fill-mode)
        ("tc" . #'calendar)
        ("tn" . #'compose-mail)
        ("te" . #'eshell)
        ("tl" . #'linum-mode)
        ("tv" . #'magit)
        ("tm" . #'notmuch)
        ("ts" . #'sdcv-search-input)
        ("td" . #'toggle-debug-on-error)
        ("tt" . #'toggle-truncate-lines)
        ("tw" . #'toggle-word-wrap)
        ("tu" . #'undo-tree-visualize)

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
  (emacs-lisp-mode . evil-setup-emacs-lisp-mode-keymap))

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
  (general-define-key
   :states '(normal visual motion)
   :keymaps 'override
   "SPC" 'evil-leader-map))

(use-package lispyville
  :disabled
  :after evil lispy

  :hook
  (emacs-lisp-mode . #'lispyville-mode)
  (lisp-mode . #'lispyville-mode))
