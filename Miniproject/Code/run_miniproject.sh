#!/bin/bash
""" Bash script to glue all the work for the miniproject"""

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'


echo "Run Rscript for data clearing"
Rscript Prepare_data.R

echo "Run Python script for model fitting"
python3 Model_fitting.py

echo "Run R script to plot the graphs"
Rscript Plot_graph.R

echo "Run bash script to compile LaTeX code for project write-up to pdf named miniproject.pdf..."
bash CompileLaTeX.sh 


