;;; Package --- Summary
;;;
;;; Commentary:
;;; This file contains settings related to window behavior, status bar etc.
;;;
;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              Fonts                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun font-exist-p (fontname)
  "Test if given FONTNAME is exist or not."
  (if (or (not fontname) (string= fontname ""))
      nil
    (if (not (x-list-fonts fontname)) nil t)))

(defun set-font (english-font-list chinese-font-list size-pair)
  "Setup Emacs ENGLISH and CHINESE font on x window system, with given
SIZE-PAIR."
  (let ((english-font (get-available-font english-font-list))
        (chinese-font (get-available-font chinese-font-list)))
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
  (set-font '("DejaVu Sans Mono")
            '("文泉驿等宽微米黑" "WenQuanYi Micro Hei")
            '(14 . 16)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               Window                             ;;
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

;; Provide GNU screen like screen facility in Emacs.
(use-package elscreen
  :init
  ;; Don't display the tab on the top
  (setq elscreen-display-tab nil)

  :config
  (call-when-defined 'elscreen-start)
  (global-set-key (kbd "C-z \"") 'elscreen-goto)
  (global-set-key (kbd "C-z '") 'elscreen-select-and-goto))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           Shackle                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Force window behavior.
(use-package shackle
  :init 
  ;; one of below, above, left, right
  (setq shackle-default-alignment 'below)
  ;; Don't reuse windows by default.
  (setq shackle-select-reused-windows nil)
  ;; Define shackle rules!
  (setq shackle-rules
		'(("Capture" :regexp t :select t :inhibit-window-quit t :same t)
		  ("*Help*" :select t :inhibit-window-quit nil)
		  ("*grep*" :select t)
		  ("*Completions*" :select nil :inhibit-window-quit nil)
		  ("*Calendar*" :select t :inhibit-window-quit nil :size 0.3 :align below)
		  ("*Bookmark List*" :select t :inhibit-window-quit t :same t)
		  ("*toc*" :select t :inhibit-window-quit t :same t :size 0.5)
          ("*slime-description*" :select t :inhibit-window-quit t :same t)))

  :config
  (call-when-defined 'shackle-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           Mode Line                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package delight
  :init
  ;; Disable auto-fill mode line.
  (call-when-defined 'delight 'auto-fill-function "" t)

  :config
  (call-when-defined
   'delight
   '(;; Major modes
	 (emacs-lisp-mode "ELisp" :major)
	 ;; Globally enabled modes.
	 (auto-revert-mode "" auto-revert)
	 (company-mode " company" company)
	 (flyspell-mode "" flyspell)
	 (autopair-mode "" autopair)
	 (undo-tree-mode "" undo-tree)
	 (eldoc-mode "" eldoc)
	 (yas-minor-mode "" yasnippet)
	 ;; LaTeX ref, cite etc.
	 (reftex-mode "" reftex)
	 (latex-preview-pane-mode " Pane" latex-preview-pane))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             Tools                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Redo or undo window configuration.
(use-package winner
  :bind
  ("C-c w p" . winner-undo)
  ("C-c w n" . winner-redo)

  :config
  (call-when-defined 'winner-mode 1))


;; Fast switching frames
(use-package ace-window
  :init
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

  :bind
  ("M-o" . ace-window)
  ("M-O" . ace-swap-window))

;; Quickly move between windows like a agility snake.
(use-package windmove
  :init
  (setq windmove-wrap-around t)
  
  :bind
  ("M-P" . windmove-up)
  ("M-N" . windmove-down)
  ("M-L" . windmove-right)
  ("M-H" . windmove-left))

;;; b2-display.el ends here
