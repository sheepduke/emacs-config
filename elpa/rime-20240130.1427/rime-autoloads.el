;;; rime-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:

(add-to-list 'load-path (or (and load-file-name (directory-file-name (file-name-directory load-file-name))) (car load-path)))



;;; Generated autoloads from rime.el

(defvar rime-title (char-to-string 12563) "\
The title of input method.")
(autoload 'rime-lighter "rime" "\
Return a lighter which can be used in mode-line.

The content is `rime-title'.

You can customize the color with `rime-indicator-face' and `rime-indicator-dim-face'.")
(autoload 'rime-activate "rime" "\
Activate rime.
Argument NAME ignored.

(fn NAME)")
(register-input-method "rime" "euc-cn" 'rime-activate rime-title)
(register-definition-prefixes "rime" '("rime-"))


;;; Generated autoloads from rime-predicates.el

(register-definition-prefixes "rime-predicates" '("rime-predicate-"))

;;; End of scraped data

(provide 'rime-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; rime-autoloads.el ends here