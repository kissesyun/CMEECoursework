#!usr/bin/python
""" Discrete-time version of the LV model with random fluctuation """

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'


import sys
import scipy as sc
import scipy.integrate as integrate
import scipy.stats as stats
import matplotlib.pylab as p  



def dR_dt(pops, t=0):
    """ Returns the growth rate of predator and prey populations at any 
    given time step """

    # R = pops[0]
    # C = pops[1]
    # K = 15   
    # for i in range(t-1):
    #     R[i+1] = R[i] * (1 + (r + stats.norm.rvs(0, 0.1)) * (1 - R[i, 0] / K) - a * C[i])
    #     C[i+1] = C[i] * (1 - z + stats.norm.rvs(0, 0.1) + e * a * R[i, 0])

    # return sc.array([R, C])
    RC = sc.zeros((t, 2))  # pre-allocate
    RC[0, 0] = RC0[0]
    RC[0, 1] = RC0[1]
    for i in range(t-1):
        RC[i+1, 0] = RC[i, 0] * \
            (1 + (r + stats.norm.rvs(0, 0.1)) *
             (1 - RC[i, 0] / K) - a * RC[i, 1])
        RC[i+1, 1] = RC[i, 1] * \
            (1 - z + stats.norm.rvs(0, 0.1) + e * a * RC[i, 0])

    return RC


# Define parameters:
r = float(sys.argv[1]) 
a = float(sys.argv[2]) 
z = float(sys.argv[3]) 
e = float(sys.argv[4]) 
K = 25
	
# define time vector: 
t = 100

R0 = 10
C0 = 5 
RC0 = sc.array([R0, C0]) 

RC = dR_dt(RC0, t)

f1 = p.figure() 
p.plot(range(t), RC[:,0], 'g-', label='Resource density') # Plot
p.plot(range(t), RC[:,1]  , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')

f1.savefig('../Result/LV4_model.pdf') #Save figure