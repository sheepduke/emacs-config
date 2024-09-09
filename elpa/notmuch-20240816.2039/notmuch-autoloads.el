;;; notmuch-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:

(add-to-list 'load-path (or (and load-file-name (directory-file-name (file-name-directory load-file-name))) (car load-path)))



;;; Generated autoloads from coolj.el

(register-definition-prefixes "coolj" '("coolj-"))


;;; Generated autoloads from make-deps.el

(register-definition-prefixes "make-deps" '("batch-make-deps" "make-deps"))


;;; Generated autoloads from notmuch.el

(autoload 'notmuch-search "notmuch" "\
Display threads matching QUERY in a notmuch-search buffer.

If QUERY is nil, it is read interactively from the minibuffer.
Other optional parameters are used as follows:

  OLDEST-FIRST: A Boolean controlling the sort order of returned threads
  HIDE-EXCLUDED: A boolean controlling whether to omit threads with excluded
                 tags.
  TARGET-THREAD: A thread ID (without the thread: prefix) that will be made
                 current if it appears in the search results.
  TARGET-LINE: The line number to move to if the target thread does not
               appear in the search results.
  NO-DISPLAY: Do not try to foreground the search results buffer. If it is
              already foregrounded i.e. displayed in a window, this has no
              effect, meaning the buffer will remain visible.

When called interactively, this will prompt for a query and use
the configured default sort order.

(fn &optional QUERY OLDEST-FIRST HIDE-EXCLUDED TARGET-THREAD TARGET-LINE NO-DISPLAY)" t)
(autoload 'notmuch "notmuch" "\
Run notmuch and display saved searches, known tags, etc." t)
(autoload 'notmuch-cycle-notmuch-buffers "notmuch" "\
Cycle through any existing notmuch buffers (search, show or hello).

If the current buffer is the only notmuch buffer, bury it.
If no notmuch buffers exist, run `notmuch'." t)
(register-definition-prefixes "notmuch" '("notmuch-"))


;;; Generated autoloads from notmuch-address.el

(register-definition-prefixes "notmuch-address" '("notmuch-address-"))


;;; Generated autoloads from notmuch-company.el

(autoload 'notmuch-company-setup "notmuch-company")
(autoload 'notmuch-company "notmuch-company" "\
`company-mode' completion back-end for `notmuch'.

(fn COMMAND &optional ARG &rest IGNORE)" t)
(register-definition-prefixes "notmuch-company" '("notmuch-company-last-prefix"))


;;; Generated autoloads from notmuch-compat.el

(register-definition-prefixes "notmuch-compat" '("notmuch-"))


;;; Generated autoloads from notmuch-crypto.el

(register-definition-prefixes "notmuch-crypto" '("notmuch-crypto-"))


;;; Generated autoloads from notmuch-draft.el

(register-definition-prefixes "notmuch-draft" '("notmuch-draft-"))


;;; Generated autoloads from notmuch-hello.el

(autoload 'notmuch-hello "notmuch-hello" "\
Run notmuch and display saved searches, known tags, etc.

(fn &optional NO-DISPLAY)" t)
(register-definition-prefixes "notmuch-hello" '("notmuch-"))


;;; Generated autoloads from notmuch-jump.el

(autoload 'notmuch-jump-search "notmuch-jump" "\
Jump to a saved search by shortcut key.

This prompts for and performs a saved search using the shortcut
keys configured in the :key property of `notmuch-saved-searches'.
Typically these shortcuts are a single key long, so this is a
fast way to jump to a saved search from anywhere in Notmuch." t)
(autoload 'notmuch-jump "notmuch-jump" "\
Interactively prompt for one of the keys in ACTION-MAP.

Displays a summary of all bindings in ACTION-MAP in the
minibuffer, reads a key from the minibuffer, and performs the
corresponding action.  The prompt can be canceled with C-g or
RET.  PROMPT must be a string to use for the prompt.  PROMPT
should include a space at the end.

ACTION-MAP must be a list of triples of the form
  (KEY LABEL ACTION)
where KEY is a key binding, LABEL is a string label to display in
the buffer, and ACTION is a nullary function to call.  LABEL may
be null, in which case the action will still be bound, but will
not appear in the pop-up buffer.

(fn ACTION-MAP PROMPT)")
(register-definition-prefixes "notmuch-jump" '("notmuch-jump-"))


;;; Generated autoloads from notmuch-lib.el

(register-definition-prefixes "notmuch-lib" '("notmuch-"))


;;; Generated autoloads from notmuch-maildir-fcc.el

(register-definition-prefixes "notmuch-maildir-fcc" '("notmuch-" "with-temporary-notmuch-message-buffer"))


;;; Generated autoloads from notmuch-message.el

(register-definition-prefixes "notmuch-message" '("notmuch-message-"))


;;; Generated autoloads from notmuch-mua.el

(autoload 'notmuch-mua-mail "notmuch-mua" "\
Invoke the notmuch mail composition window.

The position of point when the function returns differs depending
on the values of TO and SUBJECT.  If both are non-nil, point is
moved to the message's body.  If SUBJECT is nil but TO isn't,
point is moved to the \"Subject:\" header.  Otherwise, point is
moved to the \"To:\" header.

(fn &optional TO SUBJECT OTHER-HEADERS CONTINUE SWITCH-FUNCTION YANK-ACTION SEND-ACTIONS RETURN-ACTION &rest IGNORED)" t)
(autoload 'notmuch-mua-send-and-exit "notmuch-mua" "\


(fn &optional ARG)" t)
(autoload 'notmuch-mua-send "notmuch-mua" "\


(fn &optional ARG)" t)
(autoload 'notmuch-mua-kill-buffer "notmuch-mua" nil t)
(define-mail-user-agent 'notmuch-user-agent 'notmuch-mua-mail 'notmuch-mua-send-and-exit 'notmuch-mua-kill-buffer 'notmuch-mua-send-hook)
(register-definition-prefixes "notmuch-mua" '("notmuch-"))


;;; Generated autoloads from notmuch-parser.el

(register-definition-prefixes "notmuch-parser" '("notmuch-sexp-"))


;;; Generated autoloads from notmuch-print.el

(register-definition-prefixes "notmuch-print" '("notmuch-print-"))


;;; Generated autoloads from notmuch-query.el

(register-definition-prefixes "notmuch-query" '("notmuch-query-"))


;;; Generated autoloads from notmuch-show.el

(autoload 'notmuch-show "notmuch-show" "\
Run \"notmuch show\" with the given thread ID and display results.

ELIDE-TOGGLE, if non-nil, inverts the default elide behavior.

The optional PARENT-BUFFER is the notmuch-search buffer from
which this notmuch-show command was executed, (so that the
next thread from that buffer can be show when done with this
one).

The optional QUERY-CONTEXT is a notmuch search term. Only
messages from the thread matching this search term are shown if
non-nil.

The optional BUFFER-NAME provides the name of the buffer in
which the message thread is shown. If it is nil (which occurs
when the command is called interactively) the argument to the
function is used.

Returns the buffer containing the messages, or NIL if no messages
matched.

(fn THREAD-ID &optional ELIDE-TOGGLE PARENT-BUFFER QUERY-CONTEXT BUFFER-NAME)" t)
(register-definition-prefixes "notmuch-show" '("notmuch-" "with-current-notmuch-show-message"))


;;; Generated autoloads from notmuch-tag.el

(register-definition-prefixes "notmuch-tag" '("notmuch-"))


;;; Generated autoloads from notmuch-tree.el

(autoload 'notmuch-tree "notmuch-tree" "\
Display threads matching QUERY in tree view.

The arguments are:
  QUERY: the main query. This can be any query but in many cases will be
      a single thread. If nil this is read interactively from the minibuffer.
  QUERY-CONTEXT: is an additional term for the query. The query used
      is QUERY and QUERY-CONTEXT unless that does not match any messages
      in which case we fall back to just QUERY.
  TARGET: A message ID (with the id: prefix) that will be made
      current if it appears in the tree view results.
  BUFFER-NAME: the name of the buffer to display the tree view. If
      it is nil \"*notmuch-tree\" followed by QUERY is used.
  OPEN-TARGET: If TRUE open the target message in the message pane.
  UNTHREADED: If TRUE only show matching messages in an unthreaded view.

(fn &optional QUERY QUERY-CONTEXT TARGET BUFFER-NAME OPEN-TARGET UNTHREADED PARENT-BUFFER OLDEST-FIRST HIDE-EXCLUDED)" t)
(register-definition-prefixes "notmuch-tree" '("notmuch-"))


;;; Generated autoloads from notmuch-wash.el

(register-definition-prefixes "notmuch-wash" '("notmuch-wash-"))


;;; Generated autoloads from rstdoc.el

(register-definition-prefixes "rstdoc" '("rst"))

;;; End of scraped data

(provide 'notmuch-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; notmuch-autoloads.el ends here
