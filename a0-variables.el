;;; Package --- Summary
;;; This contains global variables.

;;; Commentary:

;;; Code:

(defvar *settings-path* "~/.emacs.d/settings/")

(defvar *plugins-path* (concat *settings-path* "plugins/"))

(defvar *data-path* "~/.emacs.d/data/"
  "Location of Emacs data.")

(defvar *notes-path* "~/notes/"
  "Location for Org Mode notes.")

(defvar after-load-theme-hook nil
  "Hook run after a color theme is loaded using `load-theme'.")

(defadvice load-theme (after run-after-load-theme-hook activate)
  "Run `after-load-theme-hook' to ensure that theme from last-time is loaded."
  (run-hooks 'after-load-theme-hook))

;;; a0-variables.el ends here
