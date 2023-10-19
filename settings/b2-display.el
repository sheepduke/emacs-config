;;; Package --- Window behavior, display effects etc

;;; Commentary:

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Fonts                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun font-exists? (fontname)
  "Test if given FONTNAME is exist or not."
  (if (or (not fontname) (string= fontname ""))
      nil
    (if (not (x-list-fonts fontname)) nil t)))

(defun get-first-available-font (font-list)
  "Return the first available font in FONT-LIST.
If no one was found, NIL is returned."
  (catch 'found
    (dolist (font font-list)
      (when (font-exists? font)
        (throw 'found font)))))

(defun set-font (english-font-list chinese-font-list size-pair)
  "Setup Emacs English and Chinese font on x window system.
ENGLISH-FONT-LIST and CHINESE-FONT-LIST are lists of fonts.
SIZE-PAIR is a cons pair indicating font size."
  (let ((english-font (get-first-available-font english-font-list))
        (chinese-font (get-first-available-font chinese-font-list)))
    (if english-font
        (set-frame-font (font-spec :family english-font
                                   :size (car size-pair)))
      (warn "No available English font."))

    (if chinese-font
        (dolist (charset '(kana han symbol cjk-misc bopomofo))
          (set-fontset-font (frame-parameter nil 'font) charset
                            (font-spec :family chinese-font
                                       :size (cdr size-pair))))
      (warn "No available Chinese font."))))

;; Set font if X window is in use.
;; Note that Chinese font size must be 2 larger than English font for
;; alignment.
(when window-system
  (set-font '("FiraCode Nerd Font Mono" "DejaVu Sans Mono" "Consolas")
            '("Microsoft Yahei" "文泉驿等宽微米黑" "WenQuanYi Micro Hei")
            (cl-case (display-pixel-height)
              (2160 '(25 . 30))
              (1500 '(17 . 18))
              (1445 '(17 . 20))
              (1440 '(18 . 22))
              (t '(14 . 16)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                             Window                           ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; I prefer to have it split window horizontally.
(setq split-height-threshold 80)
(setq split-width-threshold 100)

(defun toggle-window-dedicated ()
  "Toggle whether the current active window is dedicated or not.
A dedicated window can't be switched or modified by some commands."
  (interactive)
  (message
   (if (let (window (get-buffer-window (current-buffer)))
         (set-window-dedicated-p window
                                 (not (window-dedicated-p window))))
       "Window '%s' is dedicated"
     "Window '%s' is normal")
   (current-buffer)))
(global-set-key (kbd "C-c w w") 'toggle-window-dedicated)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                         Shackle                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Force window behavior.
(use-package shackle
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                         Mode Line                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package delight
  :config
  ;; Disable auto-fill mode line.
  (delight 'auto-fill-function "" t)

  :config
  (delight '(;; Major modes
             (emacs-lisp-mode "ELisp" :major)
             ;; Globally enabled modes.
             (auto-revert-mode "" auto-revert)
             (autopair-mode "" autopair)
             (eldoc-mode "" eldoc)
             ;; Dired
             (dired-async-mode "" dired-async))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                           Tools                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Redo or undo window configuration.
(use-package winner
  :config
  (winner-mode 1)

  :bind (("C-c w p" . winner-undo)
         ("C-c w n" . winner-redo)))


;; Fast switching windows.
(use-package ace-window
  :bind
  (("M-o" . ace-window)
   ("M-O" . ace-swap-window))

  :custom
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))


;; Quickly move between windows like a agility snake.
(use-package windmove
  :bind (("M-P" . windmove-up)
         ("M-N" . windmove-down)
         ("M-L" . windmove-right)
         ("M-H" . windmove-left))

  :custom
  (windmove-wrap-around t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Theme                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package kaolin-themes)

;;; b2-display.el ends here
