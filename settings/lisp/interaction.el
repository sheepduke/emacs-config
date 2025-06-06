;; ============================================================
;;  Basic
;; ============================================================

(use-package emacs
  :custom
  ;; Content of *scratch* buffer.
  (initial-scratch-message "")

  ;; Share the clipboard with the outside X world.
  (select-enable-clipboard t)

  ;; Fix the position of cursor while scrolling window.
  (scroll-preserve-screen-position t)

  ;; Do not use any GUI pinentry for GPG!
  (epg-pinentry-mode 'loopback)

  ;; Do not ring the bell!
  (ring-bell-function 'ignore)

  ;; Set the default method of tramp.
  (tramp-default-method "ssh")

  ;; Use Emacs Lisp mode for scratch buffer.
  (initial-major-mode 'emacs-lisp-mode)

  ;; Do not display the welcome screen.
  (inhibit-startup-screen t)

  :config
  ;; Enable some commands.
  (mapcar (lambda (command) (put command 'disabled nil))
          '(dired-find-alternate-file
            upcase-region downcase-region
            scroll-left narrow-to-region))

  ;; Always use y-or-n-p for confirmation.
  (defalias 'yes-or-no-p 'y-or-n-p))

(use-package ansi-color
  :hook
  (compilation-filter . ansi-color-compilation-filter))

;; ============================================================
;;  Windows OS
;; ============================================================

(use-package emacs
  :if (windows?)

  :custom
  ;; Disable Windows native cursor type.
  (w32-use-visible-system-caret nil))

;; ============================================================
;;  Bookmark
;; ============================================================

(use-package bookmark
  :custom
  ;; Set bookmark file.
  (bookmark-default-file (locate-user-emacs-file "bookmarks"))

  ;; Save bookmark whenever it is changed.
  (bookmark-save-flag 1))

;; ============================================================
;;  Which Key
;; ============================================================

;; Show hot keys when prefix keys are pressed.
(use-package which-key
  :ensure
  :demand t
  :delight ""

  :config
  (which-key-mode 1)

  :custom
  (which-key-idle-delay 0.5))

;; ============================================================
;;  Workspace Management
;; ============================================================

;; Manage buffers and window layouts into dynamic workspaces.
(use-package perspective
  :ensure
  :demand t

  :preface
  (defun persp-start-and-load ()
    (persp-mode 1)
    (persp-state-load persp-state-default-file))

  (defun persp-switch-to-1 ()
    (interactive)
    (persp-switch-by-number 1))

  (defun persp-switch-to-2 ()
    (interactive)
    (persp-switch-by-number 2))

  (defun persp-switch-to-3 ()
    (interactive)
    (persp-switch-by-number 3))

  (defun persp-switch-to-4 ()
    (interactive)
    (persp-switch-by-number 4))

  (defun persp-switch-to-5 ()
    (interactive)
    (persp-switch-by-number 5))

  (defun persp-switch-to-6 ()
    (interactive)
    (persp-switch-by-number 6))

  (defun persp-switch-to-7 ()
    (interactive)
    (persp-switch-by-number 7))

  (defun persp-switch-to-8 ()
    (interactive)
    (persp-switch-by-number 8))

  (defun persp-switch-to-9 ()
    (interactive)
    (persp-switch-by-number 9))

  (defun persp-create ()
    (interactive)
    (let ((name (format "%d" (1+ (length (persp-names))))))
      (persp-new name)
      (persp-switch name)))

  (defun persp-swap ()
    "Swap this perspective with selected target."
    (interactive)
    (let ((source-name (persp-current-name))
          (target-name (completing-read "Swap with: " (persp-names))))
      (persp--do-swap source-name target-name)))

  (defun persp-swap-previous ()
    "Swap this perspective with previous one."
    (interactive)
    (let ((source-name (persp-current-name))
          target-name)
      (persp-prev)
      (setf target-name (persp-current-name))
      (persp-next)
      (persp--do-swap source-name target-name)))

  (defun persp-swap-next ()
    "Swap this perspective with next one."
    (interactive)
    (let ((source-name (persp-current-name))
          target-name)
      (persp-next)
      (setf target-name (persp-current-name))
      (persp-prev)
      (persp--do-swap source-name target-name)))

  (defun persp--do-swap (source-name target-name)
    "Swap source perspective with given target."
    (unless (equal source-name target-name)
      (let ((temp-name "**__persp-rename-temp__**"))
        ;; Rename source to temp.
        (persp-rename temp-name)
        
        ;; Rename target to source.
        (persp-switch target-name)
        (persp-rename source-name)

        ;; Rename temp to target
        (persp-switch temp-name)
        (persp-rename target-name))))
  
  :custom
  (persp-mode-prefix-key (kbd "C-z"))

  ;; The default name of frame.
  (persp-initial-frame-name "1")

  ;; Method used to sort perspectives.
  (persp-sort 'name)

  ;; File used to load and save state file.
  (persp-state-default-file (locate-user-emacs-file "perspective.dat"))

  :config
  (persp-mode 1))

;; ============================================================
;;  Window Management
;; ============================================================

;; Fast switching windows.
(use-package ace-window
  :ensure
  :demand t

  :custom
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

;; Quickly move between windows like a agility snake.
(use-package windmove
  :ensure
  :demand t
  
  :custom
  (windmove-wrap-around t))

;; Force window behavior.
(use-package shackle
  :ensure
  :custom
  ;; one of below, above, left, right
  (shackle-default-alignment 'below)
  ;; Don't reuse windows by default.
  (shackle-select-reused-windows nil)
  ;; Define shackle rules!
  (shackle-rules
   '(("*Bookmark List*" :select t :inhibit-window-quit t :same t)
     ("*Calendar*" :select t :inhibit-window-quit nil :size 0.3 :align below)
     ("Capture" :regexp t :select t :inhibit-window-quit t :same t)
     ("*Completions*" :select nil :inhibit-window-quit nil)
     ("*grep*" :select t)
     ("*Help*" :select t :inhibit-window-quit nil)
     ("*slime-description*" :select t :inhibit-window-quit t :same t)
     ("*toc*" :select t :inhibit-window-quit t :same t :size 0.5)))

  :config
  (shackle-mode))

;; ============================================================
;;  Completion
;; ============================================================

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
  :ensure
  :config
  (vertico-mode 1))

;; Filtering and sorting library.
(use-package orderless
  :ensure
  :custom
  (completion-ignore-case t)
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; Enable rich annotations.
(use-package marginalia
  :ensure
  :demand t

  :bind (:map minibuffer-local-map
              ("M-a" . marginalia-cycle))

  :config
  (marginalia-mode))

;; Rich completion framework.
(use-package consult
  :ensure
  :demand t
  
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
   ("M-r" . consult-history)))

(use-package consult-xref
  :demand t
  :after consult
  
  :custom
  (xref-show-xrefs-function #'consult-xref)
  (xref-show-definitions-function #'consult-xref))

(use-package consult-register
  :commands (consult-register-store consult-register-load))

(use-package consult-flymake)

;; Action menu for completions.
(use-package embark
  :ensure
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
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
  :ensure
  :after (embark consult)
  :demand t ; only necessary if you have the hook below
  ;; if you want to have consult previews as you move around an
  ;; auto-updating embark collect buffer
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; ============================================================
;;  Posframe
;; ============================================================

(use-package vertico-posframe
  :ensure
  :after vertico
  :config
  (vertico-posframe-mode 1))
