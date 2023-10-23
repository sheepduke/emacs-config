;; ============================================================
;;  Git
;; ============================================================

;; It's Magit! Git inside Emacs.
(use-package magit
  :demand t
  :hook (git-commit-mode . flyspell-mode))

;; ============================================================
;;  Code Snippet
;; ============================================================

(use-package yasnippet
  :demand t

  :bind
  (:map yas-minor-mode-map
        ("M-/" . yas-expand))

  :custom
  (yas-snippet-dirs (list (locate-user-data-file "snippets")))

  :config
  (yas-global-mode 1))

(use-package consult-yasnippet
  :after (consult yasnippet))

;; ============================================================
;;  Code Completion
;; ============================================================

(use-package company
  :bind
  (:map company-mode-map
        ("<tab>" . company-indent-or-complete-common))

  :hook
  ;; Enable company-mode for all programming languages.
  (prog-mode . company-mode)

  :delight " CO"

  :custom
  ;; Make company mode complete immediately.
  (company-idle-delay 0))

(use-package company-quickhelp
  :after company

  :config
  (company-quickhelp-mode 1)

  :custom
  (company-quickhelp-delay 0))

(use-package consult-company
  :after (consult company)
  
  :bind
  (:map company-active-map
        ("C-i" . consult-company)))

;; ============================================================
;;  Hide Show
;; ============================================================

(use-package hideshow
  :hook
  (prog-mode . hs-minor-mode)
  
  :bind (:map hs-minor-mode-map
              ("C-c h s" . hs-show-all)
              ("C-c h h" . hs-hide-all)
              ("C-c h i" . hs-toggle-hiding)))

;;; Highlight nested parens in different colors.
(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package comint-mode
  :bind (:map comint-mode-map
              ("C-M-l" . comint-clear-buffer)))

(use-package prog-mode
  :bind
  (:map prog-mode-map
        ("<return>" . smart-newline)))

(use-package emacs
  :hook
  (text-mode . display-line-numbers-mode)
  (prog-mode . display-line-numbers-mode))

(use-package treesit
  :custom
  (treesit-font-lock-level 4)
  (treesit-language-source-alist
   '((bash . ("https://github.com/tree-sitter/tree-sitter-bash"))
     (c . ("https://github.com/tree-sitter/tree-sitter-c"))
     (cpp . ("https://github.com/tree-sitter/tree-sitter-cpp"))
     (css . ("https://github.com/tree-sitter/tree-sitter-css"))
     (cmake . ("https://github.com/uyha/tree-sitter-cmake"))
     (csharp . ("https://github.com/tree-sitter/tree-sitter-c-sharp.git"))
     (dockerfile . ("https://github.com/camdencheek/tree-sitter-dockerfile"))
     (elisp . ("https://github.com/Wilfred/tree-sitter-elisp"))
     (go . ("https://github.com/tree-sitter/tree-sitter-go"))
     (gomod . ("https://github.com/camdencheek/tree-sitter-go-mod.git"))
     (html . ("https://github.com/tree-sitter/tree-sitter-html"))
     (java . ("https://github.com/tree-sitter/tree-sitter-java.git"))
     (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript"))
     (json . ("https://github.com/tree-sitter/tree-sitter-json"))
     (lua . ("https://github.com/Azganoth/tree-sitter-lua"))
     (make . ("https://github.com/alemuller/tree-sitter-make"))
     (markdown . ("https://github.com/MDeiml/tree-sitter-markdown" nil "tree-sitter-markdown/src"))
     (ocaml . ("https://github.com/tree-sitter/tree-sitter-ocaml" nil "ocaml/src"))
     (org . ("https://github.com/milisims/tree-sitter-org"))
     (python . ("https://github.com/tree-sitter/tree-sitter-python"))
     (php . ("https://github.com/tree-sitter/tree-sitter-php"))
     (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" nil "typescript/src"))
     (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" nil "tsx/src"))
     (ruby . ("https://github.com/tree-sitter/tree-sitter-ruby"))
     (rust . ("https://github.com/tree-sitter/tree-sitter-rust"))
     (sql . ("https://github.com/m-novikov/tree-sitter-sql"))
     (vue . ("https://github.com/merico-dev/tree-sitter-vue"))
     (yaml . ("https://github.com/ikatyang/tree-sitter-yaml"))
     (toml . ("https://github.com/tree-sitter/tree-sitter-toml"))
     (zig . ("https://github.com/GrayJack/tree-sitter-zig")))))

(use-package eglog
  :preface
  (defun eglot-setup ()
    (eglot-inlay-hints-mode -1))

  :bind
  ("M-[" . eglot-inlay-hints-mode)
  ("M-]" . eglot-code-actions)
  ("C-]" . eglot-find-typeDefinition)

  :hook
  (eglot-managed-mode . eglot-setup))
