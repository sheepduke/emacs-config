(use-package clojure-mode
  :mode "\\.clj\\'")

(use-package cider
  :ensure

  :init
  (defun cider-setup ()
    (local-set-key (kbd "C-c") 'cider-mode-menu))

  :hook
  (cider-mode-hook . cider-setup)

  :custom
  (cider-save-file-on-load nil)

  :config
  (transient-define-prefix cider-mode-menu ()
    [["REPL Start"
      ("e" "Start" cider)
      ("E" "Stop" cider-quit)]

     ["Eval"
      ("c" "Dwim" cider-eval-dwim)
      ("b" "Buffer" cider-eval-buffer)
      ("m" "Macro expand" cider-macroexpand-1)
      ("k" "Interrupt" cider-interrupt)
      ("u" "Undefine" cider-undef)
      ("U" "Undefine all" cider-undef-all)]

     ["Inspect"
      ("a" "Apropos" cider-apropos)
      ("d" "Doc" cider-doc)
      ("D" "Java doc" cider-javadoc)
      ("o" "Apropos doc" cider-apropos-documentation)
      ("O" "Apropos doc and select" cider-apropos-documentation-select)
      ("t" "Toggle trace var" cider-toggle-trace-var)
      ("T" "Toggle trace ns" cider-toggle-trace-ns)]
     ]))
