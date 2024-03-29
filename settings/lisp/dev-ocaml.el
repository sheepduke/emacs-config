(use-package tuareg)


;;; Auto completion and more.
(use-package merlin
  :disabled
  :after tuareg

  :hook (tuareg-mode . merlin-mode))


;; Consistent indentation.
(use-package ocp-indent
  :disabled
  :after tuareg

  :commands (ocp-indent-buffer)

  :config
  (defun ocp-indent-tuareg-buffer ()
    "Indent buffer only when it is in tuareg mode."
    (interactive)
    (when (equal major-mode 'tuareg-mode)
      (ocp-indent-buffer)))

  :hook
  (tuareg-mode . ocp-setup-indent)
  (before-save . ocp-indent-tuareg-buffer))


;;; Type tips.
(use-package merlin-eldoc
  :disabled
  :after merlin

  :hook (tuareg-mode . merlin-eldoc-setup))


;;; Build system.
(use-package dune)


(use-package utop
  :disabled
  :after tuareg

  :hook (tuareg-mode . utop-minor-mode))
