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

  ;; Show info at mode-line
  (require 'emms-mode-line)
  (emms-mode-line 1)

  ;; Show time of music
  (require 'emms-playing-time)
  (emms-playing-time 1)

  ;; Auto identify encode
  (require 'emms-i18n)

  ;; Auto save and import playlist
  ;; WARNING! It will make Emacs slow.
  (require 'emms-history)
  (emms-history-load)

  ;; Don't repeat playlist.
  (setq emms-repeat-playlist nil)
  ;; Set default music directory
  (setq emms-source-file-default-directory "~/music")

  :bind
  ("C-c 3 g" . emms-play-directory)
  ("C-c 3 e" . emms-play-file)

  ("C-c 3 d" . emms-play-dired)
  ("C-c 3 f" . emms-shuffle)
  ("C-c 3 l" . emms-playlist-mode-go)
  ("C-c 3 x" . emms-start)
  ("C-c 3 SPC" . emms-pause)
  ("C-c 3 s" . emms-stop)
  ("C-c 3 n" . emms-next)
  ("C-c 3 p" . emms-previous))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                             w3m                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (executable-find "w3m")
  (use-package w3m
    :ensure
	:init
	(setq w3m-home-page "about://bookmark/")
    ;; Images
    (setq w3m-toggle-inline-images-permanently t)
    (setq w3m-default-display-inline-images t)
    ;; Cookies
    (setq w3m-use-cookies t)
    (setq w3m-cookie-accept-bad-cookies t)
    ;; Sessions
    (setq w3m-session-load-last-sessions t)
    (setq w3m-new-session-in-background nil)
    (setq w3m-session-time-format "%Y-%m-%d %A %H:%M")
    ;; Cache
    (setq w3m-favicon-use-cache-file t)
    (setq w3m-keep-arrived-urls 5000)
    (setq w3m-keep-cache-size 1000)
    ;; Don't ask me if I'm leaving secure page.
    (setq w3m-confirm-leaving-secure-page nil)
    ;; Storage
    (setq w3m-default-save-directory (concat *data-path* "w3m/saved/"))
    (setq w3m-bookmark-file (concat *data-path* "w3m/bookmark.html"))
    ;; Set w3m as the default browser inside Emacs.
    (setq browse-url-browser-function
          `(("HyperSpec" . w3m-goto-url-new-session)
            (".*" . browse-url-default-browser)))
    ;; Set duckduckgo as the default search engine.
    (setq w3m-search-default-engine "duckduckgo")
    
	:bind (("C-c 3" . w3m)
		   :map w3m-mode-map
           ("C-<return>" . w3m-view-this-url-new-session)
		   ("C-M-h" . w3m-previous-buffer)
		   ("C-M-l" . w3m-next-buffer)
           ("H" . w3m-view-previous-page)
           ("L" . w3m-view-next-page)
		   ("h" . w3m-db-history))

    :defines
    (desktop-buffer-major-mode)

	:config
	;; Save session.
	(defun w3m-register-desktop-save ()
	  "Set `desktop-save-buffer' to a function returning the current URL."
	  (setq desktop-save-buffer (lambda (desktop-dirname) w3m-current-url)))
	(add-hook 'w3m-mode-hook 'w3m-register-desktop-save)

	(defun w3m-restore-desktop-buffer (d-b-file-name d-b-name d-b-misc)
	  "Restore a `w3m' buffer on `desktop' load."
	  (when (eq 'w3m-mode desktop-buffer-major-mode)
		(let ((url d-b-misc))
		  (when url
			(require 'w3m)
			(if (string-match "^file" url)
                (call-when-defined 'w3m-find-file (substring url 7))
			  (call-when-defined 'w3m-goto-url-new-session url))
			(current-buffer)))))
	(add-to-list 'desktop-buffer-mode-handlers
                 '(w3m-mode . w3m-restore-desktop-buffer))))
  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                         Dictionary                           ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(cond
 ((executable-find "sdcv")
  (use-package sdcv
	:bind ("C-c d" . sdcv-search-input)))
 ((executable-find "ydcv")
  (use-package youdao-dictionary
	:bind
    ("C-c d" . youdao-dictionary-search-from-input))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Image+                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Image processing
(when (executable-find "convert")
  :ensure
  (use-package image+
	:init
	(add-hook 'after-init-hook 'imagex-global-sticky-mode)
    ;; Stop showing annoying warnings.
    (setq imagex-quiet-error t)
    ;; Use feh to view image externally.
    (setq image-dired-external-viewer "feh")

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
	  (interactive)
	  (if (yes-or-no-p "File will be deleted forever. Continue? ")
		  (let ((file-to-delete (buffer-file-name)))
			(image-next-file)
			(delete-file file-to-delete)
			(message "File deleted."))
		(message "Aborted.")))

	:bind
    (:map image-mode-map
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
	
	:config
	(add-hook 'imagex-sticky-mode-hook 'imagex-auto-adjust-mode)))

;;; c3-external.el ends here
