(require 'sbt-mode)

(defun sbt-plus-buffer-name ()
  "Get sbt buffer name."
  (sbt:buffer-name))

(defun sbt-plus-send-string (string)
  "Send given STRING to sbt console and execute it."
  (with-current-buffer (sbt-plus-buffer-name)
    (insert string)
    (comint-send-input)))

(defun sbt-plus-enter-repl ()
  "Enter Scala REPL."
  (interactive)
  (sbt-plus-send-string "console"))

(defun sbt-plus-leave-repl ()
  "Leave Scala REPL."
  (interactive)
  (sbt-plus-send-string ":q"))

(defun sbt-plus-send-line ()
  "Send current line to sbt and execute it."
  (interactive)
  (sbt-plus-send-string (string-trim (thing-at-point 'line t))))

(defun sbt-plus-send-region (start end)
  "Send a region to REPL and evaluate it."
  (interactive "r")
  (let ((content (buffer-substring start end)))
    (with-current-buffer (sbt-plus-buffer-name)
      (insert content)
      (comint-send-input))))

(defun sbt-plus-send-line-or-region ()
  "Send a region to REPL if the region is active, send a line otherwise."
  (interactive)
  (call-interactively (if (region-active-p)
                          #'sbt-plus-send-region
                        #'sbt-plus-send-line)))

(defun sbt-plus-send-buffer ()
  "Send a buffer to REPL and evaluate it."
  (interactive)
  (sbt-plus-send-region (point-min) (point-max)))

(defun sbt-plus-do-reload ()
  "Send reload command."
  (interactive)
  (sbt-plus-send-string "reload"))

(defun sbt-plus-do-restart ()
  "Send reStart command from spray plugin."
  (interactive)
  (sbt-plus-send-string "reStart"))

(defun sbt-plus-do-assembly ()
  "Send assembly command from spray plugin."
  (interactive)
  (sbt-plus-send-string "assembly"))

(provide 'sbt-plus)
