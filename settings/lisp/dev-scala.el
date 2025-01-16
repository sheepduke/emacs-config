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

  ;; (local-set-key (kbd "C-c C-a") 'scala-repl-attach)
  ;; (local-set-key (kbd "C-c C-d") 'scala-repl-detach)
  ;; (local-set-key (kbd "C-c C-p") 'scala-repl-run)
  ;; (local-set-key (kbd "C-c C-s") 'scala-repl-restart)
  ;; (local-set-key (kbd "C-c C-l") 'scala-repl-save-and-load)
  ;; (local-set-key (kbd "C-c C-b") 'scala-repl-eval-buffer)
  ;; (local-set-key (kbd "C-c C-c") 'scala-repl-eval-region-or-line)
  ;; (local-set-key (kbd "C-c C-r") 'scala-repl-eval-main-function)
  ;; (local-set-key (kbd "C-M-l") 'scala-repl-clear)
  ;; (local-set-key (kbd "C-c C-v") 'compile-dwim)

  (local-set-key (kbd "<return>") 'scala-smart-newline))

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

(use-package sbt-mode
  :after (scala-ts-mode)
  
  :bind (:map scala-ts-mode-map
              ("C-M-l" . sbt-clear)))

(use-package sbt-plus
  :after (scala-ts-mode))

(major-mode-hydra-define scala-ts-mode nil
  ("SBT"
   (("s" sbt-start "start")
    ("S" sbt-plus-do-restart "restart")
    ("l" sbt-plus-do-reload "reload"))

   "REPL"
   (("e" sbt-plus-enter-repl "enter")
    ("E" sbt-plus-leave-repl "leave"))

   "Send"
   (("c" sbt-plus-send-line-or-region "line/region")
    ("b" sbt-plus-send-buffer "buffer"))

   "Action"
   (("k" sbt-do-compile "compile")
    ("r" sbt-do-run "run")
    ("t" sbt-do-test "test")
    ("C" sbt-do-clean "clean")
    ("g" sbt-plus-do-stage "stage"))))
