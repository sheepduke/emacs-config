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
  :ensure
  :preface
  (defun helm-mode-setup-handlers ()
	(add-to-list 'helm-completing-read-handlers-alist
				 '(bbdb-create . nil)))

  :init
  (require 'helm-config)

  ;; Just use THIS window!
  (setq helm-split-window-inside-p t)
  ;; Use follow mode from now!
  (setq helm-follow-mode-persistent t)
  
  :bind
  (("M-x" . helm-M-x)
   ("C-x C-f" . helm-find-files)
   ("C-x b" . helm-mini)
   ("C-x r b" . helm-bookmarks)
   ("C-x r i" . helm-register)
   ("C-h a" . helm-apropos)
   ("C-x c ," . helm-calcul-expression)
   ("M-i" . helm-show-kill-ring)
   :map helm-map
   ("<tab>" . helm-execute-persistent-action)
   ("M-x" . helm-select-action)
   ("C-z" . nil))

  :config
  (call-when-defined 'helm-mode 1))

(use-package helm-swoop
  :ensure
  :bind
  ("C-s" . helm-swoop))

(use-package helm-themes
  :ensure
  :after helm
  :bind
  ("C-x c t" . helm-themes))

;; Use helm to describe variables and functions.
(use-package helm-descbinds
  :ensure
  :after helm
  :init
  (call-when-defined 'helm-descbinds-mode 1))

(use-package helm-company
  :ensure
  :after (helm company)
  
  :bind
  (:map company-mode-map
        ("C-:" . helm-company))
  (:map company-active-map
        ("C-:" . helm-company)))

(use-package helm-projectile
  :ensure
  :after (helm projectile)

  :bind
  ("C-c p h" . helm-projectile)

  :config 
  ;; Enable helm-projectile!
  (call-when-defined 'helm-projectile-on))


(use-package helm-rg
  :ensure
  :after helm
  :bind
  ("C-x c a" . helm-rg))


;;; d0-completion.el ends here
