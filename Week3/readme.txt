Here are Shiyun’s week3（15.10.2018 - 21.10.2018）files for CMEE.

The content is about R
1. Install R/Rstudio, R Workspace and Working Directory
2. Basic R commands, variables types and data structure types(vector, matrix, array, list, dataframe) 
3. R commands for manipulating data (strsplit, paste) and generating Random Numbers(norm,sample,seed).
4. Import and export data (write. read.), write and run R code(source and Rscript), define R function and control statements in R.
5. Vectorization in R (Pre-allocation, apply family)
5. R packages

The commands run in Bash or other Unix-based env.
Program needed to be installed: Rstudio

4 folders included.(Results in the Result file are ignored for assessment use)
.
├── Code
│   ├── CompileLaTeX.sh
│   ├── TAutoCorr.R
│   ├── TreeHeight.R
│   ├── Vectorize.R
│   ├── Vectorize1.R
│   ├── Vectorize2.R
│   ├── apply1.R
│   ├── basic_io.R
│   ├── boilerplate.R
│   ├── break.R
│   ├── browser.R
│   ├── control.R
│   ├── correlation_result.tex
│   ├── get_TreeHeight.R
│   ├── map.R
│   ├── next.R
│   ├── preallocate.R
│   ├── run_get_TreeHeight.sh
│   └── sample.R
├── Data
│   ├── EcolArchives-E089-51-D1.csv
│   ├── GPDDFiltered.RData
│   ├── KeyWestAnnualMeanTemperature.RData
│   └── trees.csv
├── Result
│   ├── MyData.csv
│   ├── TreeHts.csv
│   ├── correlation_result.pdf
│   └── trees_treeheights.csv
├── Sandbox
└── readme.txt

1.Data folder:
Some Rdata files and csv files got from github.
Used wget or git clone 

2.Code folder:
Except from the practices .R during python lectures, there are 5 R scripts for practical assessment, 1 tex for LaTex usage and 2 bash scripts.
(1) TreeHeight.R
This function calculates heights of trees given distance of each tree from its base and angle to its top, using  the trigonometric formula.
With internal input and exporting the output to result file.
(2) get_TreeHeight.R
Updated version of TreeHeight.R. It can take external input file as argument. And the output file name varies along with the input filename.
(3) Vectorize2.R
Runs the stochastic (with gaussian fluctuations) Ricker Eqn. Vectorized version.
(4) TAutoCorr.R
Analyse the temperature data obtained from 100 years.
(5) map.R
Map the Global Population Dynamics Database
(6) run_get_TreeHeight.sh
Bash script to run get_TreeHeight.R and external argument.
(7) CompileLaTeX.sh 
Bash script to run LaTex
(8) correlation_result.tex
Template tex. with content to generate pdf

3.Result folder:
Here is where the result from Code file goes into.

4.Sandbox folder:
Where simple practical test files can go.

Thanks for reading me! I hope you or myself later on find it helpful~
