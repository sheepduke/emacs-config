;;; Package --- Settings for each programming language

;;; Commentary:

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Arduino                           ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package arduino-mode
  :mode "\\.ino"
  
  :config
  (defun arduino-mode-hook-function ()
	(semantic-mode 0)
	(set (make-local-variable 'compile-command)
		 "make -j4 -l5 && make upload")
	(make-local-variable 'company-backends)
	(setq company-backends
		  '((company-dabbrev company-gtags company-etags company-keywords
							 :with company-yasnippet)
			(company-c-headers :with company-yasnippet)
			(company-capf :with company-yasnippet))))

  (add-hook 'arduino-mode-hook 'arduino-mode-hook-function))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            C/C++                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package cc-mode
  :ensure
  :init
  ;; Use 'gnu' coding style.
  (setq c-default-style "gnu")

  :bind
  (:map c++-mode-map
		("<f5>" . recompile)
		("C-<f5>" . compile)
		:map c-mode-map
		("<f5>" . recompile)
		("C-<f5>" . compile))

  :config
  (add-to-list 'auto-mode-alist '("\\.tpp\\'" . c++-mode))

  (add-hook 'c++-mode-hook 'ggtags-mode)

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
  (add-hook 'c++-mode-hook 'c/c++-mode-setup-company)
  (add-hook 'c-mode-hook 'c/c++-mode-setup-company))

(use-package cmake-mode
  :ensure
  :mode "CMakeLists\\.txt\\'"
  :mode "\\.cmake\\'")

;; Add completion for C headers.
(use-package company-c-headers)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Java                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun java-mode-setup ()
  "Setup Java mode."
  (setq fill-column 120))
