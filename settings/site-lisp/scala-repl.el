(defgroup scala-repl nil
  "Group for Scala REPL."
  :group 'scala)

(defcustom scala-repl-buffer-basename "Scala REPL"
  "Buffer name for Scala REPL process."
  :type 'string
  :group 'scala-repl)

(defcustom scala-repl-console-type 'vanilla
  "Use Ammonite instead of vanilla REPL."
  :type 'symbol
  :group 'scala-repl)

(defcustom scala-repl-command-alist
  '(((mill . vanilla) "mill" "-i" "_.console")
    ((mill . ammonite) "mill" "-i" "_.repl")
    ((sbt . vanilla) "sbt" "console")
    ((nil . vanilla) "scala-cli" "repl" "-deprecation")
    ((nil . ammonite) "amm"))
  "The alist of REPL commands."
  :group 'scala-repl)

(defun scala-repl-run (&optional prefix)
  "Run the REPL and show it in a new window."
  (interactive "P")
  (scala-repl--detach)
  (if (and prefix (> (car prefix) 0))
      (call-interactively 'scala-repl-run-custom)
    (switch-to-buffer-other-window (scala-repl--ensure-session-buffer)))
  (message "REPL running. Happy hacking"))

(defun scala-repl-run-custom (&optional command)
  "Just run the REPL with custom commands under current directory."
  (interactive "MREPL command: ")
  (let* ((command (string-trim command))
         (space-position (cl-position ?\s command))
         (program (if space-position
                      (substring command 0 space-position)
                    command))
         (switches (if space-position
                       (split-string-and-unquote (substring command (1+ space-position)))
                     nil)))
    (comint-run program switches)))

(defun scala-repl-attach (&optional buffer-name)
  "Attach current buffer to the"
  (interactive "bChoose REPL Buffer:")
  (setq-local scala-repl-buffer-name buffer-name)
  (message "REPL %s attached" buffer-name))

(defun scala-repl-detach ()
  "Detach current buffer from any REPL buffer."
  (interactive)
  (scala-repl--detach)
  (message "REPL detached"))

(defun scala-repl-restart ()
  "Restart the REPL session."
  (interactive)
  (let* ((buffer-name (scala-repl--ensure-session-buffer))
         (process (get-buffer-process buffer-name)))
    (while (process-live-p process)
      (kill-process process)))
  (message "Restarting REPL...")
  (scala-repl--ensure-session-buffer))

(defun scala-repl-clear ()
  "Clear the REPL buffer."
  (interactive)
  (let* ((buffer-name (scala-repl--ensure-session-buffer)))
    (with-current-buffer buffer-name
      (comint-clear-buffer))))

(defun scala-repl-save-and-load ()
  "Load the file corresponding to current buffer."
  (interactive)
  (save-buffer)
  (if (scala-repl--ensure-project-root)
      (message "Not implemented yet.")
    (scala-repl-eval-raw-string (format ":load %s\n" (buffer-name)))))

(defun scala-repl-load-file (&optional file-name)
  "Load the file into REPL using `:load' command."
  (interactive "MLoad file: ")
  (scala-repl-eval-raw-string (format ":load %s\n" (file-name))))

(defun scala-repl-eval-current-line ()
  "Send current line to the REPL and evaluate it."
  (interactive)
  (scala-repl-eval-string (thing-at-point 'line)))

(defun scala-repl-eval-buffer ()
  "Send current buffer to the REPL and evaluate it."
  (interactive)
  (scala-repl-eval-string (buffer-string)))

(defun scala-repl-eval-region ()
  "Send selected region to the REPL and evaluate it."
  (interactive)
  (if (region-active-p)
      (let ((buffer-name (scala-repl--ensure-session-buffer)))
        (scala-repl-eval-string (buffer-substring (region-beginning)
                                                  (region-end))))
    (message "Region not active")))

(defun scala-repl--ensure-session-buffer ()
  (if (and (boundp 'scala-repl-buffer-name)
           (process-live-p (get-buffer-process scala-repl-buffer-name)))
      scala-repl-buffer-name
    (let* ((project-type-root (scala-repl--ensure-project-root))
           (project-type (car project-type-root))
           (project-root (or (cdr project-type-root)
                             (expand-file-name ".")))
           (buffer-name (scala-repl--get-buffer-name project-type project-root))
           (command (scala-repl--get-command project-type)))
      (let ((default-directory project-root))
        (apply 'make-comint-in-buffer buffer-name buffer-name (car command) nil (cdr command)))
      buffer-name)))

(defun scala-repl-eval-string (&optional string)
  "Quote given string in braces, send it to the REPL and evaluate it."
  (interactive "MEval: ")
  (save-excursion
    (let* ((buffer-name (scala-repl--ensure-session-buffer)))
      (comint-send-string buffer-name (format "{\n%s}\n" string)))))

(defun scala-repl-eval-raw-string (&optional string)
  "Send given raw string to the REPL and evaluate it."
  (interactive "MEval: ")
  (save-excursion
    (let* ((buffer-name (scala-repl--ensure-session-buffer)))
      (comint-send-string buffer-name string))))

(defun scala-repl--get-buffer-name (project-type project-root)
  (unless (boundp 'scala-repl-buffer-name)
    (setq-local scala-repl-buffer-name
                (if project-type
                    (format "*%s - %s*"
                            scala-repl-buffer-basename
                            (file-name-nondirectory project-root))
                  (format "*%s*" scala-repl-buffer-basename))))

  scala-repl-buffer-name)

(defun scala-repl--detach ()
  (interactive)
  (makunbound 'scala-repl-buffer-name))

(defun scala-repl--get-command (project-type)
  (cdr (assoc (cons project-type scala-repl-console-type)
              scala-repl-command-alist)))

(defun scala-repl--ensure-project-root ()
  (unless (boundp 'scala-repl-project-type-root)
    (setq-local scala-repl-project-type-root
                (scala-repl--locate-project-root ".")))
  scala-repl-project-type-root)

(defun scala-repl--locate-project-root (directory)
  (let ((directory (expand-file-name directory)))
    (if (string= directory "/")
        nil
      (cond
       ((directory-files (expand-file-name directory) t "build.sc") (cons 'mill directory))
       ((directory-files (expand-file-name directory) t "build.sbt") (cons 'sbt directory))
       ((directory-files (expand-file-name directory) t "project.scala") (cons 'scala-cli directory))
       (t (scala-repl--locate-project-root (expand-file-name (format "%s/.." directory))))))))

(provide 'scala-repl)
