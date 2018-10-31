#! /usr/bin/env python3
"""Doctest practice"""

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'

import sys

import doctest

def even_or_odd(x=0):
    """Find whether a number x is even or odd.
    >>> even_or_odd(10)
    '10 is Even!'
    >>> even_or_odd(5)
    '5 is Odd!'

    whenever a float is provided, then the closest integer is used:    
    >>> even_or_odd(3.2)
    '3 is Odd!'

    in case of negative numbers, the positive is taken:    
    >>> even_or_odd(-2)
    '-2 is Even!'
    """
#Define function to be tested    
    if x % 2 == 0:
        return "%d is Even!" %x
    return "%d is Odd!" %x

# def largest_divisor_five(x=120):
#     """Find which is the largest divisor of x among"""
#     largest = 0
#     if x % 5 == 0:
#         largest = 5
#     elif x % 4 == 0:
#         largest = 4 
#     elif x % 3 == 0:
#         largest = 3
#     elif x % 2 == 0:
#         largest = 2
#     else:
#         return "No divisor found for %d!" %x
#     return "The largest divisor of %d is %d" %(x,largest)

# def is_prime(x=70):
#     """Find whether an integer is prime."""
#     for i in range(2,x):
#         if x % i == 0:
#             print("%d is not a prime: %d is a divisor" % (x, i))

#             return False
        
#     print("%d is a prime!" % x)
#     return True 

# def find_all_primes(x=22):
#     """Find all the primes up to x"""
#     allprimes = []
#     for i in range(2,x+1):
#         if is_prime(i):
#             allprimes.append(i)
#     print("There are %d primes between 2 and %d" %(len(allprimes),x))
#     return allprimes


# def main(argv):
#    """ Main entry point of the program """
#     print(even_or_odd(22))
#     print(largest_divisor_five(120))
#     print(is_prime(60))
#     print(find_all_primes(22))
#     return 0

# if (__name__ == "__main__"):
#    """ Makes sure the "main" function is called from command line """
#     status = main(sys.argv)
#     sys.exit(status)

doctest.testmod()
