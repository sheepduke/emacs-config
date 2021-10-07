;;; Package --- Settings for each programming language

;;; Commentary:

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            C/C++                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package cc-mode
  :ensure t

  :config
  (defun c/c++-mode-setup-company ()
	(company-mode 1)
	(make-local-variable 'company-backends)
	(setq company-backends
		  '((company-dabbrev-code company-gtags company-etags company-keywords
								  :with company-yasnippet)
			(company-c-headers :with company-yasnippet)
			(company-capf :with company-yasnippet)))
	(setq comment-start "//")
	(setq comment-end ""))

  ;; Add personal style.
  (c-add-style "sheep"
               '("stroustrup"
                 (c-basic-offset . 2)))

  ;; Use "sheep" coding style.
  (setq c-default-style "sheep")

  :mode ("\\.tpp\\'" . c++-mode)

  :hook
  (c++-mode . ggtags-mode)
  (c++-mode . c/c++-mode-setup-company)
  (c-mode . c/c++-mode-setup-company)
  
  :bind (:map c++-mode-map
              ("C-c C-v" . compile)
              ("C-c C-b" . recompile)
              :map c-mode-map
              ("C-c C-v" . compile)
              ("C-c C-b" . recompile)))


(use-package cmake-mode
  :ensure t
  :mode "CMakeLists\\.txt\\'"
  :mode "\\.cmake\\'")


