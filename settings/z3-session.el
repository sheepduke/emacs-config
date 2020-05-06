;;; Package --- Session management

;;; Commentary:

;;; Code:

(use-package desktop
  :init
  ;; No automatic save.
  (setq desktop-save nil)
  ;; Don't ask me about PID etc.
  (setq desktop-load-locked-desktop t)
  ;; Set files.
  (setq desktop-base-file-name "desktop")
  (setq desktop-base-lock-name "lock")
  ;; For elscreen-persist
  (setq desktop-files-not-to-save "")
  (setq desktop-restore-frames nil)

  :config
  ;; Save theme setting.
  (defun desktop-load-theme ()
  	(dolist (theme custom-enabled-themes)
  	  (load-theme theme)))
  (add-hook 'desktop-after-read-hook 'desktop-load-theme)
  (add-to-list 'desktop-globals-to-save 'custom-enabled-themes))

;;; z3-session.el ends here
