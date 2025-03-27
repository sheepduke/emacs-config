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
  (fsharp-indent-offset 2)
  (inferior-fsharp-program
   (concat "dotnet fsi --compilertool:"
           (expand-file-name "~/.dotnet/tools/.store/depman-fsproj/0.2.11/depman-fsproj/0.2.11/tools/net9.0/any")
           " --readline-"))

  :bind
  (:map fsharp-mode-map
        ("C-c" . #'major-mode-hydra)
        ("<return>" . #'fsharp-smart-newline)
        ("M-<return>" . #'eglot-code-actions)
        ("C-<tab>" . #'fsharp-add-indent)
        ("<backtab>" . #'indent-for-tab-command)
        ("C-M-l" . #'fsharp-clear-repl-buffer))

  :hook
  (fsharp-mode . fsharp-setup))

(major-mode-hydra-define fsharp-mode nil
  ("Eval"
   (("c" fsharp-send-region-or-line "region/line")
    ("b" fsharp-send-buffer "buffer"))
   "Compile"
   (("K" compile "compile")
    ("k" recompile "recompile"))
   "REPL"
   (("p" run-fsharp-restart)
    ("l" fsharp-load-buffer-file "load file")
    ("L" fsharp-reload-repl "clear"))))

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

(major-mode-hydra-define csharp-mode nil
  ("Dotnet"
   (("k" recompile))))
