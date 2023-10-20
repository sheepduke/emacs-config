;; It's Magit! Git inside Emacs.
(use-package magit
  :bind ("C-x v" . magit-status)

  :hook (git-commit-mode . flyspell-mode))

