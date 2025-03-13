;; ============================================================
;;  Web
;; ============================================================

(use-package web-mode
  :ensure
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
  :ensure
  :hook
  (web-mode . emmet-mode)

  :bind (:map emmet-mode-keymap
              ("C-j" . emmet-expand-line)
              ("C-M-j" . emmet-expand-yas)))

;; ============================================================
;;  JavaScript
;; ============================================================

(use-package js2-mode
  :ensure
  :config
  (defun setup-js2-mode ()
    (when (equal major-mode 'js-mode)
      (js2-minor-mode)))

  :hook (js-mode . setup-js2-mode)

  :custom
  ;; Set indent to 2.
  (js-indent-level 2)
  ;; Do not warn me for missing ';'.
  (js2-strict-missing-semi-warning nil))


(use-package typescript-mode
  :ensure
  :custom
  (typescript-indent-level 2))


;; IDE for JavaScript.
(use-package tide
  :ensure
  :disabled
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (js-mode . tide-setup)
         (js-mode . tide-hl-identifier-mode)))


;; REPL for JavaScript.
(use-package js-comint
  :ensure
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
  :ensure
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
