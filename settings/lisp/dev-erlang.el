(use-package erlang
  :ensure
  :config
  (require 'erlang-start)

  :bind (:map erlang-mode-map
              ("<f5>" . recompile)
              ("C-<f5>" . compile))

  :custom
  (erlang-indent-level 2))
