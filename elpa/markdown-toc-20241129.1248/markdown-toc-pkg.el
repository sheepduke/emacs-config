;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "markdown-toc" "20241129.1248"
  "A simple TOC generator for markdown file."
  '((s             "1.9.0")
    (dash          "2.11.0")
    (markdown-mode "2.1"))
  :url "https://github.com/ardumont/markdown-toc"
  :commit "ba74a85ec94a638054ee65cbc8d95581946d018b"
  :revdesc "ba74a85ec94a"
  :keywords '("markdown" "toc" "tools")
  :authors '(("Antoine R. Dumont" . "(@ardumont)"))
  :maintainers '(("Antoine R. Dumont" . "(@ardumont)")
                 ("Jen-Chieh Shen" . "jcs090218@gmail.com")))
