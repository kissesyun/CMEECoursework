#!/usr/bin/env python3

""" Run the Rscript fmr.R through python. And show if the run was successful and prints the error
	message if there is an error """

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'

import subprocess

# runs fmf.R, creates fmr.Rout and error file
ReadR = subprocess.Popen("/usr/lib/R/bin/Rscript --verbose fmr.R > \
../Result/fmr.Rout 2> ../Result/fmr_errFile.Rout",\
shell = True).wait() 

#prints to fmr.Rout 
if ReadR == 0:
	print("Run was successful")
	subprocess.os.system("cat ../Result/fmr.Rout") #prints to fmr.Rout 

#prints to error file
if ReadR != 0:
	subprocess.os.system("cat ../Result/fmr_errFile.Rout")