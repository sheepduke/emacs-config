;; ============================================================
;;  Scala Mode
;; ============================================================

(defun scala-smart-newline ()
  (interactive)
  (let ((comment-start (and (line-in-comment?)
                            (substring (string-trim-left (thing-at-point 'line t)) 0 2))))
    (newline-and-indent)
    (when comment-start
      (insert (cond
               ((s-equals? comment-start "/*") "* ")
               ((s-equals? comment-start "* ") "* ")
               ((s-equals? comment-start "//") "// "))))))

(defun scala-setup-buffer ()
  (eglot-ensure)
  
  (add-hook 'before-save-hook 'eglot-format-buffer nil t)
  (local-set-key (kbd "<return>") 'scala-smart-newline))

(use-package scala-ts-mode
  :ensure
  :mode "\\.scala\\'"
  :mode "\\.sc\\'"

  :config
  (require 'eglot)
  (add-to-list 'eglot-server-programs
                   (cons 'scala-ts-mode
                         (cdr (assoc 'scala-mode eglot-server-programs))))
  
  :hook
  (scala-ts-mode . scala-setup-buffer))

(use-package scala-repl
  :ensure

  ;; Now use sbt-mode instead.
  ;; :hook
  ;; (scala-ts-mode . scala-repl-minor-mode)
  )

;; ============================================================
;;  SBT
;; ============================================================

(use-package sbt-mode
  :ensure
  :after (scala-ts-mode)

  :preface
  (defun sbt-send-block (string)
    (sbt-send-string (format "{%s}" string)))

  (defun sbt-send-string (string)
    (when (windows?)
      (comint-send-string (sbt:buffer-name) "\n"))

    (comint-send-string (sbt:buffer-name)
                        (format "%s\n" string)))

  (defun sbt-enter-repl ()
    (interactive)
    (sbt-send-string "console"))

  (defun sbt-leave-repl ()
    (interactive)
    (sbt-send-string ":q"))

  (defun sbt-reload ()
    (interactive)
    (sbt-send-string "reload"))

  (defun sbt-send-line-or-region ()
    (interactive)
    (if (region-active-p)
        (sbt-send-block (thing-at-point 'region))
      (sbt-send-string (thing-at-point 'line))))

  (defun sbt-send-buffer ()
    (interactive)
    (sbt-send-block (thing-at-point 'buffer)))

  :bind (:map scala-ts-mode-map
              ;; SBT management.
              ("C-c C-z" . #'sbt-start)
              ("C-c C-x" . #'sbt-reload)
              ("C-c C-o" . #'sbt-clear)

              ;; SBT actions.
              ("C-c C-k" . #'sbt-do-compile)
              ("C-c C-r" . #'sbt-do-run)
              ("C-c C-t" . #'sbt-do-test)

              ;; REPL.
              ("C-c C-p" . #'sbt-enter-repl)
              ("C-c C-q" . #'sbt-leave-repl)
              ("C-c C-c" . #'sbt-send-line-or-region)
              ("C-c C-b" . #'sbt-send-buffer)))
