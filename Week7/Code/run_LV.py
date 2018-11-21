#!/usr/bin/env python3

""" Run and profile LV1.py and LV2.py """

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'


import subprocess
import cProfile

def runLV1():
	subprocess.os.system("ipython LV1.py")

def runLV2():
	subprocess.os.system("ipython LV2.py")

cProfile.run("runLV1()")
cProfile.run("runLV2()")