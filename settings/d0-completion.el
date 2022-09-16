(use-package emacs
  :custom
  (savehist-additional-variables
   '(projectile-project-command-history
     kill-ring
     register-alist
     search-ring regexp-search-ring))

  :config
  (savehist-mode 1))

;; Completion UI (vertical completions).
(use-package selectrum
  :config
  (selectrum-mode 1))

;; Filtering and sorting library.
(use-package prescient
  :custom
  (completion-styles '(prescient basic)))

;; Compatibility patch.
(use-package selectrum-prescient)

;; Enable rich annotations.
(use-package marginalia
  :bind (:map minibuffer-local-map
         ("M-a" . marginalia-cycle))

  :init
  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

;; Rich completion framework.
(use-package consult
  :init
  (setq register-preview-function #'consult-register-format)
  
  :bind
  (;; Buffer.
   ("C-x b" . consult-buffer)
   ("C-x r b" . consult-bookmark)

   ;; Register.
   ("M-#" . consult-register-store)
   ("M-'" . consult-register)
   ("M-\"" . consult-register-load)

   ;; Yank.
   ("M-y" . consult-yank-pop)

   ;; Help.
   ("<help> a" . consult-apropos)

   ;; M-g bindings (goto-map)
   ("M-g e" . consult-compile-error)
   ("M-g f" . consult-flymake)   ;; Alternative: consult-flycheck
   ("M-g M-g" . consult-goto-line) ;; orig. goto-line
   ("M-g o" . consult-outline)     ;; Alternative: consult-org-heading
   ("M-g m" . consult-mark)
   ("M-g k" . consult-global-mark)
   ("M-g i" . consult-imenu)
   ("M-g I" . consult-imenu-multi)

   ;; M-S bindings (search-map)
   ("M-s d" . consult-find)
   ("M-s D" . consult-locate)
   ("M-s g" . consult-grep)
   ("M-s G" . consult-git-grep)
   ("M-s r" . consult-ripgrep)
   ("M-s l" . consult-line-multi)
   ("M-s m" . consult-multi-occur)
   ("M-s k" . consult-keep-lines)
   ("M-s u" . consult-focus-lines)
   ("C-s" . consult-line)

   ;; Isearch integration
   :map isearch-mode-map
   ("M-e" . consult-isearch-history) ;; orig. isearch-edit-string
   ("M-s e" . consult-isearch-history) ;; orig. isearch-edit-string
   ("M-s L" . consult-line-multi) ;; needed by consult-line to detect isearch

   ;; Minibuffer history
   :map minibuffer-local-map
   ("M-s" . consult-history) ;; orig. next-matching-history-element
   ("M-r" . consult-history))

  :custom
  (xref-show-xrefs-function #'consult-xref)
  (xref-show-definitions-function #'consult-xref))

(use-package consult-projectile
  :bind
  ("C-x p h" . consult-projectile))

(use-package consult-company
  :preface
  (defun company-mode-remap-completion ()
    (define-key company-mode-map [remap completion-at-point] #'consult-company))
  
  :hook
  (consult-company . company-mode-remap-completion))

;; Action menu for completions.
(use-package embark
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("M-." . embark-dwim)        ;; good alternative: M-.
   ("C-h b" . embark-bindings)) ;; alternative for `describe-bindings'
  
  :init
;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  :config
;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t
  :after (embark consult)
  :demand t ; only necessary if you have the hook below
  ;; if you want to have consult previews as you move around an
  ;; auto-updating embark collect buffer
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))
