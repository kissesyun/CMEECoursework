#!/usr/bin/env python3

""" Use the subprocess.os module to get files and dirs in the directory """

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'

# Use the subprocess.os module to get a list of files and  directories 
# in your ubuntu home directory 

# Hint: look in subprocess.os and/or subprocess.os.path and/or 
# subprocess.os.walk for helpful functions

import subprocess
import os

#################################
#~Get a list of files and 
#~directories in your home/ that start with an uppercase 'C'

# Type your code here:

# Get the user's home directory.
home = subprocess.os.path.expanduser("~")

# Create a list to store the results.
FilesDirsStartingWithC = []

# Use a for loop to walk through the home directory.
for (dir, subdirs, files) in subprocess.os.walk(home):
    for subdir in subdirs:
        if subdir.startswith("C"):
	        FilesDirsStartingWithC.append(subdir)

for (dir, subdirs, files) in subprocess.os.walk(home):   
	for file in files:
		if file.startswith("C"):
			FilesDirsStartingWithC.append(file)

print("Files and Dirs start with C:\n", FilesDirsStartingWithC)
  
#################################
# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'

# Type your code here:
FilesDirsStartingWithCc = []

for (dir, subdirs, files) in subprocess.os.walk(home):
    for subdir in subdirs:
        if subdir.lower().startswith("c"):
	        FilesDirsStartingWithCc.append(subdir)

for (dir, subdirs, files) in subprocess.os.walk(home):   
	for file in files:
		if file.lower().startswith("c"):
			FilesDirsStartingWithCc.append(file)

print("Files and Dirs start with C or c:\n", FilesDirsStartingWithCc)

#################################
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:
DirsStartingWithCc = []

for (dir, subdirs, files) in subprocess.os.walk(home):
    for subdir in subdirs:
        if subdir.lower().startswith("c"):
            DirsStartingWithCc.append(subdir)

print("Dirs start with C or c:\n", DirsStartingWithCc)