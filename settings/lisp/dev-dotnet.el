;; ============================================================
;;  F#
;; ============================================================

;; F# development support.
;; Key bindings in evil settings.
(use-package eglot-fsharp
  :ensure)

(use-package fsharp-mode
  :ensure
  :after eglot-fsharp
  :mode "\\.fs\\'"

  :preface
  (defun fsharp-setup ()
    (interactive)
    (setq yas-indent-line 'fixed)
    (eglot-ensure)
    (add-hook 'before-save-hook #'eglot-format-buffer nil t))

  :init (require 'fsharp-plus)

  :custom
  (inferior-fsharp-program
   (concat "dotnet fsi --compilertool:"
           (expand-file-name "~/.dotnet/tools/.store/depman-fsproj/0.2.11/depman-fsproj/0.2.11/tools/net9.0/any")
           " --readline-"))

  :bind
  (:map fsharp-mode-map
        ("<return>" . #'fsharp-smart-newline)
        ("<C-tab>" . #'fsharp-dec-indent)
        ("<backtab>" . #'fsharp-inc-indent)
        ("C-c C-p" . #'run-fsharp)
        ("C-c C-o" . #'fsharp-clear-repl-buffer)
        ("C-c C-e" . #'fsharp-eval-phrase)
        ("C-c C-c" . #'fsharp-send-region-or-line)
        ("C-c C-b" . #'fsharp-send-buffer)
        ("C-c C-k" . #'fsharp-load-buffer-file)
        ("C-c C-l" . #'fsharp-reload-project))

  :hook
  (fsharp-mode . fsharp-setup))

(use-package dotnet
  :ensure
  :after fsharp-mode

  :bind
  (:map fsharp-mode-map
        ("C-c C-r" . #'dotnet-run)
        ("C-c C-t" . #'dotnet-test)))

;; ============================================================
;;  C#
;; ============================================================

(use-package csharp-mode
  :init
  (defun csharp-setup-buffer ()
    (eglot-ensure)
    (add-hook 'before-save-hook 'eglot-format-buffer nil t))

  (defun csharp-newline-with-brackets ()
    (interactive)
    (smart-newline)
    (insert "{}")
    (c-indent-line-or-region)
    (backward-char)
    (smart-newline)
    (save-excursion
      (next-line)
      (c-indent-line-or-region)))

  :bind
  (:map csharp-mode-map
        ("C-<return>" . csharp-newline-with-brackets)
        ("M-<return>" . eglot-code-actions))

  :hook
  (csharp-mode . csharp-setup-buffer))

(use-package csproj-mode
  :ensure
  :mode "\\.csproj\\'"
  :mode "\\.fsproj\\'"
  :mode "\\Directory.Build.props\\'"
  :mode "\\Directory.Packages.props\\'")

;; (major-mode-hydra-define csharp-mode nil
;;   ("Dotnet"
;;    (("k" recompile))))
