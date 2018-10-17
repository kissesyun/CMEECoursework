#! /user/bin/env python3
"""An updated version of align_seqs.py.
   Align two given DNA sequences, show all the best alignments and their score"""

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'

# Two example sequences to match
# seq2 = "ATCGCCGGATTACGGG"
# seq1 = "CAATTCGGAT"
#Save the template to a csvfile, use comma to seperate


import csv
with open('../Data/seq.csv') as csvfile:            #read csv.file in python
    readCSV = csv.reader(csvfile, delimiter=',')
    for row in readCSV:
        seq2 = row[0]
        seq1 = row[1]



# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest

l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"
    #import ipdb; ipdb.set_trace()

    # some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ")

    return score

# Test the function with some example starting points:
# calculate_score(s1, s2, l1, l2, 0)
# calculate_score(s1, s2, l1, l2, 1)
# calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1

for i in range(l1): #Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2 #think about what this is doing!
        my_best_score = z 
    elif z == my_best_score:           #use else if to state the circumstance where there are more than one best alignment score
        my_best_align_aga = "." * i + s2 
        sc=[]  #create an empty list to store the new best alignments
        sc.append(my_best_align_aga) #add in new alignments
    

import sys
f = open("../Result/alignment_better.txt", "w")
sto = sys.stdout   #save stdout so we can revert back to it
sys.stdout = f  #from now on, anything that is printed will go to .txt

print(my_best_align)
for item in sc:             #use for loop to print the items in the list on seperate lines
    print(item)
print(s1)
print("Best score:", my_best_score)

f.close()
sys.stdout = sto  #reestablish the regular stdout






