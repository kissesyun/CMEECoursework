#!/bin/bash

#use latex to generate pdf file based on our tex file and add citation by using .bib file
pdflatex $1.tex
pdflatex $1.tex
bibtex $1.tex
pdflatex $1.tex
pdflatex $1.tex
evince $1.pdf &

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
mv $1.pdf ../Result/
