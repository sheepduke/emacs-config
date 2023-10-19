;; Save history.
(use-package savehist
  :custom
  (savehist-additional-variables
   '(kill-ring
     register-alist
     search-ring regexp-search-ring))

  :config
  (savehist-mode 1))

;; Completion UI (vertical completions).
(use-package vertico
  :config
  (vertico-mode 1))

;; Filtering and sorting library.
(use-package prescient
  :custom
  (completion-styles '(prescient basic)))


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
  (;; Isearch integration
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

(use-package consult-yasnippet
  :after (consult yasnippet))

(use-package consult-company
  :after (consult company)
  
  :bind
  (:map company-active-map
        ("C-i" . consult-company)))

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
  :after (embark consult)
  :demand t ; only necessary if you have the hook below
  ;; if you want to have consult previews as you move around an
  ;; auto-updating embark collect buffer
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))
