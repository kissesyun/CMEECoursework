#! /user/bin/env python3
"""Check if the input string matches the strings in csv file"""

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'

import csv
import sys
import doctest

#Define function
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus'
    >>> is_an_oak('Fagus sylvatica')
    False
    >>> is_an_oak('Quercuss')
    False
    """
    return name.lower() == ('quercus')
#import ipdb; ipdb.set_trace()

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
        #import ipdb; ipdb.set_trace()
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])    

    return 0

    
if (__name__ == "__main__"):
    status = main(sys.argv)