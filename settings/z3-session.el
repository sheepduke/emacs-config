(use-package desktop
  :ensure
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

(use-package elscreen-persist
  :ensure
  :init
  (defvar desktop-data-elscreen nil
	"Variable to hold elscreen-persist data.")
  (defun desktop-prepare-data-elscreen! ()
	(setq desktop-data-elscreen
		  (call-when-defined 'elscreen-persist-get-data)))
  (defun desktop-evaluate-data-elscreen! ()
	(when desktop-data-elscreen
	  (call-when-defined 'elscreen-persist-set-data desktop-data-elscreen)))

  :config
  (add-to-list 'desktop-globals-to-save 'desktop-data-elscreen)
  (add-hook 'desktop-after-read-hook 'desktop-evaluate-data-elscreen!)
  (add-hook 'desktop-save-hook 'desktop-prepare-data-elscreen!))
