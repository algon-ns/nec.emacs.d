;;; init-latex.el ---   -*- lexical-binding: t; coding: utf-8 -*-

;; Copyright (C),  2024 Nivå, Denmark
;;
;; Author: Niels Søndergaard <niels@macal.local>

;; Package-Requires: ((emacs "30.0.50"))
;; Keywords:
;; Homepage:

;; init-latex is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; init-latex is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with init-latex.  If not, see http://www.gnu.org/licenses.

;;; Commentary:
;;  AUCTEX is a comprehensive customizable integrated environment for writing
;;  input files for TEX, LaTEX, ConTEXt, Texinfo, and docTEX using Emacs.
;;  

;;; Code:

(straight-use-package '(auctex :type git
			       :host github
			       :repo "emacs-straight/auctex"
			       :files ("*" (:exclude ".git"))))
(setq-default TeX-engine 'luatex)


(setq TeX-clean t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(require 'reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode
(setq reftex-plug-into-AUCTeX t)
(setq LaTeX-label-function 'reftex-label)
(require 'font-latex)
(setq +latex-viewers '(pdf-tools))
(setq TeX-PDF-mode t)
(setq TeX-auto-untabify t)
(setq org-latex-create-formula-image-program 'dvisvgm)
(setq LaTeX-amsmath-label "eq:")
(setq TeX-error-overview-open-after-TeX-run t )
(setq-default TeX-command-extra-options "--shell-escape")
(setq TeX-error-overview-open-after-TeX-run t)
(setq TeX-electric-math '("$" . "$"))
(setq TeX-electric-sub-and-superscript t)
;; LaTeX
(setq org-latex-remove-logfiles t)
(setq org-latex-logfiles-extensions (quote ("lof" "lot" "tex~" "blg"
					    "aux" "idx" "out" "run.xml"
					    "toc" "nav" "synctex.gz"
					    "w18" "snm" "vrb" "dvi"
					    "fdb_latexmk" "blg" "brf"
					    "fls" "entoc" "ps" "spl"
					    "bbl" "dep" "upa" "upb")))

(use-package tex
  :straight (amsreftex :type git :host github :repo "franburstall/amsreftex")
  :ensure auctex
  :config
  (setq TeX-engine 'luatex)
  (setq org-latex-pdf-process
      '("latexmk -f -lualatex -interaction=nonstopmode -output-directory=%o %f"))
  (add-to-list 'org-latex-packages-alist
      '("AUTO" "babel" t ("pdflatex" "xelatex" "lualatex")))


;; Copyright (C) 2011 Erik Parmann, Pål Drange
;;
;; Author: Erik Parmann <eparmann@gmail.com>
;;         Pål Drange
;; Created: 10. July 2011
;; Version: 1.0
;; Package-Version: 20150409.240

;;; Commentary:
;; Description: This library use font-locking to change the way Emacs displays
;;   various latex commands, like \Gamma, \Phi, etc.  It does not actually
;;   change the content of the file, only the way it is displayed.

(require 'cl-lib)
;;; Code:

;;The following code can be used to add strings, and not just single
;; characters. But not really working yet, as it does not remove the thing that
;; is below
;; (require 'cl)
;; (defun compose-string-to-region (start end string decomposingfunct)
;;   (loop for i from 0 to (- (length string) 1)
;; 	do (compose-region (+ i start) (+  start i 1) (substring string i (+ i 1) ) decomposingfunct)))


(defun substitute-patterns-with-unicode-symbol (patterns)
  "Mapping over PATTERNS, calling SUBSTITUTE-PATTERN-WITH-UNICODE for each of the patterns."
  (mapcar #'(lambda (x)
              (substitute-pattern-with-unicode-symbol (car x)
                                                      (cl-second x)))
          patterns))

(defun latex-escape-regex (str)
  "Gets a string, e.g. Alpha, returns the regexp matching the escaped
version of it in LaTeX code, with no chars in [a-z0-9A-Z] after it."
  (interactive "MString:")
  (concat "\\(\\\\" str "\\)[^a-z0-9A-Z]"))


(defun latex-escape-regexp-super-or-sub (str sup-or-sub backslash)
  "Gets a string, e.g. 1, a symbol 'sub or 'sup saying wether it
should be a superscript or subscript, and a boolean for
  backslash saying wether or not str should be backslashed (like
  \gamma). It returns the regexp matching the super/sub-scripted
  version of it in LaTeX code"
  ;; We can not use "(regexp-opt (list (concat "_" str) (concat "_{" str
  ;; "}")))", as it adds a "?:" after every group, which eveidently breaks the
  ;; font-locking engine in emacs. I assume the reason is like this: Normaly a
  ;; group (denoted with paranthesises) create a "backreference". This makes it
  ;; possible (I think) for the font-locking-engine no know where it actually
  ;; matched. The "?:" sais that we need to backreference. We have added one in
  ;; the innermost group, as we never need to know the location of the inner
  ;; matching, only the outermost. Adding "?:" where it can be done makes
  ;; matching more effecient, as the engine dont need to make a backreference
  (if backslash (setf str (concat "\\\\" str)))
  (cl-case sup-or-sub
    (sub  (concat "\\(_\\(?:" str "\\|{" str "}\\)\\)"))
    (sup  (concat "\\(\\^\\(?:" str "\\|{" str "}\\)\\)"))))

(defun latex-escape-regex-sub (str &optional backslash)
  "Gets a string, e.g. 1, returns the regexp matching the subscripted
version of it in LaTeX code."
  (interactive "MString:")
  (latex-escape-regexp-super-or-sub str 'sub backslash))

(defun latex-escape-regex-sup (str &optional backslash)
  "Gets a string, e.g. 1, returns the regexp matching the superscripted
version of it in LaTeX code."
  (interactive "MString:")
  (latex-escape-regexp-super-or-sub str 'sup backslash))

;;Goto http://www.fileformat.info/info/unicode/block/mathematical_operators/list.htm and copy the needed character
(defun latex-unicode-simplified ()
  "Adds a bunch of font-lock rules to display latex commands as
their unicode counterpart"
  (interactive)
  (substitute-patterns-with-unicode-symbol
   (list
    ;;These need to be on top, before the versions which are not subscriptet
    (list (latex-escape-regex-sub "beta" t)"ᵦ")
    (list (latex-escape-regex-sub "gamma" t)"ᵧ")
    (list (latex-escape-regex-sub "rho" t)"ᵨ")
    (list (latex-escape-regex-sub "phi" t)"ᵩ")
    (list (latex-escape-regex-sub "chi" t)"ᵪ")
    
    (list (latex-escape-regex "Alpha") "Α")
    (list (latex-escape-regex "Beta") "Β")
    (list (latex-escape-regex "Gamma")"Γ")
    (list (latex-escape-regex "Delta")"Δ")
    (list (latex-escape-regex "Epsilon")"Ε")
    (list (latex-escape-regex "Zeta")"Ζ")
    (list (latex-escape-regex "Eta")"Η")
    (list (latex-escape-regex "Theta")"Θ")
    (list (latex-escape-regex "Iota")"Ι")
    (list (latex-escape-regex "Kappa")"Κ")
    (list (latex-escape-regex "Lambda")"Λ")
    (list (latex-escape-regex "Mu")"Μ")
    (list (latex-escape-regex "Nu")"Ν")
    (list (latex-escape-regex "Xi")"Ξ")
    (list (latex-escape-regex "Omicron")"Ο")
    (list (latex-escape-regex "Pi")"Π")
    (list (latex-escape-regex "Rho")"Ρ")
    (list (latex-escape-regex "Sigma")"Σ")
    (list (latex-escape-regex "Tau")"Τ")
    (list (latex-escape-regex "Upsilon")"Υ")
    (list (latex-escape-regex "Phi")"Φ")
    (list (latex-escape-regex "Chi")"Χ")
    (list (latex-escape-regex "Psi")"Ψ")
    (list (latex-escape-regex "Omega")"Ω")
    (list (latex-escape-regex "alpha")"α")
    (list (latex-escape-regex "beta")"β")
    (list (latex-escape-regex "gamma")"γ")
    (list (latex-escape-regex "delta")"δ")
    (list (latex-escape-regex "epsilon")"ε")
    (list (latex-escape-regex "zeta")"ζ")
    (list (latex-escape-regex "eta")"η")
    (list (latex-escape-regex "theta")"θ")
    (list (latex-escape-regex "iota")"ι")
    (list (latex-escape-regex "kappa")"κ")
    (list (latex-escape-regex "lambda")"λ")
    (list (latex-escape-regex "mu")"μ")
    (list (latex-escape-regex "nu")"ν")
    (list (latex-escape-regex "xi")"ξ")
    (list (latex-escape-regex "omicron")"ο")
    (list (latex-escape-regex "pi")"π")
    (list (latex-escape-regex "rho")"ρ")
    (list (latex-escape-regex "sigma")"σ")
    (list (latex-escape-regex "tau")"τ")
    (list (latex-escape-regex "upsilon")"υ")
    (list (latex-escape-regex "phi") "ϕ")
    (list (latex-escape-regex "chi")"χ")
    (list (latex-escape-regex "psi")"ψ")
    (list (latex-escape-regex "omega")"ω")

    ;; relations
    (list (latex-escape-regex "geq")"≥")
    (list (latex-escape-regex "ge")"≥")
    (list (latex-escape-regex "leq")"≤")
    (list (latex-escape-regex "le")"≤")
    (list (latex-escape-regex "neq")"≠")

    ;; logical ops
    (list (latex-escape-regex "land")"∧")
    (list (latex-escape-regex "lor")"∨")
    (list (latex-escape-regex "neg")"¬")
    (list (latex-escape-regex "rightarrow")"→")
    (list (latex-escape-regex "leftarrow")"←")
    (list (latex-escape-regex "leftrightarrow")"↔")
    (list (latex-escape-regex "Rightarrow")"⇒")
    (list (latex-escape-regex "Leftarrow")"⇐")
    (list(latex-escape-regex "Leftrightarrow")"⇔")
    (list (latex-escape-regex "forall")"∀")
    (list (latex-escape-regex "exists")"∃")
    (list (latex-escape-regex "Diamond")"⋄")
    (list (latex-escape-regex "Box")"□")
    (list (latex-escape-regex "models")"⊧")
    (list (latex-escape-regex "bot")"⊥")
    (list (latex-escape-regex "top")"⊤")
    
    ;; infty before in
    (list (latex-escape-regex "infty")"∞")
    
    ;; set ops
    ;;Here I have chosen to have \} display as ⎬, to easy reading of set building opperations. Slightly uncertain
    (list "\\(\\\\}\\)" "⎬")
    (list "\\(\\\\{\\)" "⎨")
    
    (list (latex-escape-regex "mid")"|")
    (list (latex-escape-regex "in")"∊")
    (list (latex-escape-regex "notin")"∉")
    (list (latex-escape-regex "cup")"∪")
    (list (latex-escape-regex "cap")"∩")
    (list (latex-escape-regex "setminus")"∖")
    (list (latex-escape-regex "minus")"∖")
    (list (latex-escape-regex "subseteq")"⊆")
    (list (latex-escape-regex "subset")"⊂")
    (list (latex-escape-regex "emptyset")"∅")
    (list (latex-escape-regex "ni")"∋")
    
    ;; generic math
    (list (latex-escape-regex "dots")"…")
    
    ;;Superscript
    (list (latex-escape-regex-sup "0")"⁰")
    (list (latex-escape-regex-sup "1")"¹")
    (list (latex-escape-regex-sup "2")"²")
    (list (latex-escape-regex-sup "3")"³")
    (list (latex-escape-regex-sup "4")"⁴")
    (list (latex-escape-regex-sup "5")"⁵")
    (list (latex-escape-regex-sup "6")"⁶")
    (list (latex-escape-regex-sup "7")"⁷")
    (list (latex-escape-regex-sup "8")"⁸")
    (list (latex-escape-regex-sup "9")"⁹")
    (list (latex-escape-regex-sup "-")"⁻")
    (list (latex-escape-regex-sup "=")"⁼")
    (list (latex-escape-regex-sup "\\+")"⁺")
    (list (latex-escape-regex-sup "a")"ᵃ")
    (list (latex-escape-regex-sup "b")"ᵇ")
    (list (latex-escape-regex-sup "c")"ᶜ")
    (list (latex-escape-regex-sup "d")"ᵈ")
    (list (latex-escape-regex-sup "e")"ᵉ")
    (list (latex-escape-regex-sup "f")"ᶠ")
    (list (latex-escape-regex-sup "g")"ᵍ")
    (list (latex-escape-regex-sup "h")"ʰ")
    (list (latex-escape-regex-sup "i")"ⁱ")
    (list (latex-escape-regex-sup "j")"ʲ")
    (list (latex-escape-regex-sup "k")"ᵏ")
    (list (latex-escape-regex-sup "l")"ˡ")
    (list (latex-escape-regex-sup "m")"ᵐ")
    (list (latex-escape-regex-sup "n")"ⁿ")
    (list (latex-escape-regex-sup "o")"ᵒ")
    (list (latex-escape-regex-sup "p")"ᵖ")
    (list (latex-escape-regex-sup "r")"ʳ")
    (list (latex-escape-regex-sup "s")"ˢ")
    (list (latex-escape-regex-sup "t")"ᵗ")
    (list (latex-escape-regex-sup "u")"ᵘ")
    (list (latex-escape-regex-sup "v")"ᵛ")
    (list (latex-escape-regex-sup "w")"ʷ")
    (list (latex-escape-regex-sup "x")"ˣ")
    (list (latex-escape-regex-sup "y")"ʸ")
    (list (latex-escape-regex-sup "z")"ᶻ")
    
    (list (latex-escape-regex-sup "A")"ᴬ")
    (list (latex-escape-regex-sup "B")"ᴮ")
    (list (latex-escape-regex-sup "D") "ᴰ")
    (list (latex-escape-regex-sup "E") "ᴱ")
    (list (latex-escape-regex-sup "G") "ᴳ")
    (list (latex-escape-regex-sup "H") "ᴴ")
    (list (latex-escape-regex-sup "I") "ᴵ")
    (list (latex-escape-regex-sup "J") "ᴶ")
    (list (latex-escape-regex-sup "K") "ᴷ")
    (list (latex-escape-regex-sup "L") "ᴸ")
    (list (latex-escape-regex-sup "M") "ᴹ")
    (list (latex-escape-regex-sup "N") "ᴺ")
    (list (latex-escape-regex-sup "O") "ᴼ")
    (list (latex-escape-regex-sup "P") "ᴾ")
    (list (latex-escape-regex-sup "R") "ᴿ")
    (list (latex-escape-regex-sup "T") "ᵀ")
    (list (latex-escape-regex-sup "U") "ᵁ")
    (list (latex-escape-regex-sup "V") "ⱽ")
    (list (latex-escape-regex-sup "W") "ᵂ")
    
    
    
    ;;Subscripts, unfortunately we lack important part of the subscriptet alphabet, most notably j and m
    (list (latex-escape-regex-sub "1")"₁")
    (list (latex-escape-regex-sub "2")"₂")
    (list (latex-escape-regex-sub "3")"₃")
    (list (latex-escape-regex-sub "4")"₄")
    (list (latex-escape-regex-sub "5")"₅")
    (list (latex-escape-regex-sub "6")"₆")
    (list (latex-escape-regex-sub "7")"₇")
    (list (latex-escape-regex-sub "8")"₈")
    (list (latex-escape-regex-sub "9")"₉")
    (list (latex-escape-regex-sub "x")"ₓ")
    (list (latex-escape-regex-sub "i")"ᵢ")
    (list (latex-escape-regex-sub "\\+")"₊")
    (list (latex-escape-regex-sub "-")"₋")
    (list (latex-escape-regex-sub "=")"₌")
    (list (latex-escape-regex-sub "a")"ₐ")
    (list (latex-escape-regex-sub "e")"ₑ")
    (list (latex-escape-regex-sub "o")"ₒ")
    (list (latex-escape-regex-sub "i")"ᵢ")
    (list (latex-escape-regex-sub "r")"ᵣ")
    (list (latex-escape-regex-sub "u")"ᵤ")
    (list (latex-escape-regex-sub "v")"ᵥ")
    (list (latex-escape-regex-sub "x")"ₓ")
    
    
    ;; (list (latex-escape-regex "\\.\\.\\.") 'dots)
    (list (latex-escape-regex "langle")"⟨")
    (list (latex-escape-regex "rangle")"⟩")
    (list (latex-escape-regex "mapsto")"↦")
    (list (latex-escape-regex "to")"→")
    (list (latex-escape-regex "times")"×")
    (list (latex-escape-regex "equiv")"≡")
    (list (latex-escape-regex "star")"★")
    (list (latex-escape-regex "nabla")"∇")
    (list (latex-escape-regex "qed")"□")
    (list (latex-escape-regex "lightning")"Ϟ")
    
    ;;New: some of my own abreviations:
    
    ;;Go to
    ;; http://www.fileformat.info/info/unicode/block/letterlike_symbols/list.htm
    ;; to find some leters, or
    ;; http://www.fileformat.info/info/unicode/block/mathematical_alphanumeric_symbols/list.htm
    ;;  My mathcal like ones are from "MATHEMATICAL BOLD SCRIPT CAPITAL", an alternative block is Letterlike symbols:
    ;;http://en.wikipedia.org/wiki/Letterlike_Symbols
    
    (list (latex-escape-regex "impl") "→")
    (list (latex-escape-regex "iff") "↔")
    (list (latex-escape-regex "M") "𝓜")
    (list (latex-escape-regex "Mo") "𝓜")
    (list (latex-escape-regex "Fr") "𝓕")
    (list (latex-escape-regex "gt") ">")
    (list (latex-escape-regex "lt") "<")
    (list (latex-escape-regex "from") ":")
    (list (latex-escape-regex "Pow") "𝒫")
										;"ℒ"
    (list (latex-escape-regex "La") "𝓛")
    
    ;;Does not work, as it pushes them all into one character
    ;; (list (latex-escape-regex "atldiamond")"⟨⟨C⟩⟩")
										;Påls single letter abrevs:
    (list (latex-escape-regex "L") "𝓛")
    (list (latex-escape-regex "N") "𝓝")
    (list (latex-escape-regex "E") "𝓔")
    (list (latex-escape-regex "C") "𝓒")
    (list (latex-escape-regex "D") "𝓓")
    
    (list (latex-escape-regex "G") "𝓖")
    (list (latex-escape-regex "X") "𝓧")
    (list (latex-escape-regex "U") "𝓤")
    (list (latex-escape-regex "Q") "𝓠")
    
    
    ;;The following are not really working perfect
    ;; (list (latex-escape-regex "overline{R}") "R̄")
    ;; (list (latex-escape-regex "overline{X}") "X̄")
    ;; (list (latex-escape-regex "overline{G}") "Ḡ")
    
    
    
    ;;The following is some ugly fucks, as it has to match brackets! This makes
    ;;$\pair[A,B]$ into $⟨A,B⟩$, but can not handle nesting of the pair command,
    ;;then it does not convert the last "]" as it should. One can make one
    ;;regexp matching level of stacking, but my mind blows after even 1
    ;;level. Regular expressions can not do general, arbitrary depth,
    ;;paranthesis matching, but maybe emacs's "regexps" are expressiable enough for
    ;;this?
    (list  "\\(\\\\pair\\[\\)" "⟨")
    (list  "\\(?:\\\\pair\\[[^\]]*\\(]\\)\\)" "⟩")
    
    (list (latex-escape-regex "dagger") "†" )
    (list (latex-escape-regex "vDash") "⊨" )
    (list (latex-escape-regex "bigvee") "⋁" )
    (list (latex-escape-regex "bigwedge") "⋀" )
    (list (latex-escape-regex "biguplus") "⨄" )
    (list (latex-escape-regex "bigcap") "⋂" )
    (list (latex-escape-regex "bigcup") "⋃" )
    (list (latex-escape-regex "ss") "ß")
    (list (latex-escape-regex "ae") "æ")
    (list (latex-escape-regex "oe") "œ")
    (list (latex-escape-regex "o") "ø")
    (list (latex-escape-regex "AE") "Æ")
    (list (latex-escape-regex "OE") "Œ")
    (list (latex-escape-regex "O") "Ø")
    (list (latex-escape-regex "aa") "å")
    (list (latex-escape-regex "AA") "Å")
    (list (latex-escape-regex "dag") "†")
    (list (latex-escape-regex "ddag") "‡")
    (list (latex-escape-regex "S") "§")
    (list (latex-escape-regex "l") "ł")
    (list (latex-escape-regex "L") "Ł")
    (list (latex-escape-regex "copyright") "©")
    (list (latex-escape-regex "epsilon") "ϵ")
    (list (latex-escape-regex "varphi") "φ")
    (list (latex-escape-regex "vartheta") "ϑ")
    (list (latex-escape-regex "varpi") "ϖ")
    (list (latex-escape-regex "varrho") "ϱ")
    (list (latex-escape-regex "varsigma") "ς")
    (list (latex-escape-regex "aleph") "ℵ")
    (list (latex-escape-regex "hbar") "ℏ")
    (list (latex-escape-regex "ell") "ℓ")
    (list (latex-escape-regex "wp") "℘")
    (list (latex-escape-regex "Re") "ℜ")
    (list (latex-escape-regex "Im") "ℑ")
    (list (latex-escape-regex "partial") "∂")
    (list (latex-escape-regex "surd") "√")
    (list (latex-escape-regex "angle") "∠")
    (list (latex-escape-regex "triangle") "△")
    (list (latex-escape-regex "flat") "♭")
    (list (latex-escape-regex "natural") "♮")
    (list (latex-escape-regex "sharp") "♯")
    (list (latex-escape-regex "clubsuit") "♣")
    (list (latex-escape-regex "diamondsuit") "♢")
    (list (latex-escape-regex "heartsuit") "♡")
    (list (latex-escape-regex "spadesuit") "♠")
    (list (latex-escape-regex "coprod") "∐")
    (list (latex-escape-regex "int") "∫")
    (list (latex-escape-regex "prod") "∏")
    (list (latex-escape-regex "sum") "∑")
    (list (latex-escape-regex "bigotimes") "⨂")
    (list (latex-escape-regex "bigoplus") "⨁")
    (list (latex-escape-regex "bigodot") "⨀")
    (list (latex-escape-regex "oint") "∮")
    (list (latex-escape-regex "bigsqcup") "⨆")
    (list (latex-escape-regex "triangleleft") "◁")
    (list (latex-escape-regex "triangleright") "▷")
    (list (latex-escape-regex "bigtriangleup") "△")
    (list (latex-escape-regex "bigtriangledown") "▽")
    (list (latex-escape-regex "sqcap") "⊓")
    (list (latex-escape-regex "sqcup") "⊔")
    (list (latex-escape-regex "uplus") "⊎")
    (list (latex-escape-regex "amalg") "⨿")
    (list (latex-escape-regex "bullet") "∙")
    (list (latex-escape-regex "wr") "≀")
    (list (latex-escape-regex "div") "÷")
    (list (latex-escape-regex "odot") "⊙")
    (list (latex-escape-regex "oslash") "⊘")
    (list (latex-escape-regex "otimes") "⊗")
    (list (latex-escape-regex "ominus") "⊖")
    (list (latex-escape-regex "oplus") "⊕")
    (list (latex-escape-regex "mp") "∓")
    (list (latex-escape-regex "pm") "±")
    (list (latex-escape-regex "circ") "∘")
    (list (latex-escape-regex "circ") "○")
    (list (latex-escape-regex "bigcirc") "◯")
    (list (latex-escape-regex "cdot") "⋅")
    (list (latex-escape-regex "ast") "∗")
    (list (latex-escape-regex "star") "⋆")
    (list (latex-escape-regex "propto") "∝")
    (list (latex-escape-regex "sqsubseteq") "⊑")
    (list (latex-escape-regex "sqsupseteq") "⊒")
    (list (latex-escape-regex "parallel") "∥")
    (list (latex-escape-regex "dashv") "⊣")
    (list (latex-escape-regex "vdash") "⊢")
    (list (latex-escape-regex "nearrow") "↗")
    (list (latex-escape-regex "searrow") "↘")
    (list (latex-escape-regex "nwarrow") "↖")
    (list (latex-escape-regex "swarrow") "↙")
    (list (latex-escape-regex "succ") "≻")
    (list (latex-escape-regex "prec") "≺")
    (list (latex-escape-regex "approx") "≈")
    (list (latex-escape-regex "succeq") "≽")
    (list (latex-escape-regex "preceq") "≼")
    (list (latex-escape-regex "supset") "⊃")
    (list (latex-escape-regex "supseteq") "⊇")
    (list (latex-escape-regex "in") "∈")
    (list (latex-escape-regex "gg") "≫")
    (list (latex-escape-regex "ll") "≪")
    (list (latex-escape-regex "sim") "∼")
    (list (latex-escape-regex "simeq") "≃")
    (list (latex-escape-regex "asymp") "≍")
    (list (latex-escape-regex "smile") "⌣")
    (list (latex-escape-regex "frown") "⌢")
    (list (latex-escape-regex "leftharpoonup") "↼")
    (list (latex-escape-regex "leftharpoondown") "↽")
    (list (latex-escape-regex "rightharpoonup") "⇀")
    (list (latex-escape-regex "rightharpoondown") "⇁")
    (list (latex-escape-regex "hookrightarrow") "↪")
	d    (list (latex-escape-regex "hookleftarrow") "↩")
    (list (latex-escape-regex "bowtie") "⋈")
    (list (latex-escape-regex "models") "⊧")
    (list (latex-escape-regex "Longrightarrow") "⟹")
    (list (latex-escape-regex "longrightarrow") "⟶")
    (list (latex-escape-regex "longleftarrow") "⟵")
    (list (latex-escape-regex "Longleftarrow") "⟸")
    (list (latex-escape-regex "longmapsto") "⟼")
    (list (latex-escape-regex "longleftrightarrow") "⟷")
    (list (latex-escape-regex "Longleftrightarrow") "⟺")
    (list (latex-escape-regex "cdots") "⋯")
    (list (latex-escape-regex "vdots") "⋮")
    (list (latex-escape-regex "ddots") "⋱")
    (list (latex-escape-regex "Vert") "∥")
    (list (latex-escape-regex "uparrow") "↑")
    (list (latex-escape-regex "downarrow") "↓")
    (list (latex-escape-regex "updownarrow") "↕")
    (list (latex-escape-regex "Uparrow") "⇑")
    (list (latex-escape-regex "Downarrow") "⇓")
    (list (latex-escape-regex "Updownarrow") "⇕")
    (list (latex-escape-regex "rceil") "⌉")
    (list (latex-escape-regex "lceil") "⌈")
    (list (latex-escape-regex "rfloor") "⌋")
    (list (latex-escape-regex "lfloor") "⌊")
    (list (latex-escape-regex "cong") "≅")
    (list (latex-escape-regex "rightleftharpoons") "⇌")
    (list (latex-escape-regex "doteq") "≐")
    )))

;;AUCTeX
(add-hook 'LaTeX-mode-hook 'latex-unicode-simplified)

;;latex-mode
(add-hook 'latex-mode-hook 'latex-unicode-simplified)

(if nec/measure-time (nec/sstimer "write/latex-ed"))

(provide 'write/latex-ed)
;;; init-latex.el ends here
