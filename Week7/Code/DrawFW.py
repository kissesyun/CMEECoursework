#!/usr/bin/env python3
""" Draw a foodweb """
__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'

import networkx as nx
import scipy as sc
import matplotlib.pyplot as p

def GenRdmAdjList(N = 2, C = 0.5):
    """ Generate a foodweb matrix"""
    Ids = range(N)
    ALst = []
    for i in Ids:
        if sc.random.uniform(0,1,1) < C:
            Lnk = sc.random.choice(Ids,2).tolist()
            if Lnk[0] != Lnk[1]: #avoid self (e.g., cannibalistic) loops
                ALst.append(Lnk)
    return ALst

MaxN = 30
C = 0.75

AdjL = sc.array(GenRdmAdjList(MaxN, C))

Sps = sc.unique(AdjL) # get species ids

SizRan = ([-10,10]) #use log10 scale
Sizs = sc.random.uniform(SizRan[0],SizRan[1],MaxN)

p.hist(Sizs)

#plotting
p.close('all')
pos = nx.circular_layout(Sps) #position of the nodes
G = nx.Graph()
G.add_nodes_from(Sps)
G.add_edges_from(tuple(AdjL)) # this function needs a tuple input
NodSizs= 1000 * (Sizs-min(Sizs))/(max(Sizs)-min(Sizs)) 

nx.draw_networkx(G, pos, node_size = NodSizs) 
p.savefig('../Result/Foodweb.pdf') #Save figure