(add-hook 'java-mode-hook 'java-mode-setup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Erlang                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package erlang
  :init
  (setq erlang-indent-level 2)

  :config
  (require 'erlang-start)

  :bind
  (:map erlang-mode-map
        ("<f5>" . recompile)
        ("C-<f5>" . compile)))

(use-package company-erlang
  :init
  (add-hook 'erlang-mode-hook 'company-mode)
  (add-hook 'erlang-mode-hook 'company-erlang-init))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Elixir                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package alchemist
  :after elixir-mode
  :init
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
  (add-hook 'elixir-mode-hook 'alchemist-mode)
  (add-hook 'alchemist-mode-hook 'company-mode)
  (add-hook 'alchemist-mode-hook 'flyspell-prog-mode)

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
        ("C-c a" . nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Rust                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package rust-mode
  :init
  (defun rust-mode-setup ()
    "Setup rust mode."
    (set (make-local-variable 'compile-command)
		 "cargo test"))
  (add-hook 'rust-mode-hook 'rust-mode-setup)

  :bind
  (:map rust-mode-map
        ("C-<f5>" . compile)
        ("<f5>" . recompile)))

(use-package cargo
  :init
  (add-hook 'rust-mode-hook 'cargo-minor-mode))

(use-package racer
  :init
  (add-hook 'rust-mode-hook 'racer-activate)
  (add-hook 'rust-mode-hook 'racer-turn-on-eldoc))

(use-package flycheck-rust
  :init
  (add-hook 'flycheck-mode-hook 'flycheck-rust-setup))

(use-package company-racer
  :config
  (defun company-racer-setup ()
	(make-local-variable 'company-backends)
	(setq company-backends '((company-racer :with company-yasnippet))))

  (add-to-list 'rust-mode-hook 'company-racer-setup))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                       Common Lisp                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package sly
  :ensure
  :preface
  (defun sly-repl-clear-buffer-anywhere ()
    "Clear Sly buffer from anywhere."
    (interactive)
    (with-current-buffer "*sly-mrepl for sbcl*"
      (call-when-defined 'sly-mrepl-clear-repl)))

  :init
  ;; set common lisp REPL
  (setq inferior-lisp-program "ros run")
  ;; Use classic completion style.
  (setq sly-complete-symbol-function 'sly-simple-completions)

  ;; Set the location of HyperSpec.
  (setq common-lisp-hyperspec-root
        (expand-file-name "~/documents/manuals/lisp/HyperSpec/"))

  (add-hook 'lisp-mode-hook 'sly-editing-mode)
  
  :bind
  (:map sly-mode-map
        ("C-c C-k" . sly-interrupt)
        ("C-c C-b" . sly-eval-buffer)
        ("C-c C-l" . sly-eval-defun)
        ("C-c C-p" . sly-eval-print-last-expression)
        ("C-c C-d d" . hyperspec-lookup)
        ("C-M-l" . sly-repl-clear-buffer-anywhere)))
  ;; (:map sly-mrepl-mode-map
  ;;       ("C-M-l" . sly-mrepl-clear-repl)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                        Emacs Lisp                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package elisp-mode
  :bind
  (:map emacs-lisp-mode-map
		("<f12>" . eval-buffer))

  :config
  (add-hook 'emacs-lisp-mode-hook 'eldoc-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Clojure                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package cider
  :init
  (defun cider-eval-buffer-content ()
    "Eval buffer content without having to save it."
    (interactive)
    (call-when-defined 'cider-eval-region (point-min) (point-max)))

  (add-hook 'clojure-mode-hook 'cider-mode)

  :bind
  (:map cider-mode-map
        ("C-c b" . cider-eval-buffer-content))
  (:map cider-repl-mode-map
        ("C-M-l" . cider-repl-clear-buffer)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Racket                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package geiser
  :init
  ;; Set racket to be the only implementation.
  (setq geiser-active-implementations '(racket))
  ;; Don't record duplicated command in history.
  (setq geiser-repl-history-no-dups-p t)

  :config
  (add-hook 'geiser-mode-hook 'disable-company-quickhelp-mode)
  (add-hook 'scheme-mode 'geiser-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                             Julia                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package julia-mode
  :init
  (setq julia-indent-offset 4)

  (defun julia-mode-setup ()
    ;; Set fill column.
    (setq fill-column 92)
    ;; Set company source.
    (make-local-variable 'company-backends)
	(setq company-backends
		  '(company-dabbrev :with 'company-yasnippet)))
  (add-hook 'julia-mode-hook 'julia-mode-setup))
  
(use-package julia-repl
  :init
  (defun julia-repl-send-buffer-content ()
    "Send buffer to julia repl."
    (interactive)
    (save-excursion
      (goto-char (point-min))
      (set-mark-command nil)
      (goto-char (point-max))
      (julia-repl-send-region-or-line)))

  (defun julia-repl-send-line-content ()
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

  :after julia-mode
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
  (add-hook 'web-mode-hook 'web-mode-setup))

(use-package emmet-mode
  :ensure
  :init
  (add-hook 'web-mode-hook 'emmet-mode)

  :bind
  (:map emmet-mode-keymap
        ("C-j" . emmet-expand-line)
        ("C-M-j" . emmet-expand-yas)))

(use-package company-web
  :ensure)

(use-package rainbow-mode
  :after web-mode
  :init
  (add-hook 'web-mode-hook 'rainbow-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                         JavaScript                           ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package js2-mode
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

  (add-hook 'js-mode-hook 'setup-js2-mode))

(use-package tide
  :ensure

  :preface
  (defun setup-tide-mode ()
    (interactive)
    (call-when-defined 'tide-setup)
    (setq flycheck-check-syntax-automatically '(save idle-change))
    (call-when-defined 'tide-hl-identifier-mode 1))

  :init
  (add-hook 'js-mode-hook 'setup-tide-mode))

(use-package company-tern
  :ensure t)

(use-package flycheck

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

  :init
  (add-hook 'flycheck-mode-hook 'flycheck-use-local-eslint))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Python                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package python
  :init
  (setq python-shell-interpreter "python3")
  (setq flycheck-python-pycompile-executable "python3"))

;; For setup elpy, run:
;; pip install jedi flake8 autopep8
(use-package elpy
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
  :init
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
  :init
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

  :config
  (add-hook 'ruby-mode-hook 'inf-ruby-minor-mode))

(use-package company-inf-ruby
  :config
  (add-to-list 'company-backends 'company-inf-ruby)
  (add-hook 'inf-ruby-mode-hook 'company-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                              Go                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package go-mode
  :init
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
  :after go-mode
  :config
  (add-hook 'go-mode-hook 'go-eldoc-setup))

(use-package company-go
  :after go-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            LaTeX                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package latex
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

  :config
  (defun LaTeX-mode-hook-function ()
	"Hook function for LaTeX mode."
	;; Enable auto-fill.
	(auto-fill-mode)
	;; Disable flycheck mode.
	(call-when-defined flycheck-mode -1)
	;; Enable toc viewer.
	(turn-on-reftex)
	;; Stop using default completion.
	(setq completion-at-point-functions 'auto-complete))
  (add-hook 'LaTeX-mode-hook 'LaTeX-mode-hook-function))


(use-package latex-preview-pane
  :bind
  (:map latex-preview-pane-mode-map
		("M-P" . nil)))

(use-package reftex-toc
  :init
  ;; Enable on-the-fly table-of-content.
  (setq reftex-plug-into-AUCTeX t)

  :bind (:map reftex-toc-mode-map
			  ("q" . delete-window)))

(use-package company-auctex
  :config
  (defun LaTeX-mode-setup-company ()
	(make-local-variable 'company-backends)
	(setq company-backends '(company-dabbrev company-auctex-bibs
											 (company-auctex-macros
											  company-auctex-symbols
											  company-auctex-environments)))
	(company-mode-setup-yasnippet-backend)
	;; Disable idle completion.
	(set (make-local-variable 'company-idle-delay) nil))
  (add-hook 'LaTeX-mode-hook 'LaTeX-mode-setup-company))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                           Markdown                           ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package markdown-mode
  :preface
  (defun markdown-mode-setup()
    "Setup markdown-mode."
    (auto-fill-mode 1)
    (add-hook 'after-save-hook 'markdown-live-preview-w3m-reload t t))

  (defun markdown-live-preview-window-w3m (file)
    (cond
     ((require 'w3m nil t)
      (w3m-find-file file)
      (get-buffer "*w3m*"))
     (t (error "Package w3m not available"))))

  (defun markdown-live-preview-w3m-reload ()
    "Reload generated HTML."
    (when (and markdown-live-preview-mode
               (get-buffer "*w3m*"))
      (call-when-defined 'w3m-reload-all-pages)))

  :init
  ;; Use pandoc as markdown generator.
  (setq markdown-command "pandoc")
  ;; Use w3m to preview markdown.
  (setq markdown-live-preview-window-function
        'markdown-live-preview-window-w3m)
  
  :config
  (add-hook 'markdown-mode-hook 'flyspell-mode)
  (add-hook 'markdown-mode-hook 'toggle-word-wrap)
  (add-hook 'markdown-mode-hook 'markdown-mode-setup))

(use-package flymd
  :after markdown-mode

  :config
  (setq flymd-output-directory "/tmp/"))

(use-package markdown-toc
  :after markdown-mode
  :bind
  (:map markdown-mode-map
        ("C-c =" . markdown-toc-generate-or-refresh-toc)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Misc                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package yaml-mode
  :mode "\\.yml\\'"
  :mode "\\.yml.j2\\'"

  :bind
  (:map yaml-mode-map
        ("<return>" . newline-smart-comment)))

(use-package conf-mode
  :bind
  (:map conf-mode-map
        ("<return>" . newline-smart-comment)))

(use-package json-mode
  :ensure)


;;; d2-dev-lang.el ends here
