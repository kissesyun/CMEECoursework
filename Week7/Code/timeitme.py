#!/usr/bin/env python3
""" Time the function running """
__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'

iters = 1000000

import timeit

from profileme import my_squares as my_squares_loops

from profileme2 import my_squares as my_squares_lc

#%timeit my_squares_loops(iters)
#%timeit my_squares_lc(iters)
mystring = "my string"

from profileme import my_join as my_join_join

from profileme2 import my_join as my_join

#%timeit(my_join_join(iters, mystring))
#%timeit(my_join(iters, mystring))