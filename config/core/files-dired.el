;; -*- lexical-binding: t; -*-

(use-package nerd-icons-dired
  :straight t
  :after nerd-icons
  :hook dired-mode)

(setq insert-directory-program (concat homebrew-prefix "bin/gls") dired-use-ls-dired t)

(use-package dired
  :ensure nil
  :straight nil
  ;;  :hook (dired-mode . dired-omit-mode)
  :config
  ;; Guess a default target directory
  (setq dired-dwim-target t)
  ;; Always delete and copy recursively
  (setq dired-recursive-deletes 'always
        dired-recursive-copies 'always)
  ;; Show directory first
  (setq dired-listing-switches "-alh --group-directories-first"))

(use-package dired-hacks
  :straight t)
(use-package dired-filter
  :straight t
  :init (dired-filter-mode t)
  :hook (dired-mode . (lambda () (dired-filter-group-mode))))
(setq dired-filter-group-saved-groups
      '(("default"
		 ("Directories" (directory))
		 ("macOS"  (extension  "pages" "key" "numbers" "plist" "ini"))   									   
		 ("Org"    (extension  "org" ))
		 ("bin"    (extension  "exe"  "o" "bin" "elc" ))		 		 
		 ("LaTeX"  (extension  "tex"))
		 ("Text"   (extension  "txt" "doc" "docx" "odt"))
		 ("PDF"    (extension  "pdf"))
		 ("Movie"  (extension  "mpeg" "mp4" "mov" ))
		 ("Music"  (extension  "mp3" "aac" "wma" "wav"))
		 ("Data"   (extension  "dat" "xml" "csv" "xls" "xlxs" "log"))								  
		 ("Images" (extension  "png" "jpg" "jpeg" "gif" "tiff" "svg"
							   "bmp" "icns"))
		 ("HTML"   (extension  "php" "htm" "html" "bib"))
		 ("Code"   (extension  "c" "h" "cc" "ftn" "hs" "agda" "lagda" "jar" "js"
							   "pl" "java" "el" "emacs-lisp" "py" "zsh" "sh" "swift"
							   "zsh" "bash" "json" "rb"))
		 ("Archives"(extension "zip" "rar" "gz" "bz2" "tar" "7z" )) )))

(setq dired-garbage-files-regexp
      "\\(?:\\.\\(?:aux\\|bak\\|dvi\\|rej\\|vrb\\|nav\\|snm\\|toc\\|bcf\\|log\\|upa\\|blg
       \\|fls\\|\\.idx\\|\\.run\\.xml$\\|\\.bbl$\\|\\.bcf$\\|.blg$\\|-blx.bib$\\|.nav$
       \\|.snm$\\|run.xml\\|fdb_latexmk\\|bbl\\|idx\\|ilg\\|ind\\|upb\\|out\\)\\)\\'")

(defun dired-get-size ()
  "Display file size in dired."
  (interactive)
  (let ((files (dired-get-marked-files)))
    (with-temp-buffer
      (apply 'call-process "/usr/bin/du" nil t nil "-sch" files)
      (message
       "Size of all marked files: %s"
       (progn
         (re-search-backward "\\(^[ 0-9.,]+[A-Za-z]+\\).*total$")
         (match-string 1))))))
;; https://oremacs.com/2015/01/12/dired-file-size/
(define-key dired-mode-map "z" #'dired-get-size)


(use-package dired-rainbow
  :straight t
  :config
  (progn
    (dired-rainbow-define-chmod directory "#6cb2eb" "d.*")
    (dired-rainbow-define-chmod executable-unix "#38c172" "-.*x.*"))
  (dired-rainbow-define database "#6574cd" ("xlsx" "xls" "csv" "accdb" "db" "mdb"
                                            "sqlite" "nc"))
  (dired-rainbow-define compiled "#4dc0b5" ("asm" "cl" "lisp" "el" "c" "h" "c++"
                                            "h++" "hpp" "hxx" "m" "cc" "cs" "cp"
                                            "cpp" "go" "f" "for" "ftn" "f90" "f95"
                                            "f03" "f08" "s" "rs" "hi" "hs" "pyc"
					    ".java"))
  (dired-rainbow-define compressed "#51d88a" ("7z" "zip" "bz2" "tgz" "txz" "gz"
                                              "xz" "z" "Z" "jar" "war" "ear" "rar"
                                              "sar" "xpi" "apk" "xz" "tar"))
  (dired-rainbow-define document "#9561e2" ("docm" "doc" "docx" "odb" "odt" "pdb"
                                            "pdf" "ps" "rtf" "djvu" "epub" "odp"
					    "ppt" "pptx"))
  (dired-rainbow-define encrypted "#ffed4a" ("gpg" "pgp" "asc" "bfe" "enc" "signature"
                                             "sig" "p12" "pem"))
  (dired-rainbow-define executable "#8cc4ff" ("exe" "msi"))
  (dired-rainbow-define fonts "#6cb2eb" ("afm" "fon" "fnt" "pfb" "pfm" "ttf" "otf"))
  (dired-rainbow-define html "#eb5286" ("css" "less" "sass" "scss" "htm" "html" "jhtm"
                                        "mht" "eml" "mustache" "xhtml"))
  (dired-rainbow-define image "#f66d9b" ("tiff" "tif" "cdr" "gif" "ico" "jpeg" "jpg"
                                         "png" "psd" "eps" "svg"))
  (dired-rainbow-define interpreted "#38c172" ("py" "ipynb" "rb" "pl" "t" "msql" "mysql"
                                               "pgsql" "sql" "r" "clj" "cljs" "scala" "js"))
  (dired-rainbow-define log "#c17d11" ("log"))
  (dired-rainbow-define media "#de751f" ("mp3" "mp4" "MP3" "MP4" "avi" "mpeg" "mpg" "flv"
                                         "ogg" "mov" "mid" "midi" "wav" "aiff" "flac"))
  (dired-rainbow-define markdown "#ffed4a" ("org" "etx" "info" "markdown" "md" "mkd" "nfo"
                                            "pod" "rst" "tex" "textfile" "txt"))
  (dired-rainbow-define packaged "#faad63" ("deb" "rpm" "apk" "jad" "jar" "cab" "pak" "pk3"
                                            "vdf" "vpk" "bsp"))
  (dired-rainbow-define partition "#e3342f" ("dmg" "iso" "bin" "nrg" "qcow" "toast"
					     "vcd" "vmdk" "bak"))
  (dired-rainbow-define shell "#f6993f" ("awk" "bash" "bat" "sed" "sh" "zsh" "vim"))
  (dired-rainbow-define vc "#0074d9" ("git" "gitignore" "gitattributes" "gitmodules"))
  (dired-rainbow-define xml "#f2d024" ("xml" "xsd" "xsl" "xslt" "wsdl" "bib" "json" "msg"
                                       "pgn" "rss" "yaml" "yml" "rdata")))


(use-package wdired
  :ensure nil
  :straight nil
  :commands (wdired-change-to-wdired-mode)
  :custom
  (wdired-allow-to-change-permissions t)
  (wdired-create-parent-directories t))

(require 'cleandesk)

(if nec/measure-time (nec/sstimer "core/files-dired"))

(provide 'core/files-dired)
