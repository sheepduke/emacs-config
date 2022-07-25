(require 'sbt-mode)

(defun sbt-anywhere-buffer-name ()
  "Get sbt buffer name."
  (sbt:buffer-name))

(defun sbt-anywhere-send-string (string)
  "Send given STRING to sbt console and execute it."
  (with-current-buffer (sbt-anywhere-buffer-name)
    (insert string)
    (comint-send-input)))

(defun sbt-anywhere-enter-repl ()
  "Enter Scala REPL."
  (interactive)
  (sbt-anywhere-send-string "console"))

(defun sbt-anywhere-leave-repl ()
  "Leave Scala REPL."
  (interactive)
  (sbt-anywhere-send-string ":q"))

(defun sbt-anywhere-send-line ()
  "Send current line to sbt and execute it."
  (interactive)
  (sbt-anywhere-send-string (string-trim (thing-at-point 'line t))))

(defun sbt-anywhere-send-region (start end)
  "Send a region to REPL and evaluate it."
  (interactive "r")
  (let ((content (buffer-substring start end)))
    (with-current-buffer (sbt-anywhere-buffer-name)
      (insert content)
      (comint-send-input))))

(defun sbt-anywhere-send-buffer ()
  "Send a buffer to REPL and evaluate it."
  (interactive)
  (sbt-anywhere-send-region (point-min) (point-max)))

(defun sbt-anywhere-do-restart ()
  "Send reStart command from spray plugin."
  (interactive)
  (sbt-anywhere-send-string "reStart"))

(provide 'sbt-anywhere)
