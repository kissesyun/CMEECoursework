#!/usr/bin/env python3
"""This script is used to train model for multiple classes machine learning
   Generated with suggestions from my supervisor
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

start_time = time.time()

name = 'm20'


myfile = ImaFile(simulations_folder='/home/shiyun/Documents/sandbox/Binary3/Simulations1.Epoch3',nr_samples=198, model_name='3epoch-CEU') 
mygene = myfile.read_simulations(parameter_name='selection_coeff_hetero', max_nrepl=2000)
#mygene.summary()

#
#freqs = calculate_allele_frequency(mygene, 0.5)
#plt.scatter(mygene.targets, freqs, marker='o')
#plt.xlabel('Target')
#plt.ylabel('Allele frequency')
#plt.savefig('/home/shiyun/Documents/sandbox/2000binary/freq_b2.png')

mygene.majorminor()
mygene.filter_freq(0.01)
#mygene.sort('rows_similarity')
#mygene.sort('cols_similarity')
mygene.sort('rows_freq')
mygene.sort('cols_freq')
mygene.resize(dimensions=(198, 198))
mygene.convert(verbose=True)

#for sel in mygene.classes:
#    print(sel)
#    index = np.where(mygene.targets == sel)[0][0]
#    plt.imshow(mygene.data[index][:,:,0], cmap='gray')
#    plt.savefig('/home/shiyun/Documents/sandbox/2000binary/SC' + str(sel) + '.png')

mygene.summary()



rnd_idx = get_index_random(mygene)
mygene.subset(rnd_idx)

mygene.targets = to_categorical(mygene.targets)
#mygene.targets = to_binary(mygene.targets)

mygene.save(file='mygene(%s)' %name)
#mygene = load_imagene(file='mygene(%s)' %name)

model = models.Sequential([
                    layers.Conv2D(filters=32, kernel_size=(3,3), strides=(1,1), activation='relu', kernel_regularizer=regularizers.l1_l2(l1=0.005, l2=0.005), padding='valid', input_shape=mygene.data.shape[1:4]),
                    layers.MaxPooling2D(pool_size=(2,2)),
                    layers.Conv2D(filters=32, kernel_size=(3,3), strides=(1,1), activation='relu', kernel_regularizer=regularizers.l1_l2(l1=0.005, l2=0.005), padding='valid'),
                    layers.MaxPooling2D(pool_size=(2,2)),
                    layers.Conv2D(filters=32, kernel_size=(3,3), strides=(1,1), activation='relu', kernel_regularizer=regularizers.l1_l2(l1=0.005, l2=0.005), padding='valid'),
                    layers.MaxPooling2D(pool_size=(2,2)),
                    layers.Flatten(),
                    #layers.Dense(units=64, activation='relu'),
                    layers.Dense(units=5, activation='softmax')])
                    #layers.Dense(units=1, activation='sigmoid')])

model.compile(optimizer='rmsprop',
              #loss='binary_crossentropy',
              loss='categorical_crossentropy',
              metrics=['accuracy'])

model.summary()
plot_model(model, 'net(%s).png' %name)

mynet = ImaNet(name='[C64+P]x3+D1')

#e=1
#while e < 4:
    #print(e)
score = model.fit(mygene.data, mygene.targets, batch_size=32, epochs=1, verbose=1, validation_split=0.10)
mynet.update_scores(score)
    #e += 1


i = 2
while i < 50:

    print(i)
    
    myfile = ImaFile(simulations_folder='/home/shiyun/Documents/sandbox/Binary3/Simulations' + str(i) + '.Epoch3', nr_samples=198, model_name='3epoch-CEU')
    mygene = myfile.read_simulations(parameter_name='selection_coeff_hetero', max_nrepl=2000)

    mygene.majorminor()
    mygene.filter_freq(0.01)
    #mygene.sort('rows_similarity')
    #mygene.sort('cols_similarity')
    mygene.sort('rows_freq')
    mygene.sort('cols_freq')
    mygene.resize(dimensions=(198, 198))
    mygene.convert()

    #mygene.classes = np.array([0,300])
    #mygene.subset(get_index_classes(mygene.targets, mygene.classes))
    mygene.subset(get_index_random(mygene))

    #mygene.targets = to_binary(mygene.targets)
    mygene.targets = to_categorical(mygene.targets)
    
    #e=1
    #while e < 4:
        #print(e)
    score = model.fit(mygene.data, mygene.targets, batch_size=32, epochs=1, verbose=1, validation_split=0.10)
    mynet.update_scores(score)
        #e += 1
    
    
    i += 1


mynet.plot_train(file='Trainning(%s).png' %name)
model.save('net(%s).h5' %name)
#model = load_model('net(%s).h5' %name)
mynet.save(file='mynet(%s)' %name)
#mynet = load_imanet(file='mynet(%s)' %name)

i = 50
myfile = ImaFile(simulations_folder='/home/shiyun/Documents/sandbox/Binary3/Simulations' + str(i) + '.Epoch3', nr_samples=198, model_name='3epoch-CEU')
mygene_test = myfile.read_simulations(parameter_name='selection_coeff_hetero', max_nrepl=2000)

mygene_test.majorminor()
mygene_test.filter_freq(0.01)
#mygene_test.sort('rows_similarity')
#mygene_test.sort('cols_similarity')
mygene_test.sort('rows_freq')
mygene_test.sort('cols_freq')
mygene_test.resize((198, 198))
mygene_test.convert()


rnd_idx = get_index_random(mygene_test)
mygene_test.subset(rnd_idx)

mygene_test.targets = to_categorical(mygene_test.targets)
#mygene_test.targets = to_binary(mygene_test.targets)

mygene_test.save(file='mygene_test(%s)' %name)
#mygene_test = load_imagene(file='mygene_test(%s)' %name)

mynet.test = model.evaluate(mygene_test.data, mygene_test.targets, batch_size=None, verbose=0)
print('mynet.test:',mynet.test)



mynet.predict(mygene_test, model)
mynet.values.shape


mynet.plot_cm(mygene_test.classes, file='cm(%s).png' %name)
plt.close()
mynet.plot_scatter(file='scatter(%s).png' %name)



print("--- %s seconds ---" % (time.time() - start_time))

#model = load_model('net(m13).h5')

