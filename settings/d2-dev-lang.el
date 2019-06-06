;;; Package --- Settings for each programming language

;;; Commentary:

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Arduino                           ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package arduino-mode
  :mode "\\.ino"
  
  :preface
  (defun arduino-mode-setup ()
	(semantic-mode 0)
	(set (make-local-variable 'compile-command)
		 "make -j4 -l5 && make upload")
	(make-local-variable 'company-backends)
	(setq company-backends
		  '((company-dabbrev company-gtags company-etags company-keywords
							 :with company-yasnippet)
			(company-c-headers :with company-yasnippet)
			(company-capf :with company-yasnippet))))

  :hook
  (arduino-mode . arduino-mode-setup))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            C/C++                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package cc-mode
  :ensure

  :preface
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

  :init
  ;; Use 'gnu' coding style.
  (setq c-default-style "gnu")

  :bind
  (:map c++-mode-map
		("C-c C-v" . compile)
		("C-c C-b" . recompile)
		:map c-mode-map
		("C-c C-v" . compile)
		("C-c C-b" . recompile))

  :config
  (add-to-list 'auto-mode-alist '("\\.tpp\\'" . c++-mode))

  :hook
  (c++-mode . ggtags-mode)
  (c++-mode . c/c++-mode-setup-company)
  (c-mode . c/c++-mode-setup-company))

(use-package cmake-mode
  :ensure
  :mode "CMakeLists\\.txt\\'"
  :mode "\\.cmake\\'")

;; Add completion for C headers.
(use-package company-c-headers)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Java                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package cc-mode
  :preface
  (defun java-mode-setup ()
    "Setup Java mode."
    (setq fill-column 120))
  
  :hook
  (java-mode . java-mode-setup))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Kotlin                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package kotlin-mode
  :ensure)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Erlang                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package erlang
  :ensure
  
  :init
  ;; Set indentation level.
  (setq erlang-indent-level 2)
  (require 'erlang-start)

  :bind
  (:map erlang-mode-map
        ("<f5>" . recompile)
        ("C-<f5>" . compile)))

