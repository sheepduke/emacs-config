;; ============================================================
;;  Keymap
;; ============================================================

(use-package emacs
  :bind
  ;; Buffer.
  ("C-x b" . switch-to-buffer)
  ("C-x B" . persp-switch-to-scratch-buffer)
  ("C-x k" . kill-current-buffer)
  ("C-x C-k" . bury-buffer)
  ("C-x C-b" . switch-to-other-buffer)
  ("C-x o" . switch-to-other-buffer)
  ("C-x s" . save-buffer)

  ;; File.
  ("C-x f" . find-file)

  ;; Bookmark.
  ("C-x r b" . consult-bookmark)

  ("C-'" . avy-goto-char-timer)
  ("C-x *" . toggle-window-split)

  ;; ("C-c SPC" . consult-register-store)
  ;; ("C-c C-SPC" . consult-register-load)

  ;; ("C-c 3" . w3m)
  ;; ("C-c d" . sdcv-search-input)  

  ;; ("C-c e g" . emms-play-directory)
  ;; ("C-c e e" . emms-play-file)
  ;; ("C-c e d" . emms-play-dired)
  ;; ("C-c e f" . emms-shuffle)
  ;; ("C-c e l" . emms-playlist-mode-go)
  ;; ("C-c e x" . emms-start)
  ;; ("C-c e SPC" . emms-pause)
  ;; ("C-c e s" . emms-stop)
  ;; ("C-c e n" . emms-next)
  ;; ("C-c e p" . emms-previous)

  ;; ("C-c m" . notmuch)

  ;; ("C-c j o" . org-journal-open-current-journal-file)
  ;; ("C-c j s" . org-journal-search)
  ;; ("C-c j j" . org-journal-new-entry)
  ;; ("C-c j k" . org-journal-new-scheduled-entry)
  ;; ("C-c j v" . org-journal-schedule-view)

  ;; ("C-c o" . cfw:open-org-calendar)
  ;; ("C-c O" . calendar)
  ;; ("C-c s" . shell)

  ("C-x r e" . mc/edit-lines)
  ("C-x v" . magit)

  ;; ("C-c t a" . auto-fill-mode)
  ;; ("C-c t d" . toggle-debug-on-error)
  ;; ("C-c t i" . auto-revert-tail-mode)
  ;; ("C-c t t" . toggle-truncate-lines)
  ;; ("C-c t w" . toggle-word-wrap)
  ;; ("C-c t W" . toggle-window-dedicated)
  ;; ("C-c t v" . visual-line-mode)

  ("M-1" . persp-switch-to-1)
  ("M-2" . persp-switch-to-2)
  ("M-3" . persp-switch-to-3)
  ("M-4" . persp-switch-to-4)
  ("M-5" . persp-switch-to-5)
  ("M-6" . persp-switch-to-6)
  ("M-7" . persp-switch-to-7)
  ("M-8" . persp-switch-to-8)
  ("M-9" . persp-switch-to-9)
  
  ("M-o" . ace-window)
  ("M-O" . ace-swap-window)
   
  ("M-P" . windmove-up)
  ("M-N" . windmove-down)
  ("M-L" . windmove-right)
  ("M-H" . windmove-left)
         
  ("M-u" . upcase-initials-region)
  ("M-q" . fill-paragraph)
  ("M-y" . consult-yank-pop)
  
  ("M-g e" . consult-compile-error)
  ("M-g f" . consult-flymake)
  ("M-g g" . avy-goto-line)
  ("M-g M-g" . consult-goto-line) ;; orig. goto-line
  ("M-g i" . consult-imenu)
  ("M-g I" . consult-imenu-multi)
  ("M-g k" . consult-global-mark)
  ("M-g m" . consult-mark)
  ("M-g o" . consult-outline)     ;; Alternative: consult-org-heading

  ("M-s d" . consult-find)
  ("M-s D" . consult-locate)
  ("M-s g" . consult-grep)
  ("M-s G" . consult-git-grep)
  ("M-s r" . consult-ripgrep)
  ("M-s l" . consult-line-multi)
  ("M-s k" . consult-keep-lines)
  ("M-s u" . consult-focus-lines)
  
  ("C-S-s" . consult-line)
  ("C-M-r" . replace-string)
  ("C-M-S-r" . replace-regexp)
  ("C-M-/" . consult-yasnippet)
  ("C-M-q" . fill-region)

  ("C-c" . major-mode-hydra))

;; Unbind C-c key bindings.
(dolist (keymap (list flyspell-mode-map))
  (define-key keymap (kbd "C-c") nil))

;; ============================================================
;;  Hydra
;; ============================================================

