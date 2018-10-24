#!/usr/bin/env python3

""" Description of this program or application.
    You can use several lines """

__appname__ = 'boilerplate'
__author__ = 'ShiyunLiu s.liu18@imperial.ac.uk'
__version__ = '0.01'
__license__ = 'License for this code'

##imports

import sys 

##constants

##functions

def main(argv):
    """ Main entry point of the program """
    print('This is a boilerplate')
    return 0

if __name__ == "__main__":
    """ Makes sure the "main" function is called from command line """  
    status = main(sys.argv)
    sys.exit(status)



