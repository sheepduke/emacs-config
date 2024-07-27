(use-package elixir-mode
  :mode "\\.ex\\'"
  :mode "\\.exs\\'"

  :config
  (require 'eglot)
  (when (windows?)
    (add-to-list 'eglot-server-programs '(elixir-mode "language_server.bat")))

  (defun elixir-mode-setup-buffer ()
    (message "Starting eglot")
    (eglot-ensure)
    (add-hook 'before-save-hook 'eglot-format-buffer nil t))

  (require 'inf-elixir)

  :hook
  (elixir-mode . elixir-mode-setup-buffer))

(use-package inf-elixir
  :init
  (defun inf-elixir-smart-repl ()
    (interactive)
    (if (inf-elixir--find-project-root)
        (inf-elixir-project)
      (inf-elixir)))

  (defun inf-elixir-clear-repl-buffer ()
    (interactive)
    (if inf-elixir-repl-buffer
        (with-current-buffer inf-elixir-repl-buffer
          (comint-clear-buffer))
      (message "Not attached to any REPL buffer")))

  :custom
  (inf-elixir-switch-to-repl-on-send nil)
  (inf-elixir-base-command (if (windows?) "iex.bat" "iex"))

  :bind (:map elixir-mode-map
              ("C-c C-p" . inf-elixir-smart-repl)
              ("C-c C-c" . inf-elixir-send-line)
              ("C-c C-r" . inf-elixir-send-region)
              ("C-c C-b" . inf-elixir-send-buffer)
              ("C-M-l" . inf-elixir-clear-repl-buffer)))

;; Eglot configuration.
;; git clonne https://github.com/elixir-lsp/elixir-ls.git
;; cd elixir-ls
;; mix deps.get
;; MIX_ENV=prod mix compile
;; MIX_ENV=prod mix elixir_ls.release -o ~/.local/bin
