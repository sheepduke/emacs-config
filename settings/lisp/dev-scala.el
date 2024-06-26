(defun scala-smart-newline ()
  (interactive)
  (let ((comment-symbol (and (line-in-comment?)
                             (seq-first (string-trim-left (thing-at-point 'line))))))
    (newline-and-indent)
    (when comment-symbol
      (insert (cl-case comment-symbol
                (?* "* ")
                (?/ "//")
                (nil ""))))))

(defun scala-setup-buffer ()
  (eglot-ensure)
  
  (add-hook 'before-save-hook 'eglot-format-buffer nil t)

  (local-set-key (kbd "C-c C-a") 'scala-repl-attach)
  (local-set-key (kbd "C-c C-d") 'scala-repl-detach)
  (local-set-key (kbd "C-c C-p") 'scala-repl-run)
  (local-set-key (kbd "C-c C-s") 'scala-repl-restart)
  (local-set-key (kbd "C-c C-l") 'scala-repl-save-and-load)
  (local-set-key (kbd "C-c C-b") 'scala-repl-eval-buffer)
  (local-set-key (kbd "C-c C-c") 'scala-repl-eval-region-or-line)
  (local-set-key (kbd "C-c C-r") 'scala-repl-eval-main-function)
  (local-set-key (kbd "C-M-l") 'scala-repl-clear)
  (local-set-key (kbd "C-c C-v") 'compile-dwim)
  (local-set-key (kbd "<return>" 'scala-smart-newline)))

(use-package scala-ts-mode
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
  :commands (scala-repl-run
             scala-repl-restart
             scala-repl-eval-buffer
             scala-repl-eval-region-or-line
             scala-repl-eval-region
             scala-repl-eval-current-line
             scala-repl-eval-main-function))

;; (use-package sbt-mode)

;; (use-package sbt-anywhere
;;   :after (sbt scala-mode)
  
;;   :bind (:map scala-mode-map
;;               ("C-c C-l" . sbt-anywhere-enter-repl)
;;               ("C-c C-o" . sbt-anywhere-leave-repl)
;;               ("C-c C-c" . sbt-anywhere-send-line)
;;               ("C-c C-r" . sbt-anywhere-send-region)
;;               ("C-c C-b" . sbt-anywhere-send-buffer)
;;               ("C-c c c" . sbt-do-compile)
;;               ("C-c c t" . sbt-do-test)
;;               ("C-c c r" . sbt-do-run)
;;               ("C-c c l" . sbt-do-clean)
;;               ("C-c c p" . sbt-do-package)
;;               ("C-c c s" . sbt-anywhere-do-restart)
;;               ("C-c c a" . sbt-anywhere-do-assembly)
;;               ("C-M-l" . sbt-clear)))
