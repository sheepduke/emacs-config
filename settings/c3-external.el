;;; Package --- Functions with external programs

;;; Commentary:

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                             emms                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package emms
  :ensure
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
  (setq emms-source-file-default-directory "~/music")

  :bind
  ("C-c e g" . emms-play-directory)
  ("C-c e e" . emms-play-file)

  ("C-c e d" . emms-play-dired)
  ("C-c e f" . emms-shuffle)
  ("C-c e l" . emms-playlist-mode-go)
  ("C-c e x" . emms-start)
  ("C-c e SPC" . emms-pause)
  ("C-c e s" . emms-stop)
  ("C-c e n" . emms-next)
  ("C-c e p" . emms-previous))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                         Dictionary                           ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package sdcv
  :ensure t
  :if (executable-find "sdcv")
  :bind ("C-c d" . sdcv-search-input))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Image+                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Image processing
(use-package image+
  :ensure t
  :if (executable-find "convert")

  :functions (image-rotate-original)
  
  :hook
  (after-init . imagex-global-sticky-mode)
  (imagex-sticky-mode . imagex-auto-adjust-mode)

  :bind (:map image-mode-map
              ("=" . imagex-sticky-zoom-in)
              ("-" . imagex-sticky-zoom-out)
              ("o" . imagex-sticky-restore-original)
              ("m" . imagex-sticky-maximize)
              ("D" . image-delete-original-file)
              ("r" . imagex-sticky-rotate-right)
              ("R" . image-rotate-original-right)
              ("l" . imagex-sticky-rotate-left)
              ("L" . image-rotate-original-left)
              ("S" . imagex-sticky-save-image))

  :custom
  ;; Stop showing annoying warnings.
  (imagex-quiet-error t)

  ;; Use feh to view image externally.
  (image-dired-external-viewer "feh")

  :config
  (defun image-rotate-original (degree)
    "Rotate original image file with given DEGREE."
    (interactive)
    (let ((file (buffer-file-name)))
      (shell-command
       (format "convert -rotate %d \"%s\" \"%s\"" degree file file)))
    (revert-buffer nil t)
    (message "Image rotated."))

  (defun image-rotate-original-left ()
    (interactive)
    (image-rotate-original 270))

  (defun image-rotate-original-right ()
    (interactive)
    (image-rotate-original 90))

  (defun image-delete-original-file ()
    "Delete original file from disk."
    (interactive
     (if (yes-or-no-p "File will be deleted forever. Continue? ")
         (let ((file-to-delete (buffer-file-name)))
           (image-next-file)
           (delete-file file-to-delete)
           (message "File deleted."))
       (message "Aborted.")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                             w3m                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package w3m
  :ensure t
  :if (executable-find "w3m")

  :config
  (defun w3m-bury-all-buffers ()
    "Bury all w3m related buffers."
    (interactive)
    (let ((buffers (w3m-list-buffers t)))
      (dolist (buffer buffers)
        (bury-buffer buffer)))
    (switch-to-other-buffer))

  :bind (("C-c 3" . w3m)
         :map w3m-mode-map
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
  (w3m-default-save-directory (concat *data-path* "w3m/saved/"))
  (w3m-bookmark-file (concat *data-path* "w3m/bookmark.html"))

  ;; Set w3m as the default browser inside Emacs.
  (browse-url-browser-function '(("HyperSpec" . w3m-goto-url-new-session)
                                 (".*" . browse-url-default-browser)))

  ;; Set duckduckgo as the default search engine.
  (w3m-search-default-engine "duckduckgo")

  ;; Use w3m to render HTML mails.
  (mm-text-html-renderer 'w3m))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                         Silver Brain                         ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;;; c3-external.el ends here