(use-package company-erlang
  :ensure
  
  :hook
  (erlang-mode . company-mode)
  (erlang-mode . company-erlang-init))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Elixir                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package alchemist
  :ensure
  :after elixir-mode

  :preface
  (defun elixir-insert-end ()
	"Insert END accordingly."
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

  (defun alchemist-iex-send-buffer ()
    "Send current buffer."
    (interactive)
    (alchemist-iex-send-region (point-min) (point-max)))

  (defun alchemist-run-iex-dwim ()
    "Run iex with or without mix accordingly."
    (interactive)
    (let ((result (alchemist-iex-project-run)))
      (unless (bufferp result)
        (alchemist-iex-run))))

  :bind
  (:map alchemist-mode-map
        ("C-c b" . alchemist-iex-send-buffer)
        ("C-c r" . alchemist-iex-send-region)
        ("C-x C-e" . alchemist-iex-send-last-sexp)
        ("C-c C-c" . alchemist-iex-send-current-line)
        ("C-c C-f" . elixir-insert-end)
        ("C-c C-p" . alchemist-run-iex-dwim)
        ("M-P" . nil)
        ("M-N" . nil)
        ("C-c a" . nil))

  :hook
  (elixir-mode . alchemist-mode)
  (alchemist-mode . company-mode)
  (alchemist-mode . flyspell-prog-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Rust                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package rust-mode
  :ensure
  
  :preface
  (defun rust-mode-setup ()
    "Setup rust mode."
    (set (make-local-variable 'compile-command)
		 "cargo test")
    ;; Disable fci-mode because the use of rustfmt.
    (fci-mode -1))

  :init
  ;; Format rust code before save.
  (setq rust-format-on-save t)

  :bind
  (:map rust-mode-map
        ("C-c C-b" . recompile)
        ("C-c C-v" . compile))

  :hook
  ((rust-mode . rust-mode-setup)))

(use-package cargo
  :ensure
  
  :hook
  (rust-mode . cargo-minor-mode))

(use-package racer
  :ensure
  
  :hook
  (rust-mode . racer-mode)
  (rust-mode . eldoc-mode))

(use-package flycheck-rust
  :ensure
  
  :hook
  (flycheck-mode . flycheck-rust-setup))

(use-package company-racer
  :ensure
  
  :preface
  (defun company-racer-setup ()
	(make-local-variable 'company-backends)
	(setq company-backends '((company-racer :with company-yasnippet))))

  :hook
  (rust-mode . company-racer-setup))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                       Common Lisp                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package slime
  :ensure
  :preface
  (defun setup-slime-mode ()
    ;; Set the line length to 80.
    (setq fill-column 80)
    (ggtags-mode 0))

  (defun slime-repl-clear-buffer-anywhere ()
    "Clear Slime buffer from anywhere."
    (interactive)
    (with-current-buffer "*slime-repl sbcl*"
      (slime-repl-clear-buffer)))

  :init
  ;; set common lisp REPL
  (setq inferior-lisp-program "ros run")
  (require 'slime-autoloads)

  ;; Set the location of HyperSpec.
  (setq common-lisp-hyperspec-root
        (concat "file://"
                (expand-file-name "~/documents/manuals/lisp/HyperSpec/")))

  :bind
  (:map slime-mode-map
        ("C-c C-k" . slime-interrupt)
        ("C-c C-b" . slime-eval-buffer)
        ("C-c C-l" . slime-eval-defun)
        ("C-c C-d d" . hyperspec-lookup)
        ("C-M-l" . slime-repl-clear-buffer-anywhere))
  (:map slime-repl-mode-map
        ("C-M-l" . slime-repl-clear-buffer))

  :config
  (call-when-defined 'slime-setup
                     '(slime-fancy slime-company slime-repl-ansi-color))

  :hook
  (slime-mode . setup-slime-mode)
  (slime-repl-mode . company-mode)
  (slime-repl-mode . slime-repl-ansi-color-mode))

;; Contrib packages must not be loaded manually.
;; SLIME handles them.
(use-package slime-repl-ansi-color
  :ensure)

(use-package slime-company
  :ensure)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                        Emacs Lisp                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package elisp-mode
  :bind
  (:map emacs-lisp-mode-map
        ("C-c C-r" . eval-region)
		("C-c C-b" . eval-buffer))

  :hook
  (emacs-lisp-mode . eldoc-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Clojure                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package cider
  :ensure
  
  :preface
  (defun cider-eval-buffer-content ()
    "Eval buffer content without having to save it."
    (interactive)
    (call-when-defined 'cider-eval-region (point-min) (point-max)))
  
  :bind
  (:map cider-mode-map
        ("C-c b" . cider-eval-buffer-content))
  (:map cider-repl-mode-map
        ("C-M-l" . cider-repl-clear-buffer))

  :hook
  (clojure-mode . cider-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Racket                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package geiser
  :ensure
  
  :init
  ;; Set racket to be the only implementation.
  (setq geiser-active-implementations '(racket))
  ;; Don't record duplicated command in history.
  (setq geiser-repl-history-no-dups-p t)

  :hook
  (geiser-mode . disable-company-quickhelp-mode)
  (scheme-mode . geiser-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                             Julia                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package julia-mode
  :ensure
  
  :preface
  (defun julia-mode-setup ()
    "Setup Julia mode."
    ;; Set fill column.
    (setq fill-column 92)
    ;; Set company source.
    (make-local-variable 'company-backends)
	(setq company-backends
		  '(company-dabbrev :with 'company-yasnippet)))
  :init
  ;; Set indentation level.
  (setq julia-indent-offset 4)

  :hook
  (julia-mode . julia-mode-setup))
  
(use-package julia-repl
  :ensure
  :after julia-mode

  :preface
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
      (call-when-defined 'julia-repl-send-line)))

  (defun julia-newline-with-end ()
    "Insert an end keyword and move cursor to the next line."
    (interactive)
    (newline-and-indent)
    (newline)
    (insert "end")
    (indent-region (line-beginning-position) (line-end-position))
    (forward-line -1)
    (end-of-line))

  :bind
  (:map julia-mode-map
        ("C-<return>" . julia-newline-with-end)
        ("C-c r" . julia-repl-send-region-or-line)
        ("C-c b" . julia-repl-send-buffer-content)
        ("C-c C-c" . julia-repl-send-line-content)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                             Web                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package web-mode
  :ensure
  
  :mode "\\.html\\'"
  :mode "\\.css\\'"
  :mode "\\.jsp\\'"
  :mode "\\.vue\\'"

  :preface
  (defun web-mode-setup ()
    (setq web-mode-comment-formats
          '(("java" . "/*")
            ("javascript" . "//")
            ("php" . "/*")
            ("css" . "/*")))
    (fci-mode 0))

  :init
  ;; Set offset to 2.
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-indent-style 2)
  
  ;; Set padding to 0.
  (setq web-mode-script-padding 0)
  (setq web-mode-part-padding 0)
  (setq web-mode-style-padding 0)
  (setq css-indent-offset 2)

  (flycheck-add-mode 'javascript-eslint 'web-mode)

  :hook
  (web-mode . web-mode-setup))

(use-package emmet-mode
  :ensure

  :bind
  (:map emmet-mode-keymap
        ("C-j" . emmet-expand-line)
        ("C-M-j" . emmet-expand-yas))

  :hook
  (web-mode . emmet-mode))

(use-package company-web
  :ensure)

(use-package rainbow-mode
  :ensure
  :after web-mode
  
  :hook
  (web-mode . rainbow-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                         JavaScript                           ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package js2-mode
  :ensure
  
  :preface
  (defun setup-js2-mode ()
    (when (equal major-mode 'js-mode)
      (call-when-defined 'js2-minor-mode)))

  :init
  ;; Set indent to 2.
  (setq js-indent-level 2)
  ;; Do not warn me for missing ';'.
  (setq js2-strict-missing-semi-warning nil)

  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(javascript-jshint json-jsonlist)))

  :hook
  (js-mode . setup-js2-mode))

(use-package tide
  :ensure

  :hook
  ((typescript-mode . tide-setup)
   (typescript-mode . tide-hl-identifier-mode)
   (js-mode . tide-setup)
   (js-mode . tide-hl-identifier-mode)))

(use-package company-tern
  :ensure)

(use-package flycheck
  :ensure

  :preface
  (defun flycheck-use-local-eslint ()
    (let* ((root (locate-dominating-file
                  (or (buffer-file-name) default-directory)
                  "node_modules"))
           (eslint (and root
                        (expand-file-name "node_modules/eslint/bin/eslint.js"
                                          root))))
      (when (and eslint (file-executable-p eslint))
        (setq-local flycheck-javascript-eslint-executable eslint))))

  :hook
  (flycheck-mode . flycheck-use-local-eslint))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Python                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package python
  :ensure
  
  :init
  ;; Use Python 3 instead of Python 2.
  (setq python-shell-interpreter "python3")
  (setq flycheck-python-pycompile-executable "python3"))

;; For setup elpy, run:
;; pip install jedi flake8 autopep8
(use-package elpy
  :ensure
  :after python

  :preface
  (defun elpy-shell-send-current-line ()
    "Send current line to Python shell."
    (interactive)
    (call-when-defined 'python-shell-send-string (thing-at-point 'line)))

  :init
  (setq elpy-rpc-python-command "python3")
  (call-when-defined 'elpy-enable)

  :bind
  (:map elpy-mode-map
        ("C-c C-p" . run-python)
        ("C-c C-r" . 'elpy-shell-send-region-or-buffer)
        ("C-c C-b" . elpy-shell-send-region-or-buffer)
        ("C-c C-c" . elpy-shell-send-current-line)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                             Ruby                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ruby-mode
  :ensure
  
  :preface
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
  
  :bind
  (:map ruby-mode-map
		("C-c C-f" . ruby-insert-end)
		("C-c b" . ruby-send-buffer)))

(use-package inf-ruby
  :ensure
  
  :preface
  (defun inf-ruby-restart (&optional impl)
	(interactive)
	(catch 'return
	  ;; If ruby buffer does not exist, just start a new one.
	  (unless (and inf-ruby-buffer
				   (buffer-name inf-ruby-buffer))
        (call-when-defined 'inf-ruby)
		(throw 'return nil))
	  ;; If ruby buffer exists, kill current ruby process and
	  ;; start a new one in same window position.
	  (with-selected-window (get-buffer-window inf-ruby-buffer)
		(kill-buffer inf-ruby-buffer)
		(setq inf-ruby-buffer nil)
		(let ((config (current-window-configuration)))
          (call-when-defined 'inf-ruby)
		  (set-window-configuration config))
		(switch-to-buffer inf-ruby-buffer)))
	(message "inf-ruby process restarted. Happy hacking!"))

  :bind
  (:map inf-ruby-minor-mode-map
		("C-c C-s" . inf-ruby-restart))

  :hook
  (ruby-mode . inf-ruby-minor-mode))

(use-package company-inf-ruby
  :ensure
  
  :init
  (add-to-list 'company-backends 'company-inf-ruby)

  :hook
  (inf-ruby-mode . company-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                              Go                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package go-mode
  :ensure
  
  :preface
  (defun optimize-and-save ()
    (interactive)
    (call-when-defined 'gofmt)
    (save-buffer-readonly)
    (call-when-defined 'go-remove-unused-imports nil)
    (save-buffer-readonly))

  :bind
  (:map go-mode-map
        ("C-x C-s" . optimize-and-save)))

(use-package go-eldoc
  :ensure
  :after go-mode

  :hook
  (go-mode . go-eldoc-setup))

(use-package company-go
  :ensure
  :after go-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            LaTeX                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package latex
  :preface
  (defun LaTeX-mode-setup ()
	"Hook function for LaTeX mode."
	;; Enable auto-fill.
	(auto-fill-mode)
	;; Disable flycheck mode.
	(call-when-defined flycheck-mode -1)
	;; Enable toc viewer.
	(turn-on-reftex)
	;; Stop using default completion.
	(setq completion-at-point-functions 'complete-or-indent))
  
  :init
  ;; Add Chinese support.
  (setq pdf-latex-command "xelatex")
  ;; Automatically save the style.
  (setq TeX-auto-save t)
  ;; Parse file after loading.
  (setq TeX-parse-self t)
  ;; Don't ask me if I want to save.
  (setq TeX-save-query nil)
  ;; Enable all the features of LaTeX mode.
  (setq LaTeX-section-hook '(LaTeX-section-heading
							 LaTeX-section-title
							 LaTeX-section-toc
							 LaTeX-section-section
							 LaTeX-section-label))

  :hook
  (LaTeX-mode . LaTeX-mode-setup))


(use-package latex-preview-pane
  :ensure

  :bind
  (:map latex-preview-pane-mode-map
		("M-P" . nil)))

(use-package reftex-toc
  :ensure

  :init
  ;; Enable on-the-fly table-of-content.
  (setq reftex-plug-into-AUCTeX t)

  :bind (:map reftex-toc-mode-map
			  ("q" . delete-window)))

(use-package company-auctex
  :ensure
  
  :preface
  (defun LaTeX-mode-setup-company ()
	(make-local-variable 'company-backends)
	(setq company-backends '(company-dabbrev company-auctex-bibs
											 (company-auctex-macros
											  company-auctex-symbols
											  company-auctex-environments)))
	(company-mode-setup-yasnippet-backend)
	;; Disable idle completion.
	(set (make-local-variable 'company-idle-delay) nil))

  :hook
  (LaTeX-mode . LaTeX-mode-setup-company))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                           Markdown                           ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package markdown-mode
  :ensure
  
  :preface
  (defun markdown-mode-setup()
    "Setup markdown-mode."
    (auto-fill-mode 1))

  :init
  ;; Use pandoc as markdown generator.
  (setq markdown-command "pandoc")
  ;; Use w3m to preview markdown.
  (setq markdown-live-preview-window-function
        'markdown-live-preview-window-eww)
  
  :hook
  (markdown-mode . flyspell-mode)
  (markdown-mode . toggle-word-wrap)
  (markdown-mode . markdown-mode-setup))

(use-package poly-markdown
  :ensure)
(remove-hook 'markdown-mode-hook 'poly-markdown-mode)

(use-package flymd
  :ensure
  :after markdown-mode

  :init
  (setq flymd-output-directory "/tmp/"))

(use-package markdown-toc
  :ensure
  :after markdown-mode

  :bind
  (:map markdown-mode-map
        ("C-c =" . markdown-toc-generate-or-refresh-toc)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Misc                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package yaml-mode
  :ensure

  :mode "\\.yml\\'"
  :mode "\\.yml.j2\\'"

  :hook
  (yaml-mode . fci-mode)
  (yaml-mode . highlight-indent-guides-mode)

  :bind
  (:map yaml-mode-map
        ("<return>" . newline-smart-comment)))

(use-package conf-mode
  :ensure
  :bind
  (:map conf-mode-map
        ("<return>" . newline-smart-comment)))

(use-package json-mode
  :ensure)


;;; d2-dev-lang.el ends here
