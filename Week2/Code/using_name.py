#! /usr/bin/env python3
"""Use of main function"""

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'

# Filename: using_name.py

if __name__ == '__main__':
    """ Makes sure the "main" function is called from command line """
    print('This program is being run by itself')
else:
    print('I am being imported from another module')
