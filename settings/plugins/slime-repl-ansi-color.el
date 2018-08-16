(require 'ansi-color)
(require 'slime)

(define-slime-contrib slime-repl-ansi-color
  "Turn on ANSI colors in REPL output"
  (:authors "Max Mikhanosha")
  (:license "GPL")
  (:slime-dependencies slime-repl))

(defadvice slime-repl-emit (around slime-repl-ansi-colorize activate compile)
  (with-current-buffer (slime-output-buffer)
    (let ((start slime-output-start))
      (setq ad-return-value ad-do-it)
      (ansi-color-apply-on-region start slime-output-end))))

(provide 'slime-repl-ansi-color)
