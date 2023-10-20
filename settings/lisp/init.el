(require 'package)

(setq package-archives
      '(;; Choose whatever you like.
        ;; --- Default
        ;; ("gnu" . "https://elpa.gnu.org/packages/")
        ;; ("melpa" . "https://melpa.org/packages/")
        ;; --- TUNA mirror
        ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ;; ---
        ))

;; Set load path.
(add-to-list 'load-path (locate-user-emacs-file "settings/site-lisp/"))
(add-to-list 'load-path "~/.emacs.d/settings/site-lisp/ebuild-mode/")
(add-to-list 'load-path "~/.emacs.d/settings/lisp/")

;; Load settings.
;; Always load prelude first.
(load "prelude")

;; Load other modules - order does not matter.
(mapcar (lambda (module) (load module))
        '("dev"
          "dev-erlang"
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
          "display"
          "editing"
          "email"
          "file-directory"
          "interaction"
          "keymap"
          "org"
          "tools"))

;; Start Emacs server.
(server-start)
