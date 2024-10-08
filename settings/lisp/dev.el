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

  :config
  (defun expand-yasnippet-or-dabbrev ()
    (interactive)
    (unless (yas-expand)
      (dabbrev-completion)))

  :bind
  (:map yas-minor-mode-map
        ("C-c" . nil)
        ("M-/" . expand-yasnippet-or-dabbrev))
  
  :custom
  (yas-snippet-dirs (list (locate-user-data-file "snippets")))

  :config
  (yas-global-mode 1))

(use-package consult-yasnippet
  :after (consult yasnippet))

(use-package dabbrev
  :custom
  (dabbrev-case-fold-search nil))

;; ============================================================
;;  Code Completion
;; ============================================================

(use-package corfu
  :config
  (global-corfu-mode)

  :custom
  ;; Enable cycling for `corfu-next/previous'
  (corfu-cycle t)

  ;; Enable auto completion
  (corfu-auto t)

  ;; Make it fast!
  (corfu-auto-delay 0.1)

  ;; How many candidates to show.
  (corfu-count 20))

(use-package corfu-info
  :after corfu)

;; Display more information of completion candidates.
(use-package corfu-popupinfo
  :after corfu-info

  :config
  (corfu-popupinfo-mode)
  
  :custom
  (corfu-popupinfo-delay '(0.5 . 0.2)))

(use-package nerd-icons-corfu
  :after corfu

  :init
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; ============================================================
;;  Hide Show
;; ============================================================

(use-package hideshow
  :hook
  (prog-mode . hs-minor-mode)
  
  :bind (:map hs-minor-mode-map
              ("C-c" . nil)))

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

;; ============================================================
;;  Tree-sitter
;; ============================================================

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

;; ============================================================
;;  LSP
;; ============================================================

(use-package eglog
  :preface
  (defun eglot-setup ()
    (eglot-inlay-hints-mode -1))

  :bind
  (:map eglot-mode-map
        ("M-]" . eglot-inlay-hints-mode)
        ("C-]" . eglot-code-actions))

  :hook
  (eglot-managed-mode . eglot-setup)

  :custom
  (eglot-confirm-server-initiated-edits nil))

;; ============================================================
;;  Compilation
;; ============================================================

(defun compile-dwim (&optional prefix)
  (interactive "P")
  (if prefix
      (call-interactively #'compile)
    (recompile)))
