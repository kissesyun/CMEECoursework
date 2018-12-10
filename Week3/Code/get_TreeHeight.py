#!/usr/bin/env python
""" This is the python version of get tree height """

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'

import os
import sys
import pandas as pd
import numpy as np
import ntpath

a = sys.argv[1]

df = pd.read_csv(a)

df['Height'] = df['Distance.m'] * np.tan(np.deg2rad(df['Angle.degrees']))

#split the input filename and take out the bit we want to insert in the output filename
a = ntpath.basename(a).split('.')[0]
addition = "_treeheights.csv"
outname = a + addition
path = "../Result/"
outfilepath = os.path.join(path,outname)
df.to_csv(outfilepath)
