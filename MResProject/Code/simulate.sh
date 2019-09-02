#!/bin/bash

###This is a bash script used to define the 
###simulation configurations
###Provided by my supervisor with me modifying some parameters

mkdir -p $2

#Demographic model

NREF=10000 

MARTH1='' 
MARTH2='-eN 0.05 1 -eN 0 14' 
MARTH3='-eN 0.0875 1 -eN 0.075 0.2 -eN 0 2' # Marth 3-epoch for CEU

if [ "$3" -eq "1" ]; then
    DEMO=$MARTH1;
fi
if [ "$3" -eq "2" ]; then
    DEMO=$MARTH2;
fi
if [ "$3" -eq "3" ]; then
    DEMO=$MARTH3;
fi

# Locus and sample size

LEN=80000 
THETA=48  # mutation rate in 4*Ne*LEN scale
RHO=32   # recombination rate
NCHROMS=198 
          
#Selection
SELPOS=`bc <<< 'scale=2; 1/2'`
# relative position of selected allele
FREQ=`bc <<< 'scale=6; 1/100'` 
# frequency of selected allele 
if [ $4 == Binary ]; then 
    SELRANGE=`seq 0 50 400` 
    # range and step for 
    #the selection coefficient 
    #to be estimated in 2*Ne units;
    NREPL=2000 
    # number of replicates (simulations) 
fi
if [ $4 == Continuous ]; then 
    SELRANGE=`seq 0 1 400` 
    NREPL=250 # (250) this is the number 
   
fi
SELTIME=`bc <<< 'scale=4; 600/40000'` # 15kya
# time for the start of selection in 4*Nref generations; 
#e.g. 800/40000 is at 20kya, with Ne=10k and 25 years as gen time.

for SEL in $SELRANGE
do
    java -jar $1 -N $NREF -ms $NCHROMS $NREPL -t 
    $THETA -r $RHO $LEN -Sp $SELPOS -SI 
    $SELTIME 1 $FREQ -SAA $(($SEL*2)) -SAa $SEL -Saa 0 -Smark 
    $DEMO -thread 4 | gzip > $2/msms..$SEL..$SELTIME..txt.gz
done