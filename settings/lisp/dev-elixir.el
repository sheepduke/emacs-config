;;; Put the language server in the PATH to let it auto configure.
;;; 
;;; Git repository:
;;; https://github.com/elixir-lang/expert
;;;
;;; Download the LSP server and put it under PATH.

(use-package elixir-mode
  :ensure

  :preface
  (defun elixir-mode-setup-buffer ()
    (message "Starting eglot")
    (eglot-ensure)
    (add-hook 'before-save-hook 'eglot-format-buffer nil t))

  :config
  (when (windows?)
    (add-to-list 'eglot-server-programs '(elixir-mode "language_server.bat")))

  (defun elixir-mode-project-root (dir)
    "Configure Elixir LSP to recognize nested modules."
    (when-let ((root (locate-dominating-file dir "mix.exs")))
      (cons 'transient root)))

  (with-eval-after-load 'project
    (add-hook 'project-find-functions #'elixir-mode-project-root))

  (require 'inf-elixir)

  ;; Use Expert as LSP server.
  (add-to-list 'eglot-server-programs '((elixir-mode) "expert" "--stdio"))

  :hook
  (elixir-mode . elixir-mode-setup-buffer))

(use-package inf-elixir
  :ensure

  :after elixir-mode

  :preface
  (defun elixir-add-prefix-@ ()
    (interactive)
    (save-excursion
      (backward-sexp)
      (insert "@")))

  (defun elixir-add-prefix-% ()
    (interactive)
    (save-excursion
      (backward-sexp)
      (insert "%")))

  (defun inf-elixir-smart-repl ()
    (interactive)
    (save-selected-window
      (if (inf-elixir--find-project-root)
          (inf-elixir-project)
        (inf-elixir))))

  (defun inf-elixir-send-dwim ()
    (interactive)
    (if (region-active-p)
        (inf-elixir-send-region)
      (inf-elixir-send-line)))

  (defun inf-elixir-recompile-project ()
    (interactive)
    (inf-elixir--send "recompile"))

  (defun inf-elixir-run-unit-tests ()
    (interactive)
    (inf-elixir-send-buffer)
    (inf-elixir--send "ExUnit.run()\n"))

  (defun inf-elixir-clear-repl-buffer ()
    (interactive)
    (if-let (repl-buffer (inf-elixir--determine-repl-buf))
        (with-current-buffer repl-buffer
          (comint-clear-buffer))
      (message "Not attached to any REPL buffer")))

  :custom
  (inf-elixir-switch-to-repl-on-send nil)
  (inf-elixir-base-command (if (windows?) "iex.bat" "iex"))

  :bind (:map elixir-mode-map
              ("C-2" . elixir-add-prefix-@)
              ("C-5" . elixir-add-prefix-%)
              ("C-c C-p" . inf-elixir-smart-repl)
              ("C-c C-c" . inf-elixir-send-dwim)
              ("C-c C-b" . inf-elixir-send-buffer)
              ("C-c C-k" . inf-elixir-reload-module)
              ("C-c C-l" . inf-elixir-recompile-project)
              ("C-c C-u" . inf-elixir-run-unit-tests)
              ("C-c C-o" . inf-elixir-clear-repl-buffer)))
