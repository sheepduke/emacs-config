;;; Package --- Summary
;;;
;;; Commentary:
;;; This file contains settings for each programming language, divided by
;;; section.
;;;
;;; Code:
;;;
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              Arduino                             ;;
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
;;                              C/C++                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package cc-mode
  :init
  ;; Use 'gnu' coding style.
  (setq c-default-style "gnu")

  :bind
  (:map c++-mode-map
		("<return>" . newline-smart-comment)
		("<f5>" . recompile)
		("C-<f5>" . compile)
		:map c-mode-map
		("<return>" . newline-smart-comment)
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
  :mode "CMakeLists\\.txt\\'"
  :mode "\\.cmake\\'")

;; Add completion for C headers.
(use-package company-c-headers)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              Erlang                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package erlang
  :init
  (setq erlang-indent-level 2)

  :config
  (require 'erlang-start)

  :bind
  (:map erlang-mode-map
        ("<return>" . newline-smart-comment)
        ("<f5>" . recompile)
        ("C-<f5>" . compile)))


(use-package company-erlang
  :init
  (add-hook 'erlang-mode-hook 'company-mode)
  (add-hook 'erlang-mode-hook 'company-erlang-init))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            Elixir                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package alchemist
  :init
  (defun elixir-insert-end ()
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

  (defun alchemist-iex-send-buffer ()
    "Send current buffer."
    (interactive)
    (alchemist-iex-send-region (point-min) (point-max)))

  :bind
  (:map alchemist-mode-map
        ("<return>" . newline-smart-comment)
        ("C-c b" . alchemist-iex-send-buffer)
        ("C-c r" . alchemist-iex-send-region)
        ("C-x C-e" . alchemist-iex-send-last-sexp)
        ("C-c C-c" . alchemist-iex-send-current-line)
        ("C-c C-f" . elixir-insert-end)
        ("M-P" . nil)
        ("M-N" . nil)
        ("C-c a" . nil))

  :config
  (add-hook 'elixir-mode-hook 'alchemist-mode)
  (add-hook 'alchemist-mode-hook 'company-mode)
  (add-hook 'alchemist-mode-hook 'flyspell-prog-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              Rust                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package rust-mode)

(use-package cargo
  :init
  (add-hook 'rust-mode-hook 'cargo-minor-mode))

(use-package racer
  :init
  (setq racer-rust-src-path "/home/sheep/software/rust-src/src/")

  :config
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
;;                         Common Lisp                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package slime
  :init
  ;; set common lisp REPL
  (setq inferior-lisp-program "ros run")
  (require 'slime-autoloads)

  ;; Set the location of HyperSpec.
  (setq common-lisp-hyperspec-root
        (expand-file-name "~/documents/manuals/lisp/HyperSpec/"))

  :bind
  (:map slime-mode-map
        ("C-c b" . slime-eval-buffer)
        ("C-c c" . slime-compile-file)
        ("C-c r" . slime-eval-region))

  :config
  (when (fboundp 'slime-setup)
    (slime-setup '(slime-fancy slime-company)))

  (add-hook 'slime-repl-mode-hook 'company-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          Emacs Lisp                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package elisp-mode
  :bind
  (:map emacs-lisp-mode-map
		("<f12>" . eval-buffer)
		("<return>" . newline-smart-comment))

  :config
  (add-hook 'emacs-lisp-mode-hook 'eldoc-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            Clojure                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package cider
  :init
  (defun cider-eval-buffer-content ()
    "Eval buffer content without having to save it."
    (interactive)
    (when (fboundp 'cider-eval-region)
      (cider-eval-region (point-min) (point-max))))

  (add-hook 'clojure-mode-hook 'cider-mode)

  :bind
  (:map cider-mode-map
        ("C-c b" . cider-eval-buffer-content)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              Racket                              ;;
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
;;                               Web                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package web-mode
  :mode "\\.html\\'"
  :mode "\\.css\\'"
  :mode "\\.jsp\\'"

  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-indent-style 2)

  (defun web-mode-setup ()
	(make-local-variable 'company-backends)
	(setq company-backends
		  '(company-web-html :with 'company-yasnippet))
    (fci-mode 0)
    (setq fill-column 120))
  (add-hook 'web-mode-hook 'web-mode-setup)

  (use-package rainbow-mode
    :init
    (add-hook 'web-mode-hook 'rainbow-mode)))


(use-package simple-httpd
  :init
  (setq httpd-port (+ 10000 (random 1000))))

(use-package js2-mode
  :mode "\\.js\\'"

  :config
  (setq js-indent-level 2))

(use-package skewer-mode
  :after js2-mode

  :init
  (add-hook 'js2-mode-hook 'skewer-mode)
  (add-hook 'css-mode-hook 'skewer-css-mode)
  (add-hook 'html-mode-hook 'skewer-html-mode))

(use-package vue-mode
  :init
  (defun setup-vue-mode ()
    (setq tab-width 2))

  :config
  (add-hook 'vue-mode-hook 'setup-vue-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              Python                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package python)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               Ruby                               ;;
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
		("C-c b" . ruby-send-buffer)
		("<return>" . newline-smart-comment)))

(use-package inf-ruby
  :init
  (defun inf-ruby-restart (&optional impl)
	(interactive)
	(catch 'return
	  ;; If ruby buffer does not exist, just start a new one.
	  (unless (and inf-ruby-buffer
				   (buffer-name inf-ruby-buffer))
        (when (fboundp 'inf-ruby)
          (inf-ruby))
		(throw 'return nil))
	  ;; If ruby buffer exists, kill current ruby process and
	  ;; start a new one in same window position.
	  (with-selected-window (get-buffer-window inf-ruby-buffer)
		(kill-buffer inf-ruby-buffer)
		(setq inf-ruby-buffer nil)
		(let ((config (current-window-configuration)))
          (when (fboundp 'inf-ruby)
            (inf-ruby))
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
;;                                Go                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package go-mode
  :init
  (defun optimize-and-save ()
    (interactive)
    (when (fboundp 'gofmt)
      (gofmt))
    (save-buffer-readonly)
    (when (fboundp 'go-remove-unused-imports)
      (go-remove-unused-imports nil))
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
;;                              LaTeX                               ;;
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
	(flycheck-mode -1)
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
;;                             Markdown                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package markdown-mode
  :config
  (add-hook 'markdown-mode-hook 'flyspell-mode)
  (add-hook 'markdown-mode-hook 'toggle-word-wrap))

(use-package flymd
  :after markdown-mode

  :config
  (setq flymd-output-directory "/tmp/"))

(use-package markdown-toc
  :after markdown-mode
  :bind
  (:map markdown-mode-map
        ("C-c =" . markdown-toc-generate-or-refresh-toc)))

(provide 'd2-dev-lang) ;;; d2-dev-lang.el ends here
