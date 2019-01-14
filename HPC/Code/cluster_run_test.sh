#!/bin/bash
#PBS -l walltime=12:00:00
#PBS -l select=1:ncpus=1:mem=1gb
module load anaconda3/personal
echo "R is about to run"
Rscript $HOME/test/cluster_run_test.R
mv sl518* $HOME/test
echo "R has finished running"
