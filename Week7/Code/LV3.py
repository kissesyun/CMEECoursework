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
    R = pops[0]
    C = pops[1]
    dRdt = r * R * (1 - R / K) - a * R * C
    dydt = -z * C + e * a * R * C

    return sc.array([dRdt, dydt])

# Define parameters:
if len(sys.argv) == 4:
    r = float(sys.argv[1])
    a = float(sys.argv[2])
    z = float(sys.argv[3])
    e = float(sys.argv[4])
else:
    r = 1.
    a = 0.1
    z = 1.5
    e = 0.75

K = 500

# define time vector: integrate from 0 to 15, using 1000 points:
t = sc.linspace(0, 20, 1000)

R0 = 10
C0 = 5
RC0 = sc.array([R0, C0]) 

pops, infodict = integrate.odeint(dR_dt, RC0, t, full_output=True)
prey, predators = pops.T 

f1 = p.figure() 
p.plot(t, prey, 'g-', label='Resource density') # Plot
p.plot(t, predators , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')


# p.show()

f1.savefig('../Result/LV3_model.pdf') #Save figure