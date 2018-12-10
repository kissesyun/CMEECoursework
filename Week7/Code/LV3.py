#!usr/bin/python
""" Discrete-time version of the LV model """

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'


import sys
import scipy as sc
import scipy.integrate as integrate
import pylab as p  



def dR_dt(pops, t=0):
    """ Returns the growth rate of predator and prey populations at any 
    given time step """

    R = pops[0]
    C = pops[1]
    K = 15   
    for i in range(t-1):
        R[i+1] = R[i]*(1+r*(1 - (R[i]/K))) - a*C[i] 
        C[i+1] = C[i] * (1 - z + e * a * R[i])
    
    return sc.array([R, C])

# Define parameters:
r = float(sys.argv[1]) 
a = float(sys.argv[2]) 
z = float(sys.argv[3]) 
e = float(sys.argv[4]) 

	
# define time vector: integrate from 0 to 15, using 1000 points:
t = sc.linspace(0, 15, 1000)

R0 = 10
C0 = 5 
RC0 = sc.array([R0, C0]) 

pops, infodict = integrate.odeint(dR_dt, RC0, t, full_output=True)


# define time vector: integrate from 0 to 15, using 1000 points:
t = sc.linspace(0, 15, 1000)

R0 = 10
C0 = 5 
RC0 = sc.array([R0, C0]) 

pops, infodict = integrate.odeint(dR_dt, RC0, t, full_output=True)

#infodict['message'] 

f1 = p.figure() 
p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')

f1.savefig('../Result/LV3_model.pdf') #Save figure