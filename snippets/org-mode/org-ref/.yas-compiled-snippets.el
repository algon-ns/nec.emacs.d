;;; Compiled snippets and support files for `org-ref'
;;; Snippet definitions:
;;;
(yas-define-snippets 'org-ref
                     '(("ref"
                        "ref:${1:$$(completing-read \"label: \" (org-ref-get-labels))}"
                        "org-ref ref link with completion" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ref/ref"
                        nil nil)
                       ("cite"
                        "cite:${1:$$(completing-read\n       \"bibtex key: \"\n       (let ((bibtex-files (org-ref-find-bibliography)))\n	 (bibtex-global-key-alist)))}"
                        "org-ref cite link" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ref/cite"
                        nil nil)
                       ("bs"
                        "bibliographystyle:${1:$$(yas-choose-value scimax-installed-bibliography-styles)}"
                        "org-ref bibliographystyle" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ref/bibliographystyle"
                        nil nil)
                       ("bib"
                        "bibliography:${1:$$(yas-choose-value (org-ref-find-bibliography))}"
                        "bibliography with completion" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ref/bibliography"
                        nil nil)))


;;; Do not edit! File generated at Fri Jan  3 16:50:43 2025
