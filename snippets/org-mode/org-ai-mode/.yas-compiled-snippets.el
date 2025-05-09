;;; Compiled snippets and support files for `org-ai-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'org-ai-mode
                     '(("pkg" "\\usepackage{$0}" "usepackage" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/usepackage"
                        nil nil)
                       ("b" "\\textbf{$1}$0" "textbf" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/textbf"
                        nil nil)
                       ("sum" "\\sum_{$1}^{$2}$0" "sum" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/sum"
                        nil nil)
                       ("sub"
                        "\\subsection{${1:name}}\n\\label{subsec:${2:label}}\n\n$0"
                        "subsec" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/subsec"
                        nil nil)
                       ("subfig"
                        "\\begin{figure}[ht]\n  \\centering\n  \\subfigure[$1]\n  {\\label{fig:${2:label}}\n    \\includegraphics[width=.${3:5}\\textwidth]{${4:path}}}\n\n  \\caption{${5:caption}}\n\\label{fig:${6:label}}\n\\end{figure}\n"
                        "subfigure" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/subfigure"
                        nil nil)
                       ("sf"
                        "\\subfigure[${1:caption}]{\n  \\label{fig:${2:label}}\n  \\includegraphics[width=.${3:3}\\textwidth]{${4:path}}}\n$0"
                        "subf" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/subf"
                        nil nil)
                       ("sec"
                        "\\section{${1:name}}\n\\label{sec:${2:label}}\n\n$0"
                        "section" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/section"
                        nil nil)
                       ("q" "\\question{$0}" "question" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/question"
                        nil nil)
                       ("py"
                        "\\lstset{language=python}\n\\begin[language=python]{lstlisting}\n$0\n\\end{lstlisting}"
                        "python" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/python"
                        nil nil)
                       ("prod" "\\prod_{$1}^{$2}$0" "prod" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/prod"
                        nil nil)
                       ("no" "\\note{$0}" "note" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/note"
                        nil nil)
                       ("gl"
                        "\\newglossaryentry{${1:AC}}{name=${2:Andrea Crotti}${3:, description=${4:description}}}"
                        "newglossaryentry" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/newglossaryentry"
                        nil nil)
                       ("cmd" "\\newcommand{\\\\${1:name}}${2:[${3:0}]}{$0}"
                        "newcommand" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/newcommand"
                        nil nil)
                       ("movie"
                        "\\begin{center}\n\\includemovie[\n  label=test,\n  controls=false,\n  text={\\includegraphics[width=4in]{${1:image.pdf}}}\n]{4in}{4in}{${2:video file}}\n\n\\movieref[rate=3]{test}{Play Fast}\n\\movieref[rate=1]{test}{Play Normal Speed}\n\\movieref[rate=0.2]{test}{Play Slow}\n\\movieref[resume]{test}{Pause/Resume}\n"
                        "movie" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/movie"
                        nil nil)
                       ("cvitem" "\\cvlistitem{${1:item}}\n$0\n"
                        "moderncv-cvlistitem" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/moderncv-cvlistitem"
                        nil nil)
                       ("cvditem"
                        "\\cvlistdoubleitem{${1:item}}{${2:item}}\n$0\n"
                        "moderncv-cvlistdoubleitem" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/moderncv-cvlistdoubleitem"
                        nil nil)
                       ("cvline" "\\cvline{${1:hobby}}{${2:Description}}\n$0\n"
                        "moderncv-cvline" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/moderncv-cvline"
                        nil nil)
                       ("cvlang"
                        "\\cvlanguage{${1:language}}{${2:skill-level}}{${3:comment}}\n$0\n"
                        "moderncv-cvlanguage" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/moderncv-cvlanguage"
                        nil nil)
                       ("cventry"
                        "\\cventry{${1:year}}{${2:job}}{${3:employer}}{${4:city}}{${5:description}}\n$0\n"
                        "moderncv-cventry" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/moderncv-cventry"
                        nil nil)
                       ("cvcomp"
                        "\\cvcomputer{${1:category}}{${2:programs}}{${3:category}}{${3:programs}}\n$0\n"
                        "moderncv-cvcomputer" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/moderncv-cvcomputer"
                        nil nil)
                       ("moderncv"
                        "\\documentclass[${1:options}]{moderncv}\n\n\\firstname{$3}\n\\familyname{$4}\n\n\\moderncvstyle{${5:casual}}\n\\moderncvcolor{${6:blue}}\n\n\\begin{document}\n$0\n\\end{document}\n"
                        "full template of moderncv class" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/moderncv"
                        nil nil)
                       ("lst"
                        "\\begin{lstlisting}[float,label=lst:${1:label},caption=nextHopInfo: ${2:caption}]\n$0\n\\end{lstlisting}"
                        "listing" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/listing"
                        nil nil)
                       ("lr" "\\left( $0 \\right)" "left and right" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/left-right"
                        nil nil)
                       ("lref" "\\labelcref{$0}" "labelcref" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/labelcref"
                        nil nil)
                       ("lab" "\\label{$0}" "label" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/label"
                        nil nil)
                       ("it" "\\begin{itemize}\n\\item $0\n\\end{itemize}"
                        "itemize" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/itemize"
                        nil nil)
                       ("-" "\\item $0" "item" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/item"
                        nil nil)
                       ("int" "\\int_{$1}^{$2}$0" "int" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/int"
                        nil nil)
                       ("ig" "\\includegraphics${1:[$2]}{$0}" "includegraphics"
                        nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/includegraphics"
                        nil nil)
                       ("if" "\\IF {$${1:cond}$}\n    $0\n\\ELSE\n\\ENDIF\n"
                        "if" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/if"
                        nil nil)
                       ("gp" "\\glspl{${1:label}}" "glspl" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/glspl"
                        nil nil)
                       ("g" "\\gls{${1:label}}" "gls" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/gls"
                        nil nil)
                       ("gq" "\\glq{}$0\\grq{}" "German single quotes" nil nil
                        nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/german-quotes-single"
                        nil nil)
                       ("gqq" "\\glqq{}$0\\grqq{}" "German quotes" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/german-quotes"
                        nil nil)
                       ("fr"
                        "\\begin{frame}${1:[$2]}\n        ${3:\\frametitle{$4}}\n        $0\n\\end{frame}"
                        "frame" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/frame"
                        nil nil)
                       ("frac" "\\frac{${1:numerator}}{${2:denominator}}$0"
                        "frac" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/frac"
                        nil nil)
                       ("fig"
                        "\\begin{figure}[ht]\n  \\centering\n  \\includegraphics[${1:options}]{figures/${2:path.pdf}}\n  \\caption{\\label{fig:${3:label}} $0}\n\\end{figure}\n"
                        "figure" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/figure"
                        nil nil)
                       ("eq"
                        "\\begin{equation}\n\\label{$0}\n$1\n\\end{equation}\n"
                        "equation" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/equation"
                        nil nil)
                       ("enum" "\\begin{enumerate}\n\\item $0\n\\end{enumerate}"
                        "enumerate" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/enumerate"
                        nil nil)
                       ("e" "\\emph{$1}$0" "emph" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/emph"
                        nil nil)
                       ("doc" "\\documentclass[${1:options}]{$2}\n$0\n"
                        "documentclass" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/documentclass"
                        nil nil)
                       ("desc"
                        "\\begin{description}\n\\item[$1] $0\n\\end{description}"
                        "description" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/description"
                        nil nil)
                       ("cols"
                        "\\begin{columns}\n  \\begin{column}{.${1:5}\\textwidth}\n  $0\n  \\end{column}\n\n  \\begin{column}{.${2:5}\\textwidth}\n\n  \\end{column}\n\\end{columns}"
                        "columns" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/columns"
                        nil nil)
                       ("code" "\\begin{lstlisting}\n$0\n\\end{lstlisting}"
                        "code" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/code"
                        nil nil)
                       ("c" "\\cite{$1} $0" "cite" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/cite"
                        nil nil)
                       ("ca" "\\caption{$0}" "caption" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/caption"
                        nil nil)
                       ("G" "\\Gls{${1:label}}" "Gls" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/capgls"
                        nil nil)
                       ("bl" "\\begin{block}{$1}\n        $0\n\\end{block}"
                        "block" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/block"
                        nil nil)
                       ("binom" "\\binom{${1:n}}{${2:k}}$0" "binom" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/binom"
                        nil nil)
                       ("bigcup" "\\bigcup${1:\\limits}_{$2}^{$3}$0" "bigcup"
                        nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/bigcup"
                        nil nil)
                       ("bigcap" "\\bigcap${1:\\limits}_{$2}^{$3}$0" "bigcap"
                        nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/bigcap"
                        nil nil)
                       ("begin" "\\begin{${1:environment}}\n$0\n\\end{$1}"
                        "begin" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/begin"
                        nil nil)
                       ("article"
                        "\\documentclass[${1:options}]{article}\n\n\\author{$3}\n\n\\begin{document}\n$0\n\\end{document}\n"
                        "full template of article class" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/article"
                        nil nil)
                       ("ali" "\\begin{align}\n\\label{$0}\n$1\n\\end{align}\n"
                        "align" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/align"
                        nil nil)
                       ("alg" "\\begin{algorithmic}\n$0\n\\end{algorithmic}\n"
                        "alg" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/alg"
                        nil nil)
                       ("al"
                        "\\begin{alertblock}{$2}\n        $0\n\\end{alertblock}"
                        "alertblock" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/alertblock"
                        nil nil)
                       ("ac"
                        "\\newacronym{${1:label}}{${1:$(upcase yas-text)}}{${2:Name}}"
                        "acronym" nil nil nil
                        "/Users/niels/.emacs.d/snippets/org-mode/org-ai-mode/acronym"
                        nil nil)))


;;; Do not edit! File generated at Fri Jan  3 16:50:43 2025
