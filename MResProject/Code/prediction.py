#!/usr/bin/env python3
"""This script is used to make predictions by trained CNN algorithm
"""




import os
import gzip
import pickle
import itertools
import time

import numpy as np
from numpy import newaxis 
import scipy.stats

import skimage.transform
from keras import models, layers, activations, optimizers, regularizers
from keras.utils import plot_model
from keras.models import load_model
from keras import backend as K

import matplotlib.pyplot as plt
from sklearn.metrics import confusion_matrix
from sklearn.neighbors import NearestNeighbors
import pymc3 # this will be removed
import pydot # optional
import h5py 


exec(open("/home/shiyun/Documents/sandbox/ImaGene.py").read())


#test any model that is picked
#model = load_model('net(m20).h5')


snps = np.load('/home/shiyun/Documents/sandbox/Data/KCNQ1.vcf.npy')
snpsnew = snps[newaxis,:, :, :]
result = model.predict(snpsnew, batch_size=32)
print('result:', result)

snps = np.load('/home/shiyun/Documents/sandbox/Data/NOS1AP_1.vcf.npy')
snpsnew = snps[newaxis,:, :, :]
result = model.predict(snpsnew, batch_size=32)
print('result2:', result)

snps = np.load('/home/shiyun/Documents/sandbox/Data/CEP85L.vcf.npy')
snpsnew = snps[newaxis,:, :, :]
result = model.predict(snpsnew, batch_size=32)
print('result3:', result)

snps = np.load('/home/shiyun/Documents/sandbox/Data/neutral2.vcf.npy')
snpsnew = snps[newaxis,:, :, :]
result = model.predict(snpsnew, batch_size=32)
print('result4:', result)

snps = np.load('/home/shiyun/Documents/sandbox/Data/positive.vcf.npy')
snpsnew = snps[newaxis,:, :, :]
result = model.predict(snpsnew, batch_size=32)
print('result5:', result)

snps = np.load('/home/shiyun/Documents/sandbox/Data/neutral3.vcf.npy')
snpsnew = snps[newaxis,:, :, :]
result = model.predict(snpsnew, batch_size=32)
print('result6:', result)


snps = np.load('/home/shiyun/Documents/sandbox/Data/newKCNQ1.vcf.npy')
snpsnew = snps[newaxis,:, :, :]
result = model.predict(snpsnew, batch_size=32)
print('result7:', result)

snps = np.load('/home/shiyun/Documents/sandbox/Data/PLN.vcf.npy')
snpsnew = snps[newaxis,:, :, :]
result = model.predict(snpsnew, batch_size=32)
print('result8:', result)

snps = np.load('/home/shiyun/Documents/sandbox/Data/NOS1AP2.vcf.npy')
snpsnew = snps[newaxis,:, :, :]
result = model.predict(snpsnew, batch_size=32)
print('result9:', result)