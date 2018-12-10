#!/bin/bash

Rscript get_TreeHeight.R ../Data/trees.csv

python3 get_TreeHeight.py ../Data/trees.csv
