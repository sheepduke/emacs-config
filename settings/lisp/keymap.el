;; ============================================================
;;  Keymap
;; ============================================================

(use-package emacs
  :bind
  ;; Buffer.
  ("C-x b" . switch-to-buffer)
  ("C-x B" . persp-switch-to-scratch-buffer)
  ("C-x k" . kill-this-buffer)
  ("C-x C-k" . bury-buffer)
  ("C-x C-b" . switch-to-other-buffer)
  ("C-x o" . switch-to-other-buffer)
  ("C-x s" . save-buffer)

  ;; File.
  ("C-x f" . find-file)

  ;; Bookmark.
  ("C-x r b" . consult-bookmark)

  ("C-," . global-devil-mode)
  ("C-'" . avy-goto-char-timer)
  ("C-x *" . toggle-window-split)

  ("C-c SPC" . consult-register-store)
  ("C-c C-SPC" . consult-register-load)

  ("C-c 3" . w3m)
  ("C-c d" . sdcv-search-input)  

  ("C-c e g" . emms-play-directory)
  ("C-c e e" . emms-play-file)
  ("C-c e d" . emms-play-dired)
  ("C-c e f" . emms-shuffle)
  ("C-c e l" . emms-playlist-mode-go)
  ("C-c e x" . emms-start)
  ("C-c e SPC" . emms-pause)
  ("C-c e s" . emms-stop)
  ("C-c e n" . emms-next)
  ("C-c e p" . emms-previous)

  ("C-c m" . notmuch)

  ("C-c j o" . org-journal-open-current-journal-file)
  ("C-c j s" . org-journal-search)
  ("C-c j j" . org-journal-new-entry)
  ("C-c j k" . org-journal-new-scheduled-entry)
  ("C-c j v" . org-journal-schedule-view)

  ("C-c o" . cfw:open-org-calendar)
  ("C-c O" . calendar)
  ("C-c s" . shell)

  ("C-x r e" . mc/edit-lines)
  ("C-x v" . magit)

  ("C-c t a" . auto-fill-mode)
  ("C-c t d" . toggle-debug-on-error)
  ("C-c t i" . auto-revert-tail-mode)
  ("C-c t t" . toggle-truncate-lines)
  ("C-c t w" . toggle-word-wrap)
  ("C-c t W" . toggle-window-dedicated)
  ("C-c t v" . visual-line-mode)

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
  ("C-M-q" . fill-region))

;; ============================================================
;;  Hydra
;; ============================================================

(use-package pretty-hydra
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
    ("Buffer Management"
     (("d" hydra-workspace/body "Workspace")
      ("w" hydra-window/body "Window")
      ("b" hydra-buffer/body "Buffer"))

     "Project"
     (("p" hydra-project/body "Project"))

     "Editing"
     (("e" hydra-editing/body "Editing")
      ("r" hydra-register/body "Register"))
    
     "Local"
     (("l" major-mode-hydra "Local"))))

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
     (("h" persp-prev "Previous")
      ("p" persp-prev "Previous")
      ("l" persp-next "Next")
      ("n" persp-next "Next"))

     "Manipulation"
     (("s" persp-switch "Switch/Create")
      ("k" persp-kill "Kill"))))
  
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
     (("]" enlarge-window-horizontally "Width +")
      ("[" shrink-window-horizontally "Width -")
      ("+" enlarge-window "Height +")
      ("-" shrink-window "Height -")
      ("=" balance-windows "Balance" "="))))

  (pretty-hydra-define hydra-buffer ()
    ("Switch to"
     (("b" switch-to-buffer "Buffer")
      ("s" persp-switch-to-scratch-buffer "Scratch buffer")
      ("o" switch-to-other-buffer "Other buffer"))

     "Manipulation"
     (("f" find-file "Open File")
      ("q" bury-buffer "Bury")
      ("k" kill-this-buffer "Kill"))))

  (pretty-hydra-define hydra-project ()
    ("Project"
     (("f" project-find-file "find file"))))
  
  (pretty-hydra-define hydra-editing ()
    ("Character"
     (("i" insert-char "insert")
      ("s" what-cursor-position "inspect"))

     "Occur"
     (("o" consult-focus-lines "occur")
      ("O" consult-keep-lines "multi occur")
      ("f" consult-fd "fd")
      ("g" consult-ripgrep "ripgrep"))

     "Mark"
     (("m" consult-mark)
      ("M" consult-global-mark)
      ("u" consult-outline))

     "Toggle"
     (("a" auto-fill-mode "auto fill")
      ("w" toggle-word-wrap "word wrap")
      ("t" toggle-truncate-lines "truncate lines")
      ("n" display-line-numbers-mode "line numbers")
      ("v" visual-line-mode "visual line"))))

  (pretty-hydra-define hydra-register ()
    ("Bookmark"
     (("b" consult-bookmark "Jump to Bookmark")
      ("B" list-bookmarks "List"))

     "Register"
     (("l" consult-register-load "Load")
      ("s" consult-register-store "Store")))))

(use-package hydra-posframe
  :after hydra
  :demand t
  :config
  (hydra-posframe-mode 1))
