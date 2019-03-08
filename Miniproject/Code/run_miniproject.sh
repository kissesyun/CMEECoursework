#!usr/bin/python
""" Bash script to glue all the work for the Miniproject"""

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'


echo "Running Rscript for data clearing"
Rscript Prepare_data.R

echo "Running Python script for model fitting"
python3 Model_fitting.py

echo "Running R script to plot the graphs"
Rscript Plot_graph.R

echo "run bash script to compile LaTeX code to pdf..."
bash CompileLaTeX.sh 


