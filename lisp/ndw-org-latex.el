;;; ndw-org-latex --- Org-mode LaTeX exports. -*- lexical-binding: t -*-

;;; Commentary:

;; Customizations for Org-mode LaTeX export

;;; Code:

;; Setup the compiler and the PDF process
(setq org-latex-compiler "xelatex")
(setq org-latex-pdf-process
      (list (concat "latexmk -"
                    org-latex-compiler 
                    " -recorder -synctex=1 -bibtex-cond %b")))

;; Use lstlstings
(setq org-latex-listings t)

;; The docs for org-latex-default-packages-alist suggest that
;; it shouldn't be changed because it's used for more than one
;; backend. How it's used for non-LaTeX backends, I don't know.
;; Anyway, I've removed "inputenc" and "fontenc" from it because
;; I want to replace those with "fontspec".
(setq org-latex-default-packages-alist
      '(("" "graphicx" t)
        ("" "grffile" t)
        ("" "longtable" nil)
        ("" "wrapfig" nil)
        ("" "rotating" nil)
        ("normalem" "ulem" t)
        ("" "amsmath" t)
        ("" "textcomp" t)
        ("" "amssymb" t)
        ("" "capt-of" nil)
        ("" "hyperref" nil)))

;; This big wodge of premable was proposed by Peter. I like the
;; results, so I'm keeping it. I'm not confident I understand all
;; of it, but I'm keeping it anyway.
(setq org-latex-classes
'(("article"
"\\RequirePackage{fix-cm}
\\PassOptionsToPackage{svgnames}{xcolor}
\\documentclass[11pt]{article}
\\usepackage{fontspec}
\\setmainfont{ETBembo RomanOSF}
\\setsansfont[Scale=MatchLowercase]{Raleway}
\\setmonofont[Scale=MatchLowercase]{Operator Mono SSm}
\\usepackage{sectsty}
\\allsectionsfont{\\sffamily}
\\usepackage{enumitem}
\\setlist[description]{style=unboxed,font=\\sffamily\\bfseries}
\\usepackage{listings}
\\lstset{frame=single,aboveskip=1em,
	framesep=.5em,backgroundcolor=\\color{AliceBlue},
	rulecolor=\\color{LightSteelBlue},framerule=1pt}
\\usepackage{xcolor}
\\colorlet{punct}{red!60!black}
\\definecolor{background}{HTML}{EEEEEE}
\\definecolor{delim}{RGB}{20,105,176}
\\colorlet{numb}{magenta!60!black}
\\newcommand\\basicdefault[1]{\\scriptsize\\color{Black}\\ttfamily#1}
\\lstdefinelanguage{json}{
    basicstyle=\\normalfont\\ttfamily,
    numbers=left,
    numberstyle=\\scriptsize,
    stepnumber=1,
    numbersep=8pt,
    showstringspaces=false,
    breaklines=true,
    frame=lines,
    backgroundcolor=\\color{background},
    literate=
     *{0}{{{\\color{numb}0}}}{1}
      {1}{{{\\color{numb}1}}}{1}
      {2}{{{\\color{numb}2}}}{1}
      {3}{{{\\color{numb}3}}}{1}
      {4}{{{\\color{numb}4}}}{1}
      {5}{{{\\color{numb}5}}}{1}
      {6}{{{\\color{numb}6}}}{1}
      {7}{{{\\color{numb}7}}}{1}
      {8}{{{\\color{numb}8}}}{1}
      {9}{{{\\color{numb}9}}}{1}
      {:}{{{\\color{punct}{:}}}}{1}
      {,}{{{\\color{punct}{,}}}}{1}
      {\\{}{{{\\color{delim}{\\{}}}}{1}
      {\\}}{{{\\color{delim}{\\}}}}}{1}
      {[}{{{\\color{delim}{[}}}}{1}
      {]}{{{\\color{delim}{]}}}}{1},
}
\\lstset{basicstyle=\\basicdefault{\\spaceskip1em}}
\\lstset{literate=
	    {§}{{\\S}}1
	    {©}{{\\raisebox{.125ex}{\\copyright}\\enspace}}1
	    {«}{{\\guillemotleft}}1
	    {»}{{\\guillemotright}}1
	    {Á}{{\\'A}}1
	    {Ä}{{\\\"A}}1
	    {É}{{\\'E}}1
	    {Í}{{\\'I}}1
	    {Ó}{{\\'O}}1
	    {Ö}{{\\\"O}}1
	    {Ú}{{\\'U}}1
	    {Ü}{{\\\"U}}1
	    {ß}{{\\ss}}2
	    {à}{{\\`a}}1
	    {á}{{\\'a}}1
	    {ä}{{\\\"a}}1
	    {é}{{\\'e}}1
	    {í}{{\\'i}}1
	    {ó}{{\\'o}}1
	    {ö}{{\\\"o}}1
	    {ú}{{\\'u}}1
	    {ü}{{\\\"u}}1
	    {¹}{{\\textsuperscript1}}1
            {²}{{\\textsuperscript2}}1
            {³}{{\\textsuperscript3}}1
	    {ı}{{\\i}}1
	    {—}{{---}}1
	    {’}{{'}}1
	    {…}{{\\dots}}1
            {⮠}{{$\\hookleftarrow$}}1
	    {␣}{{\\textvisiblespace}}1,
	    keywordstyle=\\color{DarkGreen}\\bfseries,
	    identifierstyle=\\color{DarkRed},
	    commentstyle=\\color{Gray}\\upshape,
	    stringstyle=\\color{DarkBlue}\\upshape,
	    emphstyle=\\color{Chocolate}\\upshape,
	    showstringspaces=false,
	    columns=fullflexible,
	    keepspaces=true}
\\usepackage[a4paper,margin=1in,left=1in]{geometry}
\\usepackage{parskip}
\\makeatletter
\\renewcommand{\\maketitle}{%
  \\begingroup\\parindent0pt
  \\sffamily
  \\Huge{\\bfseries\\@title}\\par\\bigskip
  \\LARGE{\\bfseries\\@author}\\par\\medskip
  \\normalsize\\@date\\par\\bigskip
  \\endgroup\\@afterindentfalse\\@afterheading}
\\makeatother
[DEFAULT-PACKAGES]
\\hypersetup{linkcolor=Blue,urlcolor=DarkBlue,
  citecolor=DarkRed,colorlinks=true}
\\AtBeginDocument{\\renewcommand{\\UrlFont}{\\ttfamily}}
\\thispagestyle{empty}
[PACKAGES]
[EXTRA]"
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}")
("\\paragraph{%s}" . "\\paragraph*{%s}")
("\\subparagraph{%s}" . "\\subparagraph*{%s}"))

("report"
 "\\documentclass[11pt]{report}"
("\\part{%s}" . "\\part*{%s}")
("\\chapter{%s}" . "\\chapter*{%s}")
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}"))

("book"
"\\documentclass[11pt]{book}"
("\\part{%s}" . "\\part*{%s}")
("\\chapter{%s}" . "\\chapter*{%s}")
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))

(provide 'ndw-org-latex)
;;; ndw-org-latex ends here
