;;; Put the language server in the PATH to let it auto configure.
;;; 
;;; Git repository:
;;; https://github.com/elixir-lsp/elixir-ls.git
;;;
;;; git clonne https://github.com/elixir-lsp/elixir-ls.git
;;; cd elixir-ls
;;; mix deps.get
;;; MIX_ENV=prod mix compile
;;; MIX_ENV=prod mix elixir_ls.release -o ~/software/elixir_ls
;;; ln -s ~/software/elixir_ls/language_server.sh ~/bin/
;;;
;;; And run the language_server program first.


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

  (require 'inf-elixir)

  :hook
  (elixir-mode . elixir-mode-setup-buffer))

(use-package inf-elixir
  :ensure

  :after elixir-mode

  :preface
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

  (defun inf-elixir-run-unit-tests ()
    (interactive)
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
              ("C-c C-p" . inf-elixir-smart-repl)
              ("C-c C-c" . inf-elixir-send-dwim)
              ("C-c C-k" . inf-elixir-send-buffer)
              ("C-c C-l" . inf-elixir-reload-module)
              ("C-c C-u" . inf-elixir-run-unit-tests)
              ("C-M-l" . inf-elixir-clear-repl-buffer)))
