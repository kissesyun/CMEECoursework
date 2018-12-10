#!/usr/bin/env python3

""" Run and profile LV python scripts"""

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'


import subprocess
import cProfile

def runLV1():
	subprocess.os.system("ipython LV1.py")

def runLV2():
	subprocess.os.system("ipython LV2.py")

def runLV3():
	subprocess.os.system("ipython LV3.py")

def runLV4():
	subprocess.os.system("ipython LV4.py")

cProfile.run("runLV1()")
cProfile.run("runLV2()")
cProfile.run("runLV3()")
cProfile.run("runLV4()")