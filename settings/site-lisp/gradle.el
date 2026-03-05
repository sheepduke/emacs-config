(require 'comint)

;; ============================================================
;;  Project
;; ============================================================

(defun gradle-find-project-root (&optional dir)
  "Locate Gradle root folder starting from DIR. A Gradle root folder
is the one containing settings.gradle or settings.gradle.kts.
Return the directory found, or nil."
  (let ((current (file-name-as-directory (or dir default-directory)))
        (found nil)
        (root nil))
    (while (and current (not found))
      (if (or (file-exists-p (expand-file-name "settings.gradle" current))
              (file-exists-p (expand-file-name "settings.gradle.kts" current)))
          (setq found t
                root current)
        ;; Try the parent directory.
        (let ((parent (file-name-directory (directory-file-name current))))
          (setq current (unless (or (null parent)
                                    (string= parent current))
                          parent)))))
    root))

;; ============================================================
;;  Comint
;; ============================================================

(define-derived-mode gradle-comint-mode comint-mode "Gradle"
  "Comint mode for Gradle tasks with syntax highlighting.")

(defvar gradle-comint-font-lock-keywords nil)
(setq gradle-comint-font-lock-keywords
      `(
        ;; Match Gradle keywords like 'BUILD SUCCESSFUL', 'BUILD FAILED'
        ("\\[[0-9]+-[0-9]+-[0-9]+.*" . font-lock-keyword-face)
        ("SKIPPED" . font-lock-comment-face)
        ("NO-SOURCE" . font-lock-comment-face)
        ("UP-TO-DATE" . font-lock-comment-face)
        ("BUILD SUCCESSFUL" . 'success)
        ("BUILD FAILED" . 'error)
        ;; Match warnings
        ("WARNING:.*" . 'warning)
        ;; Highlight task names (e.g., :compileKotlin, :test)
        ("Task \\(:[a-zA-Z0-9_:.-]+\\)" . font-lock-constant-face)))
  
(defun gradle-comint-mode-setup ()
  "Setup Gradle comint mode with font-lock keywords."
  (font-lock-add-keywords nil gradle-comint-font-lock-keywords)
  (font-lock-mode 1))

(defun gradle-get-shell-buffer ()
  "Return the name of the dedicated Gradle output buffer for the current project.
Does not create the buffer."
  (let ((root (gradle-find-project-root)))
    (unless root
      (error "Not inside a Gradle project"))
    (format "*gradle %s*" (file-name-nondirectory (directory-file-name root)))))

(defun gradle-run-task (task)
  "Run a Gradle TASK in a comint buffer.
Each command prints timestamp, the command itself, and separators.
The buffer is displayed but does not take focus, and always scrolls to the latest output."
  (let* ((buffer-name (gradle-get-shell-buffer))
         (root (gradle-find-project-root))
         (buf (get-buffer-create buffer-name))
         (time-str (format-time-string "%Y-%m-%d %H:%M:%S")))
    ;; Initialize comint if not already
    (unless (comint-check-proc buf)
      (with-current-buffer buf
        (cd root)
        (insert (gradle-make-buffer-separator)
                "\n"
                (format "[%s] Running: gradle %s" time-str task)
                "\n")
        (make-comint-in-buffer "gradle" buf "gradle" nil "--console=plain" task)
        (gradle-comint-mode)
        (gradle-comint-mode-setup)))

    ;; Display the buffer.
    (display-buffer buf '(nil (allow-no-window . t) (inhibit-same-window . nil)))))

(defun gradle-make-buffer-separator (&optional char)
  "Return a horizontal separator line matching the buffer width.
CHAR is the character to repeat; defaults to '─' (UTF-8)."
  (let ((c (or char ?─)))  ;; default to Unicode horizontal line
    (make-string (- (window-body-width) 10) c)))

(defun gradle-run ()
  "Runs this project as a JVM application."
  (interactive)
  (gradle-run-task "run"))

(defun gradle-list-tasks ()
  "Return an alist of Gradle tasks suitable for completing-read.
Each element is (DISPLAY . VALUE), where DISPLAY includes description
and VALUE is the actual task name."
  (let ((root (gradle-find-project-root)))
    (unless root (error "Not inside a Gradle project"))
    (with-temp-buffer
      (let ((default-directory root)
            tasks)
        ;; Run `gradle tasks --all` and capture output
        (call-process "gradle" nil t nil "tasks" "--all")
        ;; Skip header lines until first empty line
        (goto-char (point-min))
        (while (and (not (eobp))
                    (not (looking-at-p "^\\s-*$")))
          (forward-line 1))
        ;; Collect lines that start with a letter and match "Xxx - Xxx" pattern
        (while (not (eobp))
          (forward-line 1)
          (let ((line (string-trim (thing-at-point 'line t))))
            (when (string-match "^\\([a-zA-Z][a-zA-Z0-9_:.-]*\\)\\s-*-\\s-*\\(.*\\)$" line)
              ;; (DISPLAY . VALUE)
              (push (cons line (match-string 1 line)) tasks))))
        (nreverse tasks)))))

(defun gradle-select-task (&optional task-list)
  "Prompt the user to select a Gradle task and return its name.
TASK-LIST should be a list of strings; if nil, call `gradle-list-tasks`."
  (interactive)
  (let* ((tasks (or task-list (gradle-list-tasks)))  ; fetch if not provided
         (chosen (completing-read "Gradle task: " tasks nil t)))
    chosen))

(provide 'gradle)