;; Add completion for C headers.
(use-package company-c-headers
  :ensure t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Java                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Yes, it is strange: java-mode is defined in cc-mode module.
(use-package cc-mode
  :hook
  (java-mode . java-mode-setup)

  :config
  (defun java-mode-setup ()
    "Setup Java mode."
    (setq fill-column 120)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Kotlin                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package kotlin-mode
  :ensure t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Erlang                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package erlang
  :ensure t

  :config
  (require 'erlang-start)

  :bind (:map erlang-mode-map
              ("<f5>" . recompile)
              ("C-<f5>" . compile))

  :custom
  (erlang-indent-level 2))


(use-package company-erlang
  :ensure
  
  :hook
  (erlang-mode . company-mode)
  (erlang-mode . company-erlang-init))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Elixir                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package alchemist
  :ensure t
  :after elixir-mode

  :commands (alchemist-iex-clear-buffer)

  :config
  (defun alchemist-iex-send-buffer ()
    "Send current buffer."
    (interactive)
    (alchemist-iex-send-region (point-min) (point-max)))

  (defun alchemist-run-iex-dwim ()
    "Run IEx with or without mix accordingly."
    (interactive)
    (let ((result (alchemist-iex-project-run)))
      (unless (bufferp result)
        (alchemist-iex-run))))

  (defun alchemist-clear-buffer-anywhere ()
    "Clear IEx buffer from anywhere."
    (interactive)
    (with-current-buffer alchemist-iex-buffer
      (alchemist-iex-clear-buffer)))

  :bind (:map alchemist-mode-map
              ("C-c C-k" . alchemist-iex-compile-this-buffer)
              ("C-c C-b" . alchemist-iex-send-buffer)
              ("C-c C-r" . alchemist-iex-send-region)
              ("C-x C-e" . alchemist-iex-send-last-sexp)
              ("C-c C-c" . alchemist-iex-send-current-line)
              ("C-c C-p" . alchemist-run-iex-dwim)
              ("C-M-l" . alchemist-clear-buffer-anywhere)
              ("M-P" . nil)
              ("M-N" . nil)
              ("M-." . nil)
              ("C-c a" . nil))

  :hook
  (elixir-mode . alchemist-mode)
  (alchemist-mode . flyspell-prog-mode))


(use-package eglot
  :ensure t

  :commands (eglot-format-buffer)

  :config
  (defun elixir-get-lsp-server-path ()
    "Get LSP server path."
    (format "%s/software/elixir-ls/language_server.%s"
            (getenv "HOME")
            (if (windows?) "bat" "sh")))

  (defun eglot-format-elixir-buffer ()
    "Sort the buffer using eglot when in elixir mode."
    (interactive)
    (when (member major-mode '(elixir-mode))
      (eglot-format-buffer)))

  (defun eglot-find-mix-project (dir)
    "Try to locate a Elixir project root by 'mix.exs' above DIR."
    (when (or (string-suffix-p ".ex" (buffer-file-name))
              (string-suffix-p ".exs" (buffer-file-name)))
      (message "Finding ")
      (let ((mix_root (locate-dominating-file dir "mix.exs")))
        (message "Found Elixir project root in '%s' starting from '%s'" mix_root dir)
        (if (stringp mix_root) `(transient . ,mix_root) nil))))

  (add-to-list 'eglot-server-programs
               `(elixir-mode ,(elixir-get-lsp-server-path)))

  (add-hook 'project-find-functions 'eglot-find-mix-project)

  :hook
  (elixir-mode . eglot-ensure)
  (before-save . eglot-format-elixir-buffer)

  :bind (:map eglot-mode-map
              ("C-c C-d" . eldoc-doc-buffer)))


(use-package elixir-yasnippets
  :ensure t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Rust                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package rust-mode
  :ensure t

  :config
  (defun rust-mode-setup ()
    "Setup rust mode."
    (set (make-local-variable 'compile-command)
         "cargo test"))

  :hook
  (rust-mode . rust-mode-setup)

  :bind
  (:map rust-mode-map
        ("C-c C-b" . recompile)
        ("C-c C-v" . compile))

  :custom
  ;; Format rust code before save.
  (rust-format-on-save t))


(use-package cargo
  :ensure t
  
  :hook
  (rust-mode . cargo-minor-mode))


(use-package racer
  :ensure t
  
  :hook
  (rust-mode . racer-mode)
  (rust-mode . eldoc-mode))


(use-package flycheck-rust
  :ensure t
  
  :hook
  (flycheck-mode . flycheck-rust-setup))


(use-package company-racer
  :ensure t

  :hook
  (rust-mode . company-racer-setup)

  :config
  (defun company-racer-setup ()
    (make-local-variable 'company-backends)
    (setq company-backends '((company-racer :with company-yasnippet)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                       Common Lisp                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package sly
  :ensure t

  :functions (sly-mrepl-clear-repl)

  :config
  (defun sly-repl-clear-buffer-anywhere ()
    "Clear Sly buffer from anywhere."
    (interactive)
    (dolist (buffer (cl-remove-if-not (lambda (buffer)
                                        (string-prefix-p "*sly-mrepl for"
                                                         (buffer-name buffer)))
                                      (buffer-list)))
      (with-current-buffer buffer
        (sly-mrepl-clear-repl)
        (goto-char (point-max)))))

  ;; Set the location of HyperSpec.
  (load "~/.roswell/lisp/quicklisp/clhs-use-local.el" t)

  :custom
  ;; set common lisp REPL
  (inferior-lisp-program "ros run")

  ;; Use classic completion style.
  (sly-complete-symbol-function 'sly-flex-completions)

  :hook (lisp-mode . sly-editing-mode)

  :bind
  (:map sly-mode-map
        ("C-c C-k" . sly-interrupt)
        ("C-c C-b" . sly-eval-buffer)
        ("C-c C-l" . sly-eval-defun)
        ("C-c C-p" . sly-eval-print-last-expression)
        ("C-c X" . sly-export-class)
        ("C-c C-d d" . hyperspec-lookup)
        ("C-M-l" . sly-repl-clear-buffer-anywhere)))


(use-package sly-repl-ansi-color
  :ensure t

  :config
  (push 'sly-repl-ansi-color sly-contribs))


(use-package lispy
  :ensure t

  :config
  (defun lispy--eval-lisp-fix (str)
    (let ((result (sly-interactive-eval str)))
      (concat (propertize result 'face 'font-lock-string-face)
              "\n\n"
              result)))
  (advice-add 'lispy--eval-lisp :override #'lispy--eval-lisp-fix)
  (setq lispy-colon-p nil)

  :hook ((emacs-lisp-mode lisp-mode) . lispy-mode)

  :bind (:map lispy-mode-map
              ("M-o" . nil)
              ("M-i" . nil))

  :custom
  (lispy-use-sly t))

(use-package common-lisp-snippets
  :ensure t)

(use-package cl-easy-defclass
  :bind (:map lisp-mode-map
              ("C-i" . lisp-import-symbol-and-defpackage)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                        Emacs Lisp                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package elisp-mode
  :hook
  (emacs-lisp-mode . eldoc-mode)

  :bind
  (:map emacs-lisp-mode-map
        ("C-c C-r" . eval-region)
        ("C-c C-b" . eval-buffer)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Clojure                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package cider
  :ensure t

  :config
  (defun cider-eval-buffer-content ()
    "Eval buffer content without having to save it."
    (interactive)
    (cider-eval-region (point-min) (point-max)))

  :hook (clojure-mode . cider-mode)

  :bind ((:map cider-mode-map
               ("C-c C-b" . cider-eval-buffer-content)
               ("C-c C-r" . cider-eval-region)
               ("C-c C-l" . cider-eval-defun-at-point)
               ("C-c C-k" . cider-interrupt)
               ("C-M-l" . cider-find-and-clear-repl-output))
         (:map cider-repl-mode-map
               ("C-M-l" . cider-repl-clear-buffer))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Racket                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package geiser
  :ensure t

  :hook
  (geiser-mode . disable-company-quickhelp-mode)
  (scheme-mode . geiser-mode)

  :custom
  ;; Set racket to be the only implementation.
  (geiser-active-implementations '(racket))
  ;; Don't record duplicated command in history.
  (geiser-repl-history-no-dups-p t))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                           Haskell                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package haskell-mode
  :ensure t
  
  :defines (interactive-haskell-mode-map
            haskell-interactive-mode-map)
  :functions (haskell-session-interactive-buffer
              haskell-interactive-handle-expr
              haskell-interactive-copy-to-prompt)
  
  :config
  (defun interactive-haskell-do-eval ()
    "Evaluate the current expression in Haskell REPL."
    (with-current-buffer (haskell-session-interactive-buffer (haskell-session))
      (haskell-interactive-handle-expr)))

  (defun interactive-haskell-eval-current-line ()
    "Evaluate current line."
    (interactive)
    (haskell-interactive-copy-to-prompt)
    (interactive-haskell-do-eval))

  :hook (haskell-mode . interactive-haskell-mode)

  :bind ((:map interactive-haskell-mode-map
               ("C-c C-c" . interactive-haskell-eval-current-line)
               ("C-M-l" . haskell-interactive-mode-clear))
         (:map haskell-interactive-mode-map
               ("C-c C-b" . haskell-interactive-switch-back)
               ("C-M-l" . haskell-interactive-mode-clear))))



(use-package hindent
  :ensure t

  :config
  (defun my-setup-hindent-mode ()
    "Setup HIndent mode."
    (hindent-mode 1))

  :hook (haskell-mode . my-setup-hindent-mode)

  :custom
  (hindent-reformat-buffer-on-save t))


;; FlyCheck setup.
;; 
(use-package flycheck-haskell
  :ensure t

  :hook
  (haskell-mode . my-flycheck-haskell-setup)

  :config
  (defun my-flycheck-haskell-setup ()
    "Setup FlyCheck mode for Haskell."
    (flycheck-haskell-setup)
    (setq flycheck-check-syntax-automatically '(idle-change))
    (setq flycheck-idle-change-delay 1)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               OCaml                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Major mode for editing OCaml files.
(use-package tuareg
  :ensure t
  
  :config
  (defun tuareg-insert-comment-block ()
    (interactive)
    (let* ((comment (read-string "Comment: "))
           (comment-length (length comment))
           (comment-line (make-string 70 ?*))
           (space-before-comment (/ (- 66 comment-length) 2))
           (space-after-comment (- 66 comment-length space-before-comment)))
      (insert (format "(%s\n **%s**\n %s)"
                      comment-line
                      (concat (make-string space-before-comment ?\s)
                              comment
                              (make-string space-after-comment ?\s))
                      comment-line)))))


;;; Auto completion and more.
(use-package merlin
  :ensure t
  :after tuareg

  :hook (tuareg-mode . merlin-mode))


;; Consistent indentation.
(use-package ocp-indent
  :ensure t
  :after tuareg

  :commands (ocp-indent-buffer)

  :config
  (defun ocp-indent-tuareg-buffer ()
    "Indent buffer only when it is in tuareg mode."
    (interactive)
    (when (equal major-mode 'tuareg-mode)
      (ocp-indent-buffer)))

  :hook
  (tuareg-mode . ocp-setup-indent)
  (before-save . ocp-indent-tuareg-buffer))


;;; Type tips.
(use-package merlin-eldoc
  :ensure t
  :after merlin

  :hook (tuareg-mode . merlin-eldoc-setup))


;;; Build system.
(use-package dune
  :ensure t)


(use-package utop
  :ensure t
  :after tuareg

  :hook (tuareg-mode . utop-minor-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                             Julia                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package julia-mode
  :ensure t

  :config
  (defun julia-mode-setup ()
    "Setup Julia mode."
    ;; Set fill column.
    (setq fill-column 92)
    ;; Set company source.
    (make-local-variable 'company-backends)
    (setq company-backends
          '(company-dabbrev :with 'company-yasnippet)))

  :hook (julia-mode . julia-mode-setup)

  :custom
  ;; Set indentation level.
  (julia-indent-offset 4))

  
(use-package julia-repl
  :ensure t
  :after julia-mode
  :commands (julia-repl-send-line)

  :config
  (defun julia-repl-send-buffer-content ()
    "Send buffer to Julia REPL."
    (interactive)
    (save-excursion
      (goto-char (point-min))
      (set-mark-command nil)
      (goto-char (point-max))
      (julia-repl-send-region-or-line)))

  (defun julia-repl-send-line-content ()
    "Send line to Julia REPL."
    (interactive)
    (save-excursion
      (julia-repl-send-line)))

  (defun julia-newline-with-end ()
    "Insert an end keyword and move cursor to the next line."
    (interactive)
    (newline-and-indent)
    (newline)
    (insert "end")
    (indent-region (line-beginning-position) (line-end-position))
    (forward-line -1)
    (end-of-line))

  :bind (:map julia-mode-map
              ("C-<return>" . julia-newline-with-end)
              ("C-c r" . julia-repl-send-region-or-line)
              ("C-c b" . julia-repl-send-buffer-content)
              ("C-c C-c" . julia-repl-send-line-content)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                             Web                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package web-mode
  :ensure t

  :mode "\\.html\\'"
  :mode "\\.css\\'"
  :mode "\\.jsp\\'"
  :mode "\\.vue\\'"

  :config
  (defun web-mode-setup ()
    (setq web-mode-comment-formats
          '(("java" . "/*")
            ("javascript" . "//")
            ("php" . "/*")
            ("css" . "/*"))))

  (flycheck-add-mode 'javascript-eslint 'web-mode)

  :hook
  (web-mode . web-mode-setup)

  :custom
  ;; Set offset to 2.
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2)
  (web-mode-indent-style 2)

  ;; Set padding to 0.
  (web-mode-script-padding 0)
  (web-mode-part-padding 0)
  (web-mode-style-padding 0)
  (css-indent-offset 2))


(use-package emmet-mode
  :ensure t

  :hook
  (web-mode . emmet-mode)

  :bind (:map emmet-mode-keymap
              ("C-j" . emmet-expand-line)
              ("C-M-j" . emmet-expand-yas)))


(use-package company-web
  :ensure t)


(use-package rainbow-mode
  :ensure t
  :after web-mode

  :hook (web-mode . rainbow-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                         JavaScript                           ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package js2-mode
  :ensure t

  :config
  (defun setup-js2-mode ()
    (when (equal major-mode 'js-mode)
      (js2-minor-mode)))

  :hook (js-mode . setup-js2-mode)

  :custom
  ;; Set indent to 2.
  (js-indent-level 2)
  ;; Do not warn me for missing ';'.
  (js2-strict-missing-semi-warning nil)

  (flycheck-disabled-checkers (append flycheck-disabled-checkers
                                      '(javascript-jshint json-jsonlist))))


(use-package typescript-mode
  :ensure t
  
  :custom
  (typescript-indent-level 2))


;; IDE for JavaScript.
(use-package tide
  :ensure t

  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (js-mode . tide-setup)
         (js-mode . tide-hl-identifier-mode)))


;; REPL for JavaScript.
(use-package js-comint
  :ensure t

  :bind (:map js-mode-map
              ("C-x C-e" . js-comint-send-last-sexp)
              ("C-c C-r" . js-comint-send-region)
              ("C-c C-b" . js-comint-send-buffer)
              ("C-M-l" . js-comint-clear))

  :custom
  (js-comint-prompt "==> "))


;; REPL for TypeScript.
;; First install the REPL via ~npm install -g tsun~.
(use-package ts-comint
  :ensure t
  
  :config
  (defun ts-comint-clear ()
    "Clear the TypeScript REPL buffer."
    (interactive)
    (with-current-buffer ts-comint-buffer
      (erase-buffer)))

  :bind (:map typescript-mode-map
              ("C-x C-e" . ts-send-last-sexp)
              ("C-c C-r" . ts-send-region)
              ("C-c C-b" . ts-send-buffer)
              ("C-M-l" . ts-comint-clear)))


(use-package flycheck
  :ensure t

  :config
  (defun flycheck-use-local-eslint ()
    (let* ((root (locate-dominating-file
                  (or (buffer-file-name) default-directory)
                  "node_modules"))
           (eslint (and root
                        (expand-file-name "node_modules/eslint/bin/eslint.js"
                                          root))))
      (when (and eslint (file-executable-p eslint))
        (setq-local flycheck-javascript-eslint-executable eslint))))

  :hook (flycheck-mode . flycheck-use-local-eslint))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Python                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package python
  :ensure t
  
  :custom
  ;; Use Python 3 instead of Python 2.
  (python-shell-interpreter "python3")
  (flycheck-python-pycompile-executable "python3"))


;; For setup elpy, run:
;; pip install jedi flake8 autopep8
(use-package elpy
  :ensure t
  :after python

  :config
  (defun elpy-shell-send-current-line ()
    "Send current line to Python shell."
    (interactive)
    (python-shell-send-string (thing-at-point 'line)))

  (elpy-enable)

  :hook
  (elpy-mode . (lambda () (highlight-indentation-mode -1)))

  :bind
  (:map elpy-mode-map
        ("C-c C-p" . run-python)
        ("C-c C-r" . 'elpy-shell-send-region-or-buffer)
        ("C-c C-b" . elpy-shell-send-region-or-buffer)
        ("C-c C-c" . elpy-shell-send-current-line))

  :custom
  (elpy-rpc-python-command "python3"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                             Ruby                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ruby-mode
  :ensure t

  :config
  (defun ruby-insert-end ()
    "Insert `end' accordingly."
    (interactive)
    (let ((text (save-excursion
                  (forward-line 0)
                  (if (looking-at "^[ \t]*$")
                      "end"
                    (if (looking-at ".*{[^}]*$")
                        "\n}"
                      "\nend")))))
      (insert text)
      (indent-region (line-beginning-position)
                     (line-end-position))))

  :bind (:map ruby-mode-map
              ("C-c C-f" . ruby-insert-end)
              ("C-c b" . ruby-send-buffer)))


(use-package inf-ruby
  :ensure t

  :config
  (defun inf-ruby-restart (&optional impl)
    (interactive)
    (catch 'return
      ;; If ruby buffer does not exist, just start a new one.
      (unless (and inf-ruby-buffer
                   (buffer-name inf-ruby-buffer))
        (inf-ruby)
        (throw 'return nil))
      ;; If ruby buffer exists, kill current ruby process and
      ;; start a new one in same window position.
      (with-selected-window (get-buffer-window inf-ruby-buffer)
        (kill-buffer inf-ruby-buffer)
        (setq inf-ruby-buffer nil)
        (let ((config (current-window-configuration)))
          (inf-ruby)
          (set-window-configuration config))
        (switch-to-buffer inf-ruby-buffer)))
    (message "inf-ruby process restarted. Happy hacking!"))

  :hook (ruby-mode . inf-ruby-minor-mode)

  :bind (:map inf-ruby-minor-mode-map
              ("C-c C-s" . inf-ruby-restart)))


(use-package company-inf-ruby
  :ensure t
  
  :config
  (add-to-list 'company-backends 'company-inf-ruby)

  :hook
  (inf-ruby-mode . company-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                              Go                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package go-mode
  :ensure t
  :commands (gofmt go-remove-unused-imports)
  
  :config
  (defun optimize-and-save ()
    (interactive)
    (gofmt)
    (save-buffer-readonly)
    (go-remove-unused-imports nil)
    (save-buffer-readonly))

  :bind (:map go-mode-map
              ("C-x C-s" . optimize-and-save)))


(use-package go-eldoc
  :ensure t
  :after go-mode

  :hook (go-mode . go-eldoc-setup))


(use-package company-go
  :ensure t
  :after go-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            LaTeX                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package latex
  :config
  (defun LaTeX-mode-setup ()
    "Hook function for LaTeX mode."
    ;; Enable auto-fill.
    (auto-fill-mode)
    ;; Disable flycheck mode.
    (flycheck-mode -1)
    ;; Enable toc viewer.
    (turn-on-reftex)
    ;; Stop using default completion.
    (setq completion-at-point-functions 'complete-or-indent))

  :hook (LaTeX-mode . LaTeX-mode-setup)

  :custom
  ;; Add Chinese support.
  (pdf-latex-command "xelatex")
  ;; Automatically save the style.
  (TeX-auto-save t)
  ;; Parse file after loading.
  (TeX-parse-self t)
  ;; Don't ask me if I want to save.
  (TeX-save-query nil)
  ;; Enable all the features of LaTeX mode.
  (LaTeX-section-hook '(LaTeX-section-heading
                        LaTeX-section-title
                        LaTeX-section-toc
                        LaTeX-section-section
                        LaTeX-section-label)))


(use-package latex-preview-pane
  :ensure t

  :bind (:map latex-preview-pane-mode-map
              ("M-P" . nil))

  :delight " Pane")


(use-package reftex-toc
  :ensure t

  :bind (:map reftex-toc-mode-map
              ("q" . delete-window))

  :delight (reftex "")

  :custom
  ;; Enable on-the-fly table-of-content.
  (reftex-plug-into-AUCTeX t))


(use-package company-auctex
  :ensure t

  :custom
  (defun LaTeX-mode-setup-company ()
    (make-local-variable 'company-backends)
    (setq company-backends '(company-dabbrev company-auctex-bibs
                                             (company-auctex-macros
                                              company-auctex-symbols
                                              company-auctex-environments)))
    ;; Disable idle completion.
    (set (make-local-variable 'company-idle-delay) nil))

  :hook (LaTeX-mode . LaTeX-mode-setup-company))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                           Markdown                           ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package markdown-mode
  :ensure t
  :commands (w3m-reload-all-pages)
  
  :config
  (defun markdown-mode-setup ()
    (add-hook 'after-save-hook 'markdown-live-preview-w3m-reload))

  (defun markdown-live-preview-window-w3m (file)
    "Use w3m to preview Markdown buffer."
    (cond
     ((require 'w3m nil t)
      (w3m-find-file file)
      (get-buffer "*w3m*"))
     (t (error "Package w3m not available"))))

  (defun markdown-live-preview-w3m-reload ()
    "Reload generated HTML."
    (when (and markdown-live-preview-mode
               (get-buffer "*w3m*"))
      (w3m-reload-all-pages)))

  :custom
  ;; Use pandoc as markdown generator.
  (markdown-command "pandoc")
  
  ;; Use w3m to preview markdown.
  (markdown-live-preview-window-function 'markdown-live-preview-window-w3m)

  :hook ((markdown-mode . flyspell-mode)
         (markdown-mode . toggle-word-wrap)
         (markdown-mode . markdown-mode-setup)))


(use-package poly-markdown
  :ensure t

  :config
  (remove-hook 'markdown-mode-hook 'poly-markdown-mode))


(use-package flymd
  :ensure t
  :after markdown-mode

  :custom
  (flymd-output-directory "/tmp/"))

(use-package markdown-toc
  :ensure t
  :after markdown-mode

  :bind (:map markdown-mode-map
              ("C-c =" . markdown-toc-generate-or-refresh-toc)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Misc                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package nxml-mode
  :hook (nxml-mode . highlight-indent-guides-mode))


(use-package yaml-mode
  :ensure t

  :mode "\\.yml\\'"
  :mode "\\.yml.j2\\'"

  :hook (yaml-mode . highlight-indent-guides-mode)

  :bind (:map yaml-mode-map
              ("<return>" . newline-smart-comment)))


(use-package conf-mode
  :ensure t

  :bind (:map conf-mode-map
              ("<return>" . newline-smart-comment)))

(use-package json-mode :ensure)

(use-package toml-mode :ensure)

(use-package powershell :ensure)

(use-package systemd :ensure)

(use-package csharp-mode :ensure)


;;; d2-dev-lang.el ends here
