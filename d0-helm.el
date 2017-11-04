;;; Package --- Summary
;;;
;;; Commentary:
;;; System-wide completion platform.
;;;
;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             Helm                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package helm
  :init
  ;; (add-hook 'after-init-hook #'helm-setup)
  ;; Just use THIS window!
  (setq helm-split-window-in-side-p t)
  ;; Use follow mode from now!
  (setq helm-follow-mode-persistent t)
  ;; Load it.
  (defun helm-setup ()
    (require 'helm-config)
	(message "Loading helm")
    (helm-mode 1))
  (add-hook 'after-init-hook #'helm-setup)
  (add-hook 'after-load-theme-hook #'helm-setup)
  
  :bind
  (("M-x" . helm-M-x)
   ("M-s o" . helm-occur)
   ("C-x C-f" . helm-find-files)
   ("C-x b" . helm-mini)
   ("C-x r i" . helm-register)
   ("C-x c ," . helm-calcul-expression)
   ("M-i" . helm-show-kill-ring)
   
   :map helm-map
   ("<tab>" . helm-execute-persistent-action)
   ("M-x" . helm-select-action)
   ("C-z" . nil))

  :config
  (defun helm-mode-setup-handlers ()
	(add-to-list 'helm-completing-read-handlers-alist
				 '(bbdb-create . nil)))
  (add-hook 'helm-mode-hook 'helm-mode-setup-handlers))

;; Use helm to describe variables and functions.
(use-package helm-descbinds
  :config
  (helm-descbinds-mode 1))

(use-package projectile
  :init
  ;; Offline SVN.
  (setq projectile-svn-command "find . -type f -not -iwholename '*.svn/*' -print0")

  :config
  (projectile-mode 1))

(use-package helm-projectile
  :after (helm projectile)
  :init
  ;; Use helm as completion system for projectile.
  (setq projectile-completion-system 'helm)
  ;; Set mode line of projectile.
  (setq projectile-mode-line
		'(:eval
		  (if (file-remote-p default-directory)
			  ""
			(format " [%s]"
					(projectile-project-name)))))
  :config 
  ;; Enable helm-projectile!
  (helm-projectile-on))

;;; d0-completion.el ends here
