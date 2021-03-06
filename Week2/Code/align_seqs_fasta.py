#! /usr/bin/env python3
"""Align two DNA sequences, show the best alignment and score. Need to take external arguments"""

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'
import sys

# use sys.argv to take the external input.
### Note that the fasta files are under Week2/Data/fasta/ directory


with open(sys.argv[1]) as file_one:
    sequence = file_one.read()
lines = sequence.split('\n',1)[-1]
seq1= lines.strip('\n')

with open(sys.argv[2]) as file_two:
    sequence = file_two.read()
lines = sequence.split('\n',1)[-1]
seq2= lines.strip('\n')


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
    """Calculate the alignment score for s1 and s2"""
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    # print("." * startpoint + matched)           
    # print("." * startpoint + s2)
    # print(s1)
    # print(score) 
    # print(" ")

    return score

# Test the function with some example starting points:
# calculate_score(s1, s2, l1, l2, 0)
# calculate_score(s1, s2, l1, l2, 1)
# calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2 # think about what this is doing!
        my_best_score = z 
        

import sys
f = open("../Result/alignment_fasta.txt", "w")
sto = sys.stdout   #save stdout so we can revert back to it
sys.stdout = f  #from now on, anything that is printed will go to .txt

print(my_best_align)
print(s1)
print("Best score:", my_best_score)

f.close()
sys.stdout = sto #reestablish the regular stdout









