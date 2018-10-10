#!/bin/bash
# Author: Shiyun Liu s.liu18@imperial.ac.uk
# Script: csvtospace.sh
# Desc: substitute the commas in the files with spaces
# saves the output into a .csv file
# Arguments: 1-> tab delimited file
# Date: Oct 2018

### give a caption
echo "Creating a comma delimited version of $1 ..."

### take out the content in the file and use tr to substitute commas with spaces and save it to a new file
cat $1 | tr -s "," " " > $1.csv

###move the result to Result folder
mv $1.csv ../Result/

echo "Done!"
exit

