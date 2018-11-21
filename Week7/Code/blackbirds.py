#!/usr/bin/env python3

""" Practice regex in python and extract info from txt dataset """

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'


import re
import pandas as pd

# Read the file
f = open('../Data/blackbirds.txt', 'r')
text = f.read()
f.close()

# remove \t\n and put a space in:
text = text.replace('\t',' ')
text = text.replace('\n',' ')

# note that there are "strange characters" (these are accents and
# non-ascii symbols) because we don't care for them, first transform
# to ASCII:
text = text.encode('ascii', 'ignore').decode() #will not work in python 3

# Now extend this script so that it captures the Kingdom, 
# Phylum and Species name for each species and prints it out to screen neatly.

# Hint: you may want to use re.findall(my_reg, text)...
# Keep in mind that there are multiple ways to skin this cat! 
# Your solution may involve multiple regular expression calls (easier!), or a single one (harder!)

my_reg3 = r'\bKingdom\b\s+?([a-zA-Z]+)\s+?.+?\bPhylum\b\s+?([a-zA-Z]+)\s+?.+?\bSpecies\b\s+?([a-zA-Z]+\s[a-zA-Z]+)' 


string = "Kingdom Animalia  – Animal, animaux, animals        Phylum Chordata  – cordés, cordado, chordates           Subphylum Vertebrata  – vertebrado, vertébrés, vertebrates              Class Aves  – Birds, oiseaux                 Order Passeriformes  – Perching Birds, passereaux                    Family Icteridae  – American Blackbirds, Orioles, New World Blackbirds                       Genus Euphagus Cassin, 1867 – American Blackbirds                          Species Euphagus carolinus (Statius Muller, 1776) – Tordo canadiense, Rusty Blackbird, quiscale rouilleux                             Subspecies Euphagus carolinus carolinus (Statius Muller, 1776)"
find_kingdom = re.findall(r"Kingdom\s[a-zA-Z]+", text)
find_phylum = re.findall(r"Phylum\s[a-zA-Z]+", text)
find_species = re.findall(r"Species\s[a-zA-Z]+\s[a-zA-Z]+", text)

table = pd.DataFrame(
    {'Kingdom': find_kingdom,
    'Phylum': find_phylum,
    'Species': find_species})

print(table)
