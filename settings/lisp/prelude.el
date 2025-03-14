(defun windows? ()
  "Return T if current OS is Windows."
  (equal system-type 'windows-nt))

(defun wsl? ()
  "Return T if current OS is WSL(2)."
  (string-match "-[Mm]icrosoft" (shell-command-to-string "uname -a")))

(defun linux? ()
  "Return T if current OS is Linux."
  (equal system-type 'gnu/linux))

(defun x? ()
  "Return TRUE if we are under X system."
  (getenv "DISPLAY"))

(defun locate-user-data-file (new-name &optional old-name)
  (expand-file-name
   (locate-user-emacs-file
    (concat "settings/data/" new-name)
    (if old-name (concat "settings/data/" old-name) nil))))

(defun save-buffer-readonly ()
  "If buffer is read-only, temporally change its permission and write to it.
This works like Vim 'w!'."
  (interactive)
  (let* ((filename (buffer-file-name))
         (original-file-modes (file-modes (buffer-file-name))))
    (condition-case nil
        (save-buffer)
      (error (set-file-modes filename (+ original-file-modes #o222))
             (save-buffer)
             (set-file-modes filename original-file-modes)))))

(defun kill-current-buffer ()
  "Kill current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(defun switch-to-other-buffer ()
  "Switch between 2 buffers."
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun toggle-window-dedicated ()
  "Toggle whether the current active window is dedicated or not.
A dedicated window can't be switched or modified by some commands."
  (interactive)
  (message
   (if (let (window (get-buffer-window (current-buffer)))
         (set-window-dedicated-p window
                                 (not (window-dedicated-p window))))
       "Window '%s' is dedicated"
     "Window '%s' is normal")
   (current-buffer)))

(defun line-in-comment? ()
  "Return T if current line is commented."
  (nth 4 (syntax-ppss)))

(defun smart-newline ()
  "Insert comment to next line if current line is commented."
  (interactive)
  (if (line-in-comment?)
      (default-indent-new-line)
    (newline-and-indent)))
