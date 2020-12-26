;;; class.el  -*- lexical-binding: t; -*-

;; Copyright (c) 2012-2020, Niels Søndergaard niels@algon.dk
;;
;; Author: Niels Søndergaard, niels@algon.dk
;; URL: https://github.com/algon-ns/nec.emacs.d
;; 
;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Provide additional utilities for OS X

;;; Code:

(with-eval-after-load 'ox-latex
        (add-to-list 'org-latex-classes
                     '("assign"
                       "\\documentclass{article}
  \\usepackage{amsmath,amsfonts,stmaryrd,amssymb}
  \\usepackage{enumerate} 
  \\usepackage[ruled]{algorithm2e}
  \\usepackage[framemethod=tikz]{mdframed} 
  \\usepackage{listings}
  \\usepackage[footnote]{snotez} 
  \\usepackage[danish]{babel}
  \\lstset{
        basicstyle=\\ttfamily, 
  }
    \\usepackage{geometry}
    \\geometry{
        paper=a4paper, 
        top=40pt, 
        bottom=3cm, 
        left=30pt,
        textwidth=417pt, 
        headheight=14pt,
        marginparsep=20pt,
        marginparwidth=100pt,
        footskip=30pt, 
        headsep=0cm,
    }
    \\usepackage[utf8]{inputenc} 
    \\usepackage{sansmathfonts} 
    \\usepackage[T1]{fontenc} 
    \\renewcommand*\\familydefault{\\sfdefault}
  \\mdfdefinestyle{commandline}{
      leftmargin=10pt,
      rightmargin=10pt,
      innerleftmargin=15pt,
      middlelinecolor=black!50!white,
      middlelinewidth=2pt,
      frametitlerule=false,
      backgroundcolor=black!5!white,
      frametitle={Ligne de commande},
      frametitlefont={\\normalfont\\sffamily\\color{white}\\hspace{-1em}},
      frametitlebackgroundcolor=black!50!white,
      nobreak,
  }
  \\newenvironment{commandline}{
      \\medskip
      \\begin{mdframed}[style=commandline]
  }{
      \\end{mdframed}
      \\medskip
  }
  \\mdfdefinestyle{question}{
      innertopmargin=1.2\\baselineskip,
      innerbottommargin=0.8\\baselineskip,
      roundcorner=5pt,
      nobreak,
      singleextra={
          \\draw(P-|O)node[xshift=1em,anchor=west,fill=white,draw,rounded corners=5pt]{
          Question \\theQuestion\\questionTitle};
      },
  }
  \\newcounter{Question} 
  \\newenvironment{question}[1][\\unskip]{
      \\bigskip
      \\stepcounter{Question}
      \\newcommand{\\questionTitle}{~#1}
      \\begin{mdframed}[style=question]
  }{
      \\end{mdframed}
      \\medskip
  }
  \\mdfdefinestyle{warning}{
      topline=false, bottomline=false,
      leftline=false, rightline=false,
      nobreak,
      singleextra={
          \\draw(P-|O)++(-0.5em,0)node(tmp1){};
          \\draw(P-|O)++(0.5em,0)node(tmp2){};
          \\fill[black,rotate around={45:(P-|O)}](tmp1)rectangle(tmp2);
          \\node at(P-|O){\\color{white}\\scriptsize\\bf !};
          \\draw[very thick](P-|O)++(0,-1em)--(O);
      }
  }
  \\newenvironment{warning}[1][Attention:]{ 
      \\medskip
      \\begin{mdframed}[style=warning]
          \\noindent{\\textbf{#1}}
  }{
      \\end{mdframed}
  }
  \\mdfdefinestyle{info}{
      topline=false, bottomline=false,
      leftline=false, rightline=false,
      nobreak,
      singleextra={
          \\fill[black](P-|O)circle[radius=0.4em];
          \\node at(P-|O){\\color{white}\\scriptsize\\bf i};
          \\draw[very thick](P-|O)++(0,-0.8em)--(O);
      }
  }
  \\newenvironment{info}[1][Info:]{ 
      \\medskip
      \\begin{mdframed}[style=info]
          \\noindent{\\textbf{#1}}
  }{
      \\end{mdframed}
  }"
                       ("\\section{%s}" . "\\section*{%s}")
                       ("\\subsection{%s}" . "\\subsection*{%s}")
                       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                       ("\\paragraph{%s}" . "\\paragraph*{%s}")
                       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
)

(provide 'class)
