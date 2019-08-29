#!/usr/bin/env python3
"""This script is used to convert vcf files to numpy array that can then be predicted by the trained model"""




import allel
import skimage
import numpy as np
from numpy import newaxis
from sklearn.neighbors import NearestNeighbors
#import matplotlib.pyplot as plt

#read the vcf file and only extract those with 1 alternative allele
callset = allel.read_vcf('/home/shiyun/Documents/sandbox/Data/NOS1AP2.vcf', numbers={'ALT': 1,'AF': 1})
#callset = allel.read_vcf('/home/shiyun/Documents/sandbox/Data/KCNQ1.vcf', numbers={'ALT': 1,'AF': 1})
#callset = allel.read_vcf('/home/shiyun/Documents/sandbox/Data/CEP85L.vcf', numbers={'ALT': 1,'AF': 1})
#callset = allel.read_vcf('/home/shiyun/Documents/sandbox/Data/neutral3.vcf', numbers={'ALT': 1,'AF': 1})
#callset = allel.read_vcf('/home/shiyun/Documents/sandbox/Data/positive.vcf', numbers={'ALT': 1,'AF': 1})
#callset = allel.read_vcf('/home/shiyun/Documents/sandbox/Data/newKCNQ1.vcf', numbers={'ALT': 1,'AF': 1})
#callset = allel.read_vcf('/home/shiyun/Documents/sandbox/Data/PLN.vcf', numbers={'ALT': 1,'AF': 1})

#show the fields
#sorted(callset.keys())

#get the genotype
gt = allel.GenotypeArray(callset['calldata/GT'])
#reshape it so that all genotypes (0/0,0/1,1/1) shows along rows. Notice that the row is haplotype while column is SNP sites.
dim = gt.shape
dimnew = (dim[0],dim[1]*dim[2],1)
#remove rows which are all 0 values (means no polymorphism) caused by DataSlicer
snps = gt.reshape(dimnew)
r = np.copy(snps)
r1 = np.squeeze(r, axis=2) #remove the 3rd axis
r2 = r1[~np.all(r1 == 0, axis=1)] #remove the row where
r3 = r2.transpose()
#snpsnew = snpsnew[:, :, newaxis]


snpsnew = np.where(r3==1, 255, r3)
snpsnew = snpsnew[:, :, newaxis]

snpsnew = snpsnew.astype('uint8')


#major and minor
idx = np.where(np.mean(snpsnew[:,:,0]/255., axis=0) > 0.5)[0]
snpsnew[:,idx,0] = 255. - snpsnew[:,idx,0]

#Remove sites whose minor allele frequency is below the set threshold.
idx = np.where(np.mean(snpsnew[:,:,0]/255., axis=0) >= 0.01)[0]
snpsnew = snpsnew[:,idx,:]

#sort function from ImaGene.py
def sort(data, ordering):
    """
    Sort rows and/or columns given an ordering.

    Keyword Arguments:
        ordering: either 'rows_freq', 'cols_freq', 'rows_dist', 'cols_dist'

        Returns:
            0
        """
    if ordering == 'rows_freq':
        uniques, counts = np.unique(data, return_counts=True, axis=0)
        counter = 0
        for j in counts.argsort()[::-1]:
            #argsort() used to return the indices that would sort an array.
            #[::-1] from end to first
            for z in range(counts[j]):
                data[counter,:,:] = uniques[j,:,:]
                counter += 1
        return data
    elif ordering == 'cols_freq':
        uniques, counts = np.unique(data, return_counts=True, axis=1)
        counter = 0 #
        for j in counts.argsort()[::-1]:
            for z in range(counts[j]):
                data[:,counter,:] = uniques[:,j,:]
                counter += 1
        return data
    elif ordering == 'rows_dist':
        uniques, counts = np.unique(data, return_counts=True, axis=0)
        # most frequent row in float
        top = uniques[counts.argsort()[::-1][0]].transpose().astype('float32')
        # distances from most frequent row
        distances = np.mean(np.abs(uniques[:,:,0] - top), axis=1)
        # fill in from top to bottom
        counter = 0
        for j in distances.argsort():
            for z in range(counts[j]):
                data[counter,:,:] = uniques[j,:,:]
                counter += 1
        return data
    elif ordering == 'cols_dist':
        uniques, counts = np.unique(data, return_counts=True, axis=1)
        # most frequent column
        top = uniques[:,counts.argsort()[::-1][0]].astype('float32')
        # distances from most frequent column
        distances = np.mean(np.abs(uniques[:,:,0] - top), axis=0)
        # fill in from left to right
        counter = 0
        for j in distances.argsort():
            for z in range(counts[j]):
                data[:,counter,:] = uniques[:,j,:]
                counter += 1
        return data
    elif ordering == 'rows_similarity':
        #global snpsnew
        data = np.squeeze(data, axis=2)
        neigh = NearestNeighbors(len(data), metric='manhattan')
        neigh.fit(data)
        inx = neigh.kneighbors(data)
        middle = np.argmin(inx[0].sum(axis=1))
        data = data[inx[1][middle]]
        data = data[:, :, newaxis]
        return data
    elif ordering == 'cols_similarity':
        data = np.squeeze(data, axis=2)
        data = data.transpose()
        neigh = NearestNeighbors(len(data), metric='manhattan')
        neigh.fit(data)
        inx = neigh.kneighbors(data)
        middle = np.argmin(inx[0].sum(axis=1))
        data = data[inx[1][middle]]
        data = data.transpose()
        data = data[:, :, newaxis]
        return data
snpsnew = sort(snpsnew,'rows_freq') 
snpsnew = sort(snpsnew,'cols_freq')
#snpsnew = sort(snpsnew,'rows_dist') 
#snpsnew = sort(snpsnew,'cols_dist')
#snpsnew = sort(snpsnew,'rows_similarity')
#snpsnew = sort(snpsnew,'cols_similarity')


#resize the image to desired dimension
image = np.copy(snpsnew[:,:,0])
data = np.zeros((198, 198, 1), dtype='uint8')
data[:,:,0] = (skimage.transform.resize(image, (198,198), anti_aliasing=True, mode='reflect')*255).astype('uint8')
del image
data = (np.where(data < 128, 0, 255)).astype('uint8')


#convert to float32
data = data.astype('float32')
data /= 255.

#flip it
data = 1. - data


#save the numpy array
np.save('/home/shiyun/Documents/sandbox/Data/NOS1AP2.vcf.npy',data)
#np.save('/home/shiyun/Documents/sandbox/Data/KCNQ1.vcfs.npy',data)
#np.save('/home/shiyun/Documents/sandbox/Data/CEP85L.vcf.npy',data)
#np.save('/home/shiyun/Documents/sandbox/Data/neutral3.vcf.npy',data)
#np.save('/home/shiyun/Documents/sandbox/Data/positive.vcfss.npy',data)
#np.save('/home/shiyun/Documents/sandbox/Data/newKCNQ1.vcf.npy',data)
#np.save('/home/shiyun/Documents/sandbox/Data/PLN.vcf.npy',data)

