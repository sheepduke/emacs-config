(defun scala-setup-buffer ()
    (eglot-ensure)
    
    (add-hook 'before-save-hook 'eglot-format-buffer)

    (local-set-key (kbd "C-c C-p") 'scala-repl-run)
    (local-set-key (kbd "C-c C-s") 'scala-repl-restart)
    (local-set-key (kbd "C-c C-b") 'scala-repl-eval-buffer)
    (local-set-key (kbd "C-c C-r") 'scala-repl-eval-region)
    (local-set-key (kbd "C-c C-c") 'scala-repl-eval-current-line)
    (local-set-key (kbd "C-M-l") 'scala-repl-clear))

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
             scala-repl-eval-region
             scala-repl-eval-current-line))

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
