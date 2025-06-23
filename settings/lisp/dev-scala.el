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
  :commands (scala-repl-run
             scala-repl-restart
             scala-repl-eval-buffer
             scala-repl-eval-region-or-line
             scala-repl-eval-region
             scala-repl-eval-current-line
             scala-repl-eval-main-function))

(use-package sbt-mode
  :ensure
  :after (scala-ts-mode)
  
  :bind (:map scala-ts-mode-map
              ("C-M-l" . sbt-clear)))

(use-package sbt-plus
  :after (scala-ts-mode))

;; (major-mode-hydra-define scala-ts-mode nil
;;   ("SBT"
;;    (("s" sbt-start "start")
;;     ("S" sbt-plus-do-restart "restart")
;;     ("l" sbt-plus-do-reload "reload"))

;;    "REPL"
;;    (("e" sbt-plus-enter-repl "enter")
;;     ("E" sbt-plus-leave-repl "leave"))

;;    "Send"
;;    (("c" sbt-plus-send-line-or-region "line/region")
;;     ("b" sbt-plus-send-buffer "buffer"))

;;    "Action"
;;    (("k" sbt-do-compile "compile")
;;     ("r" sbt-do-run "run")
;;     ("t" sbt-do-test "test")
;;     ("C" sbt-do-clean "clean")
;;     ("g" sbt-plus-do-stage "stage"))))
