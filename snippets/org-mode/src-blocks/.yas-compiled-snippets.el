;;; Compiled snippets and support files for `src-blocks'
;;; Snippet definitions:
;;;
(yas-define-snippets 'src-blocks
                     '(("<sl"
                        (progn
                          (yas-expand-snippet
                           (scimax-get-src-block-with-lang-snippet)))
                        "src block and language choice" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/src-blocks/src-with-lang"
                        nil nil)
                       ("<sh" "#+BEGIN_SRC sh\n$0\n#+END_SRC\n" "shell" nil nil
                        nil
                        "/Users/niels/.emacs.d/snippets/org-mode/src-blocks/shell"
                        nil nil)
                       ("sbh"
                        (progn
                          (yas-expand-snippet
                           (scimax-get-src-header-val-snippet)))
                        "src-block-header and value" (org-in-src-block-p) nil
                        nil
                        "/Users/niels/.emacs.d/snippets/org-mode/src-blocks/sbh"
                        nil nil)
                       ("<p" "#+BEGIN_SRC python\n$0\n#+END_SRC\n" "python" nil
                        nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/src-blocks/python"
                        nil nil)
                       ("<j"
                        "#+BEGIN_SRC jupyter-python :session python\n$0\n#+END_SRC\n"
                        "jupyter-python" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/src-blocks/jupyter"
                        nil nil)
                       ("<ip" "#+BEGIN_SRC ipython\n$0\n#+END_SRC\n" "ipython"
                        nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/src-blocks/ipython"
                        nil nil)
                       ("<ell"
                        "#+BEGIN_SRC emacs-lisp :lexical t\n$0\n#+END_SRC\n"
                        "emacs-lisp with :lexical t" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/src-blocks/emacs-lisp-lexical"
                        nil nil)
                       (">el" "#+BEGIN_SRC emacs-lisp\n$0\n#+END_SRC\n"
                        "emacs-lisp" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/src-blocks/emacs-lisp"
                        nil nil)))


;;; Do not edit! File generated at Fri Jan  3 16:50:43 2025
