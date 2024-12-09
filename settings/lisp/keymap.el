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
      ("P" list-packages "packages")
      ("s" silver-brain-hydra/body "silver brain")
      ("v" magit "magit"))
    
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
      ("k" persp-kill "kill"))))
  
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
      ("k" kill-this-buffer "kill"))))

  (pretty-hydra-define hydra-project ()
    ("Project"
     (("f" project-find-file "find file")
      ("p" project-switch-project "switch project")
      ("d" project-dired "dired"))))
  
  (pretty-hydra-define hydra-goto ()
    ("In Buffer"
     (("g" avy-goto-line)
      ("k" consult-flymake)
      ("s" consult-line)
      ("l" consult-goto-line))

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

  (pretty-hydra-define hydra-editing ()
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
      ("v" visual-line-mode "visual line")))))

(use-package hydra-posframe
  :after hydra
  :demand t
  :config
  (hydra-posframe-mode 1))
