#!/usr/bin/env python3
""" Profiling in python """
__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'

def my_squares(iters):
    """Square the items in iters"""
    out = [i ** 2 for i in range(iters)]
    return out

def my_join(iters, string):
    """ Joining the strings together by commas"""
    out = ''
    for i in range(iters):
        out += ", " + string
    return out

def run_my_funcs(x,y):
    """ Joining the squared items together by commas"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")