(use-package pretty-hydra
  :ensure
  :config
  (global-set-key (kbd "M-SPC") 'hydra-global/body)

  ;; | color    | toggle                     |
  ;; |----------+----------------------------|
  ;; | red      |                            |
  ;; | blue     | :exit t                    |
  ;; | amaranth | :foreign-keys warn         |
  ;; | teal     | :foreign-keys warn :exit t |
  ;; | pink     | :foreign-keys run          |
  (pretty-hydra-define hydra-global (:color blue)
    ("Buffer management"
     (("k" hydra-workspace/body "workspace")
      ("w" hydra-window/body "window")
      ("b" hydra-buffer/body "buffer"))

     "Editing"
     (("e" hydra-editing/body "editing")
      ("g" hydra-goto/body "goto"))

     "Tools"
     (("p" hydra-project/body "project")
      ("s" silver-brain-hydra/body "silver brain")
      ("t" #'hydra-tool/body "other"))
     
     "Local"
     (("l" major-mode-hydra "local"))))

  (pretty-hydra-define hydra-workspace ()
    ("Switch to"
     (("1" persp-switch-to-1 "1")
      ("2" persp-switch-to-2 "2")
      ("3" persp-switch-to-3 "3")
      ("4" persp-switch-to-4 "4")
      ("5" persp-switch-to-5 "5")
      ("6" persp-switch-to-6 "6")
      ("7" persp-switch-to-7 "7")
      ("8" persp-switch-to-8 "8")
      ("9" persp-switch-to-9 "9"))

     "Movement"
     (("h" persp-prev "previous")
      ("p" persp-prev "previous")
      ("l" persp-next "next")
      ("n" persp-next "next"))

     "Manipulation"
     (("c" persp-create "create")
      ("s" persp-switch "switch")
      ("r" persp-rename "rename")
      ("m" persp-merge "merge")
      ("k" persp-kill "kill"))

     "Swap"
     (("S" persp-swap "swap")
      ("H" persp-swap-previous "swap previous")
      ("P" persp-swap-previous "swap previous")
      ("L" persp-swap-next "swap next")
      ("N" persp-swap-next "swap next"))))
  
  (pretty-hydra-define hydra-window ()
    ("Movement"
     (("h" windmove-left "⇦")
      ("l" windmove-right "⇨")
      ("p" windmove-up "⇧")
      ("n" windmove-right "⇩"))

     "Manipulation"
     (("s" split-window-below "split below")
      ("v" split-window-right "split right")
      ("k" delete-window "delete this")
      ("o" delete-other "delete other")
      ("d" toggle-window-dedicated "toggle dedicated"))

     "Layout"
     (("]" enlarge-window-horizontally "width +")
      ("[" shrink-window-horizontally "width -")
      ("+" enlarge-window "height +")
      ("-" shrink-window "height -")
      ("=" balance-windows "balance" "="))))

  (pretty-hydra-define hydra-buffer ()
    ("Switch to"
     (("b" switch-to-buffer "buffer")
      ("B" persp-switch-to-scratch-buffer "scratch buffer")
      ("o" switch-to-other-buffer "other buffer"))

     "Manipulation"
     (("f" find-file "open file")
      ("r" rename-buffer "rename buffer")
      ("s" save-buffer)
      ("q" bury-buffer "bury")
      ("k" kill-current-buffer "kill"))))

  (pretty-hydra-define hydra-project (:color blue)
    ("Project"
     (("f" project-find-file "find file")
      ("p" project-switch-project "switch project")
      ("d" project-dired "dired"))))

  (pretty-hydra-define hydra-editing (:color blue)
    ("Character"
     (("c" insert-char "insert")
      ("C" what-cursor-position "inspect"))

     "Buffer"
     (("E" erase-buffer "erase")
      ("s" sort-lines "sort")
      ("o" consult-focus-lines "focus lines")
      ("O" consult-keep-lines "keep lines"))

     "Register"
     (("r" consult-register-load "load")
      ("e" consult-register-store "store"))

     "Toggle"
     (("a" auto-fill-mode "auto fill")
      ("d" toggle-debug-on-error "debug on error")
      ("w" toggle-word-wrap "word wrap")
      ("t" toggle-truncate-lines "truncate lines")
      ("l" display-line-numbers-mode "line numbers")
      ("v" visual-line-mode "visual line"))))
  
  (pretty-hydra-define hydra-goto (:color blue)
    ("In Buffer"
     (("g" avy-goto-line)
      ("k" consult-flymake)
      ("s" consult-line)
      ("l" consult-goto-line)
      ("o" consult-outline))

     "Directory"
     (("f" consult-fd "file (fd)")
      ("r" consult-ripgrep "ripgrep"))

     "Bookmark"
     (("b" consult-bookmark "jump to bookmark")
      ("B" list-bookmarks "list"))

     "Mark"
     (("m" consult-mark)
      ("M" consult-global-mark)
      ("u" consult-outline))))

  (pretty-hydra-define hydra-tool (:color blue)
    ("Built-in"
     (("e" hydra-emms/body "emms")
      ("s" shell "shell")
      ("o" org-agenda "org agenda")
      ("j" org-journal-new-entry "org journal")
      ("p" list-packages "packages")
      ("c" calculator "calculator"))

     "Plugin"
     (("l" cfw:open-org-calendar "calendar")
      ("L" calendar "simple calendar"))

     "External"
     (("d" sdcv-search-input "dictionary")
      ("v" magit "magit")
      ("w" w3m "w3m"))))

  (pretty-hydra-define hydra-emms (:color blue)
    ("Play"
     (("d" emms-play-dired "dired")
      ("f" emms-play-file "file")
      ("g" emms-play-directory "directory"))

     "Control"
     (("SPC" emms-pause "pause")
      ("t" emms-stop "stop")
      ("n" emms-next "next")
      ("p" emms-previous "previous"))

     "Playlist"
     (("s" emms-shuffle "shuffle")
      ("l" emms-playlist-mode-go "show")))))

(use-package hydra-posframe
  :after hydra
  :demand t
  :config
  (hydra-posframe-mode 1))

;; ============================================================
;;  Evil
;; ============================================================

(use-package evil
  :ensure t
  :demand t

  :init
  ;; Required by evil-collection.
  (setq evil-want-keybinding nil)
  (setq evil-want-integration t)

  :custom
  (evil-undo-system 'undo-tree)
  (evil-want-C-u-scroll t)
  (evil-want-C-u-delete t)
  (evil-disable-insert-state-bindings nil)
  (evil-search-module 'evil-search)

  :config
  (evil-define-key 'normal 'global (kbd "M-u") 'universal-argument)
  ;; (evil-define-key 'normal 'global (kbd "SPC") 'hydra-global/body)

  ;; Key bindings.
  ;; (evil-set-leader 'normal (kbd "SPC"))

  ;; ;; File related.
  ;; (evil-define-key 'normal 'global (kbd "<leader>ff") #'find-file)
  ;; (evil-define-key 'normal 'global (kbd "<leader>fs") #'save-buffer)
  ;; (evil-define-key 'normal 'global (kbd "<leader>wc") #'persp-create)
  ;; (evil-define-key 'normal 'global (kbd "<leader>") #'persp-create)

  (setq display-line-numbers-type 'relative)

  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :after 'evil
  :demand t

  :config
  (evil-collection-init))

(use-package general
  :ensure t
  :after 'evil
  :demand t

  :config 
  (general-create-definer evil-global-leader-def
    :states '(normal)
    :prefix "SPC")

  (evil-global-leader-def
    ;; Buffer.
    "b" '(:ignore t :which-key "buffer")
    "bb" '(switch-to-buffer :which-key "switch")
    "bl" '(persp-list-buffers :which-key "list")
    "bq" '(kill-current-buffer :which-key "kill")
    "bs" '(persp-switch-to-scratch-buffer :which-key "scratch")
    "bo" '(switch-to-other-buffer :which-key "scratch")

    ;; File.
    "f"  '(:ignore t :which-key "file")
    "ff" '(find-file :which-key "find")
    "fs" '(save-buffer :which-key "save")
    "fd" '(delete-file-and-kill-buffer :which-key "delete")

    ;; Workspace.
    "w" '(:ignore t :which-key "workspace")
    "wc" '(persp-create :which-key "create")
    "wr" '(persp-rename :which-key "rename")
    "wq" '(persp-kill-current :which-key "kill current")
    "wh" '(persp-prev :which-key "switch to previous")
    "wl" '(persp-next :which-key "switch to next")
    "wH" '(persp-swap-previous :which-key "swap previous")
    "wL" '(persp-swap-next :which-key "swap next")

    ;; Project.
    "p" '(:ignore t :which-key "project")
    "pf" '(project-find-file :which-key "find file")
    "pd" '(project-dired :which-key "project root")
    "pp" '(project-switch-project :which-key "switch project")

    ;; Jump.
    "j" '(:ignore t :which-key "jump")
    "jb" '(consult-bookmark :which-key "bookmark")
    "jc" '(avy-goto-char-timer :which-key "char")
    "jk" '(evil-ex-nohighlight :which-key "no highlight")
    "jl" '(consult-line :which-key "line")
    "jr" '(consult-ripgrep :which-key "ripgrep")))
