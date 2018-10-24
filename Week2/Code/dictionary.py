#! /usr/bin/env python3
"""Use python to populate a dictionary and access tuple in tuple"""

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'


taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a short python script to populate a dictionary called taxa_dic 
# derived from  taxa so that it maps order names to sets of taxa. 
# E.g. 'Chiroptera' : set(['Myotis lucifugus']) etc. 

import sys

def taxa_dic(x):                    #define a function called taxa_dic
        dic_loops = set()
        for info in taxa:
                if info[1] == x:
                        dic_loops.add(info[0])
        print(x, dic_loops, sep = ': ')

def main(argv):
    taxa_dic(sys.argv[1])
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)
