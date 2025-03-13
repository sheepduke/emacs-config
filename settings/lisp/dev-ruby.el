(use-package ruby-mode
  :ensure
  :config
  (defun ruby-insert-end ()
    "Insert `end' accordingly."
    (interactive)
    (let ((text (save-excursion
                  (forward-line 0)
                  (if (looking-at "^[ \t]*$")
                      "end"
                    (if (looking-at ".*{[^}]*$")
                        "\n}"
                      "\nend")))))
      (insert text)
      (indent-region (line-beginning-position)
                     (line-end-position))))

  :bind (:map ruby-mode-map
              ("C-c C-f" . ruby-insert-end)
              ("C-c b" . ruby-send-buffer)))
