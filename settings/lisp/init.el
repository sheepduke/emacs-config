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
