#!/bin/bash
# Author: Shiyun Liu s.liu18@imperial.ac.uk
# Script: csvtospace.sh
# Desc: substitute the commas in the files with spaces
# saves the output into a .csv file
# Arguments: 1-> tab delimited file
# Date: Oct 2018

echo "Creating a comma delimited version of $1 ..."
cat $1 | tr -s "," "/t" >> $1.csv
echo "Done!"
exit