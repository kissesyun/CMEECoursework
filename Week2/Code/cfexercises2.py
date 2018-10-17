#! /user/bin/env python3
"""Some functions exemplifying the use of control statements"""

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'

import sys

### To do unit testing with doctest
import doctest

###Calculate square root of x
def foo1(x):
    # """Calculate square root of x
    # >>> foo1(4)
    # 2.0
    # >>> foo1(25)
    # 5.0
    # """
    #Define function to be tested 
    return x ** 0.5

#doctest.testmod()

###Choose the larger number in x and y
def foo2(x, y):
    if x > y:
        return x
    return y

###Order number x,y,z from small to big
def foo3(x, y, z):
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

###Calculate x!
def foo4(x):
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

###Calculate x!
def foo5(x): # a recursive function
    if x == 1:
        return 1
    return x * foo5(x - 1)

def main(argv):
    print(foo1(9))
    print(foo2(4,5))
    print(foo3(2,3,4))
    print(foo4(5))
    print(foo5(6))
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)

