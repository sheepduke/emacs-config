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
  (require 'helm-config)

  (add-hook 'after-init-hook 'helm-mode)
  (add-hook 'after-load-theme-hook 'helm-mode)
  
  :bind
  (("M-x" . helm-M-x)
   ("M-s o" . helm-occur)
   ("C-x C-f" . helm-find-files)
   ("C-x b" . helm-mini)
   ("C-x r b" . helm-bookmarks)
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
  (add-hook 'helm-mode-hook 'helm-mode-setup-handlers)

  ;; Just use THIS window!
  (setq helm-split-window-inside-p t)
  ;; Use follow mode from now!
  (setq helm-follow-mode-persistent t))

(use-package helm-themes
  :after helm
  :bind
  ("C-x c t" . helm-themes))

;; Use helm to describe variables and functions.
(use-package helm-descbinds
  :config
  (call-when-defined 'helm-descbinds-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           projectile                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package projectile
  :init
  ;; Offline SVN.
  (setq projectile-svn-command "find . -type f -not -iwholename '*.svn/*' -print0")

  :config
  (call-when-defined 'projectile-mode 1))

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

  :bind
  ("C-c p h" . helm-projectile)

  :config 
  ;; Enable helm-projectile!
  (call-when-defined 'helm-projectile-on))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             helm-ag                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package helm-ag
  :init
  ;; Turn on follow mode that file under cursor will be opened instantly.
  (setq helm-follow-mode-persistent t)
  ;; Use PPCRE instead of Emacs regex.
  (setq helm-ag-use-emacs-lisp-regexp nil)

  :bind
  ("C-x c a" . helm-ag))


;;; d0-completion.el ends here
