;; ============================================================
;;  Eshell
;; ============================================================

(use-package eshell
  :config
  (setq eshell-aliases-file (locate-user-data-file "eshell-alias"))

  (defun eshell-clear-buffer ()
    "Clear the buffer and delete everything. Handy if you have too much
output."
    (interactive)
    (let ((inhibit-read-only t))
      (erase-buffer)
      (eshell-send-input)))

  (defun eshell-mode-setup ()
    (setq pcomplete-cycle-completions nil)
    (local-set-key (kbd "C-M-l") 'eshell-clear-buffer)
    (setenv "PAGER" "/bin/cat"))

  :hook (eshell-mode . eshell-mode-setup))

;; ============================================================
;;  PDF
;; ============================================================

;; Replace the original doc-view for PDF files.
(use-package pdf-tools
  :ensure t
  :defer t
  :unless (windows?)

  :config
  (pdf-tools-install))

;; ============================================================
;;  Book Reader
;; ============================================================

;; Open epub files.
(use-package nov
  :ensure t
  :mode ("\\.epub\\'" . nov-mode))

;; ============================================================
;;  Music
;; ============================================================

(use-package emms
  :ensure t
  
  :init
  (require 'emms-setup)

  ;; Set players.
  (emms-all)
  (emms-default-players)

  ;; Show info at mode-line.
  (require 'emms-mode-line)
  (emms-mode-line-mode 1)

  ;; Show time of music.
  (require 'emms-playing-time)
  (emms-playing-time-mode 1)

  ;; Auto identify encode.
  (require 'emms-i18n)

  ;; Do NOT save and import playlist automatically.
  ;; WARNING! It will make Emacs slow.
  ;; (require 'emms-history)
  ;; (emms-history-load)

  ;; Don't repeat playlist.
  (setq emms-repeat-playlist nil)
  ;; Set default music directory.
  (setq emms-source-file-default-directory "~/music"))

;; ============================================================
;;  Dictionary
;; ============================================================

(use-package sdcv
  :ensure t
  :if (executable-find "sdcv"))

;; ============================================================
;;  Browser
;; ============================================================

(use-package w3m
  :ensure t
  :if (executable-find "w3m")

  :preface
  (defun w3m-bury-all-buffers ()
    "Bury all w3m related buffers."
    (interactive)
    (let ((buffers (w3m-list-buffers t)))
      (dolist (buffer buffers)
        (bury-buffer buffer)))
    (switch-to-other-buffer))

  (defun w3m-browse-url-in-browser (url &rest args)
    (if (wsl?)
        (let ((browse-url-generic-program "/mnt/c/Windows/System32/cmd.exe")
              (browse-url-generic-args '("/c" "start")))
          (browse-url-generic url))
      (browse-url-default-browser url)))

  :bind (:map w3m-mode-map
         ("C-<return>" . w3m-view-this-url-new-session)
         ("C-M-h" . w3m-previous-buffer)
         ("C-M-l" . w3m-next-buffer)
         ("H" . w3m-view-previous-page)
         ("L" . w3m-view-next-page)
         ("h" . w3m-db-history)
         ("q" . w3m-bury-all-buffers))

  :custom
  (w3m-home-page "about://bookmark/")

  ;; Images
  (w3m-toggle-inline-images-permanently t)
  (w3m-default-display-inline-images t)

  ;; Cookies
  (w3m-use-cookies t)
  (w3m-cookie-accept-bad-cookies t)

  ;; Sessions
  (w3m-session-load-last-sessions t)
  (w3m-new-session-in-background nil)
  (w3m-session-time-format "%Y-%m-%d %A %H:%M")

  ;; Cache
  (w3m-favicon-use-cache-file t)
  (w3m-keep-arrived-urls 5000)
  (w3m-keep-cache-size 1000)

  ;; Don't ask me if I'm leaving secure page.
  (w3m-confirm-leaving-secure-page nil)

  ;; Storage
  (w3m-default-save-directory (locate-user-data-file "w3m/saved/"))
  (w3m-bookmark-file (locate-user-data-file "w3m/bookmark.html"))

  ;; Set w3m as the default browser inside Emacs.
  (browse-url-browser-function '(("HyperSpec" . w3m-goto-url-new-session)
                                 (".*" . w3m-browse-url-in-browser)))
  (browse-url-handlers '(("HyperSpec" . w3m-goto-url-new-session)
                         (".*" . w3m-browse-url-in-browser)))

  ;; Set duckduckgo as the default search engine.
  (w3m-search-default-engine "duckduckgo")

  ;; Use w3m to render HTML mails.
  (mm-text-html-renderer 'w3m))

;; ============================================================
;;  Input Method
;; ============================================================

(use-package rime
  :ensure t
  :custom
  ;; Set Rime as the default input method.
  (default-input-method "rime")

  ;; Use mini-buffer as the prompt.
  (rime-show-candidate 'minibuffer)

  ;; Use ibus Rime data.
  (rime-user-data-dir (if (file-directory-p "~/.local/share/fcitx5/rime")
                          "~/.local/share/fcitx5/rime"
                        "~/.config/ibus/rime")))

;; ============================================================
;;  Silver Brain
;; ============================================================

(use-package silver-brain
  :load-path "~/.silver-brain/emacs/"
  
  :config
  (silver-brain-install)

  :bind
  ("C-c b b" . silver-brain)
  ("C-c b o" . silver-brain-open)
  ("C-c b n" . silver-brain-new-concept)

  :custom
  (silver-brain-database-name "silver-brain")
  (silver-brain-server-port 5000))
