(setq package-selected-packages
      '(ace-window ahk-mode bbdb cal-china-x calfw calfw-org cargo cider
                   consult-yasnippet corfu csproj-mode delight
                   dockerfile-mode dune eglot-fsharp elixir-mode
                   embark-consult emmet-mode emms fsharp-mode
                   haskell-mode indent-guide inf-elixir js-comint
                   js2-mode kotlin-mode magit major-mode-hydra marginalia
                   markdown-toc multiple-cursors nameless
                   nerd-icons-corfu nerd-icons-dired notmuch nov
                   orderless org-bullets org-journal org-pomodoro
                   org-super-agenda ormolu paredit pdf-tools perspective
                   poly-markdown powershell rainbow-delimiters restclient
                   rime sbt-mode scala-repl scala-ts-mode sdcv shackle
                   sly-repl-ansi-color systemd toc-org ts-comint tuareg
                   typescript-mode undo-tree vertico-posframe w3m
                   web-mode which-key yaml-mode))

;; Set load path.
(add-to-list 'load-path "~/.emacs.d/settings/site-lisp/")
(add-to-list 'load-path "~/.emacs.d/settings/site-lisp/ebuild-mode/")
(add-to-list 'load-path "~/.emacs.d/settings/lisp/")

;; Load settings.
;; Always load prelude first.
(load "prelude")

;; Load other modules - order does not matter.
(mapcar (lambda (module) (load module))
        '("display"
          "editing"
          "file-directory"
          "interaction"
          "org-mode"
          "tools"
          "dev"
          "dev-elixir"
          "dev-dotnet"
          "dev-haskell"
          "dev-lisp"
          "dev-markdown"
          "dev-misc"
          "dev-ocaml"
          "dev-python"
          "dev-ruby"
          "dev-rust"
          "dev-scala"
          "dev-web"
          "email"
          "keymap"))

;; Start Emacs server.
(server-start)

