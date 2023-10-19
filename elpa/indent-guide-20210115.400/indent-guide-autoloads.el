;;; indent-guide-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:

(add-to-list 'load-path (or (and load-file-name (directory-file-name (file-name-directory load-file-name))) (car load-path)))



;;; Generated autoloads from indent-guide.el

(autoload 'indent-guide-mode "indent-guide" "\
show vertical lines to guide indentation

This is a minor mode.  If called interactively, toggle the
`Indent-Guide mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `indent-guide-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

(fn &optional ARG)" t)
(put 'indent-guide-global-mode 'globalized-minor-mode t)
(defvar indent-guide-global-mode nil "\
Non-nil if Indent-Guide-Global mode is enabled.
See the `indent-guide-global-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `indent-guide-global-mode'.")
(custom-autoload 'indent-guide-global-mode "indent-guide" nil)
(autoload 'indent-guide-global-mode "indent-guide" "\
Toggle Indent-Guide mode in all buffers.
With prefix ARG, enable Indent-Guide-Global mode if ARG is positive;
otherwise, disable it.

If called from Lisp, toggle the mode if ARG is `toggle'.
Enable the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

Indent-Guide mode is enabled in all buffers where `(lambda nil (unless
(cl-some 'derived-mode-p indent-guide-inhibit-modes)
(indent-guide-mode 1)))' would do it.

See `indent-guide-mode' for more information on Indent-Guide mode.

(fn &optional ARG)" t)
(register-definition-prefixes "indent-guide" '("indent-guide-"))

;;; End of scraped data

(provide 'indent-guide-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; indent-guide-autoloads.el ends here
