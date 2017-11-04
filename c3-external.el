;;; Package --- Summary
;;; 
;;; Commentary:
;;; This file contains functions that need external tool support.
;;;
;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               emms                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package emms
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

(when (executable-find "mpv")
  (use-package emms-player-mpv
    :after emms
    :config
    (add-to-list 'emms-player-list 'emms-player-mpv)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               w3m                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (executable-find "w3m")
  (use-package w3m
	:init
	(setq w3m-home-page "about://bookmark"
		  ;; Images
		  w3m-toggle-inline-images-permanently t
		  w3m-default-display-inline-images t
		  ;; Cookies
		  w3m-use-cookies t
		  w3m-cookie-accept-bad-cookies t
		  ;; Sessions
		  w3m-session-load-last-sessions t
		  w3m-new-session-in-background nil
		  w3m-session-time-format "%Y-%m-%d %A %H:%M"
		  ;; Cache
		  w3m-favicon-use-cache-file t
		  w3m-keep-arrived-urls 5000
		  w3m-keep-cache-size 1000
		  ;; Don't ask me if I'm leaving secure page.
		  w3m-confirm-leaving-secure-page nil
		  ;; Storage
		  w3m-default-save-directory (concat *data-path* "w3m/saved/")
		  w3m-bookmark-file (concat *data-path* "w3m/bookmark.html"))

	:bind (("C-c 3" . w3m)
		   :map w3m-mode-map
		   ("C-M-h" . w3m-previous-buffer)
		   ("C-M-l" . w3m-next-buffer)
		   ("h" . w3m-db-history))

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
				(w3m-find-file (substring url 7))
			  (w3m-goto-url-new-session url))
			(current-buffer)))))
	(add-to-list 'desktop-buffer-mode-handlers '(w3m-mode . w3m-restore-desktop-buffer)))

  (use-package w3m-search
	:config
	(setq w3m-search-default-engine "duckduckgo")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           Dictionary                             ;;
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
;;                            Image+                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Image processing
(when (executable-find "convert")
  (use-package image+
	:init
	(add-hook 'after-init-hook 'imagex-global-sticky-mode)

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
