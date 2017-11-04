(use-package desktop
  :init
  ;; Don't ask me!
  (setq desktop-save t)
  ;; Don't ask me about PID etc.
  (setq desktop-load-locked-desktop t)
  ;; Set files.
  (setq desktop-base-file-name "desktop")
  (setq desktop-base-lock-name "lock")
  ;; For elscreen-persist
  (setq desktop-files-not-to-save "")
  (setq desktop-restore-frames nil)

  :config (desktop-save-mode)

  ;; Save theme setting.
  (defun desktop-load-theme ()
  	(dolist (theme custom-enabled-themes)
  	  (load-theme theme)))
  (add-hook 'desktop-after-read-hook 'desktop-load-theme)
  (add-to-list 'desktop-globals-to-save 'custom-enabled-themes))

(use-package elscreen-persist
  :init
  (defvar desktop-data-elscreen nil
	"Variable to hold elscreen-persist data.")
  (defun desktop-prepare-data-elscreen! ()
	(setq desktop-data-elscreen
		  (elscreen-persist-get-data)))
  (defun desktop-evaluate-data-elscreen! ()
	(when desktop-data-elscreen
	  (elscreen-persist-set-data desktop-data-elscreen)))

  :config
  (add-to-list 'desktop-globals-to-save 'desktop-data-elscreen)
  (add-hook 'desktop-after-read-hook 'desktop-evaluate-data-elscreen!)
  (add-hook 'desktop-save-hook 'desktop-prepare-data-elscreen!))
