;;; Compiled snippets and support files for `blocks'
;;; Snippet definitions:
;;;
(yas-define-snippets 'blocks
                     '(("<V"
                        "#+BEGIN_VERSE\n${1:`(if (region-active-p) (yas-selected-text) \"replace. Tab to end.\")`}\n#+END_VERSE"
                        "verse-block" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/blocks/verse-block"
                        nil nil)
                       ("<w"
                        "#+BEGIN_VERBATIM\n${1:`(if (region-active-p) (yas-selected-text) \"replace. Tab to end.\")`}\n#+END_VERBATIM"
                        "verbatim-block" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/blocks/verbatim-block"
                        nil nil)
                       ("<s" "#+BEGIN_SRC $0\n\n#+END_SRC" "src-block" nil nil
                        nil
                        "/Users/niels/.emacs.d/snippets/org-mode/blocks/src-block"
                        nil nil)
                       ("<q"
                        "#+BEGIN_QUOTE\n${1:`(if (region-active-p) (yas-selected-text) \"replace. Tab to end.\")`}\n#+END_QUOTE\n$0"
                        "quote-block" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/blocks/quote-block"
                        nil nil)
                       ("aii"
                        "#+begin_ai :image :size ${1:$$(yas/choose-value '(\"256x256\" \"512x512\" \"1024x1024\"))}\n$0\n#+end_ai"
                        "org-ai-image" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/blocks/org-ai-image"
                        nil nil)
                       ("ai"
                        "#+begin_ai\n${1:[SYS]: ${2:You are a helpful assistant.}\n\n}[ME]: $0\n#+end_ai\n"
                        "org-ai-block" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/blocks/org-ai-block"
                        nil nil)
                       ("<l"
                        "#+BEGIN_EXPORT latex\n${1:`(if (region-active-p) (yas-selected-text) \"replace. Tab to end.\")`}\n#+END_EXPORT"
                        "latex-block" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/blocks/latex-block"
                        nil nil)
                       ("<h"
                        "#+BEGIN_EXPORT html\n${1:`(if (region-active-p) (yas-selected-text) \"replace. Tab to end.\")`}\n#+END_EXPORT"
                        "html-block" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/blocks/html-block"
                        nil nil)
                       ("<e"
                        "#+BEGIN_EXAMPLE\n${1:`(if (region-active-p) (yas-selected-text) \"replace. Tab to end.\")`}\n#+END_EXAMPLE\n$0"
                        "example-block" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/blocks/example-block"
                        nil nil)
                       ("<C"
                        "#+BEGIN_COMMENT\n${1:`(if (region-active-p) (yas-selected-text) \"replace. Tab to end.\")`}\n#+END_COMMENT"
                        "comment-block" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/blocks/comment-block"
                        nil nil)))


;;; Do not edit! File generated at Fri Jan  3 16:50:43 2025
