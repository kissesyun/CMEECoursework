#! /usr/bin/env python3
"""Learn about global and local variables"""

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'



###try this
_a_global = 10

def a_function():
    """To define local variables"""
    _a_global = 5
    _a_local = 4
    print("Inside the function, the value is", _a_global)
    print("Inside the function, the value is", _a_local)
    return None

a_function()

print("Outside the function, the value is", _a_global)

## Now try this

_a_global = 10

def a_function():
    """To define a global variable"""
    global _a_global
    _a_global = 5
    _a_local = 4
    print("Inside the function, the value is ", _a_global)
    print("Inside the function, the value is ", _a_local)
    return None

a_function()
print("Outside the function, the value is", _a_global)
