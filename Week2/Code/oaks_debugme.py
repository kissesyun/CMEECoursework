#! /user/bin/env python3
"""Check if the input species name matches the specific genus in a csv file.
   So that we know which ones the in the species recording csv belong to the certain genus"""

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'

import csv
import sys
import doctest
import ipdb 

#Define function
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus'
    >>> is_an_oak('Fagus sylvatica')
    False
    >>> is_an_oak('Quercuss')
    False
    >>> is_an_oak('Quercus robur')
    True
    """
    return name.lower().split()[0] == ('quercus')

#ipdb.set_trace()

doctest.testmod()   

    
def main(argv): 
    f = open('../Data/TestOaksData.csv','r')
    g = open('../Data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    csvwrite.writerow(['Genus','species'])
    oaks = set()
    next(taxa, None)
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])    

    return 0

    
if (__name__ == "__main__"):
    status = main(sys.argv)

doctest.testmod()    