#! /usr/bin/env python3
"""try debug function"""
__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'



def createabug(x):
    y = x**4
    z = 0.
    y = y/z
    return y

createabug(25)
