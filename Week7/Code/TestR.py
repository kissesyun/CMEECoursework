#!/usr/bin/env python3

""" Run the Rscript "TestR.R" through python. And show if the run was successful and prints the error
	message if there is an error """

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'

import subprocess
subprocess.Popen("/usr/lib/R/bin/Rscript --verbose TestR.R > \
../Result/TestR.Rout 2> ../Result/TestR_errFile.Rout",\
 shell=True).wait()

subprocess.Popen("/usr/lib/R/bin/Rscript --verbose NonExistScript.R >\
../Result/outputFile.Rout 2> ../Result/errorFile.Rout", \
shell=True).wait()
