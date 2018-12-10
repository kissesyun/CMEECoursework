#!usr/bin/python
""" Discrete-time version of the LV model """

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'


import sys
import scipy as sc
import scipy.integrate as integrate
import matplotlib.pylab as p  



def dR_dt(pops, t=0):
    """ Returns the growth rate of predator and prey populations at any 
    given time step """
    # R = sc.zeros((t,1), dtype='float') 
    # C = sc.zeros((t,1), dtype='float')
    # R[0] = pops[0]
    # C[0] = pops[1]
    # K = 15   
    # for i in range(0,t-1):
    #     R[i+1] = R[i]*(1+r*(1 - (R[i]/K))) - a*C[i] 
    #     C[i+1] = C[i] * (1 - z + e * a * R[i])
    
    # return sc.array([R, C])

    RC = sc.zeros((t, 2), dtype='float')  
    RC[0, 0] = RC0[0]
    RC[0, 1] = RC0[1]
    for i in range(t-1):
        RC[i+1, 0] = RC[i, 0] * (1 + r * (1 - RC[i, 0] / K) - a * RC[i, 1])
        RC[i+1, 1] = RC[i, 1] * (1 - z + e * a * RC[i, 0])

    return RC

# Define parameters:
r = float(sys.argv[1]) 
a = float(sys.argv[2]) 
z = float(sys.argv[3]) 
e = float(sys.argv[4]) 
K = 25

	
# define time vector: integrate from 0 to 15, using 1000 points:
t = 100

R0 = 10
C0 = 5 
RC0 = sc.array([R0, C0], dtype = 'float') 

RC = dR_dt(RC0, t)


f1 = p.figure() 
p.plot(range(t), RC[:,0], 'g-', label='Resource density') # Plot
p.plot(range(t), RC[:,1]  , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')


# p.show()

f1.savefig('../Result/LV3_model.pdf') #Save figure