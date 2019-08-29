#!/bin/bash
###Generated with suggestions from my supervisor


date

MODE=Binary 


DIRDATA=/home/shiyun/Documents/sandbox/Binary3


for repetition in {1..100}
do
	
	FNAME=$DIRDATA/Simulations$repetition.Epoch3
	echo $FNAME
	mkdir -p $FNAME
	bash /home/shiyun/Documents/sandbox/simulate.sh /home/shiyun/Documents/msms3.2rc-b163.jar $FNAME 3 $MODE
done

date


