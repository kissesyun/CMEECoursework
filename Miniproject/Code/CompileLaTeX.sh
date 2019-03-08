#!/bin/bash

#use latex to generate pdf file based on our tex file and add citation by using .bib file
pdflatex miniproject.tex
bibtex miniproject
pdflatex miniproject.tex
pdflatex miniproject.tex


## Cleanup several files that are generated during the run
rm *~
rm *.aux
rm *.dvi
rm *.log
rm *.nav
rm *.out
rm *.snm
rm *.toc
rm *.bbl
rm *.blg

## move the result to Result folder
mv miniproject.pdf ../Result/
