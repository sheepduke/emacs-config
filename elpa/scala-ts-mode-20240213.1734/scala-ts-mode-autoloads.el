;;; scala-ts-mode-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:

(add-to-list 'load-path (or (and load-file-name (directory-file-name (file-name-directory load-file-name))) (car load-path)))



;;; Generated autoloads from scala-ts-mode.el

(autoload 'scala-ts-mode "scala-ts-mode" "\
Major mode for Scala files using tree-sitter.

(fn)" t)
(add-to-list 'auto-mode-alist '("\\.scala\\'" . scala-ts-mode))
(add-to-list 'auto-mode-alist '("\\.sc\\'" . scala-ts-mode))
(add-to-list 'auto-mode-alist '("\\.sbt\\'" . scala-ts-mode))
(register-definition-prefixes "scala-ts-mode" '("scala-ts-"))

;;; End of scraped data

(provide 'scala-ts-mode-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; scala-ts-mode-autoloads.el ends here
