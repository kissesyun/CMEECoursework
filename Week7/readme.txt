Here are Shiyun’s week7（12.11.2018 - 18.11.2018）files for CMEE.

The content is again about Python
1. Numerical computing 
2. Plotting
3. Profiling 
4. Networks
5. Regular expression
6. Workflow building

The commands run in Bash or other Unix-based env.
Program needed to be installed: python3, ipython3; other packages not specifically used in this week’s practicals (install python3-pip to install some python package)

3 folders included.(Results in the Result file are ignored for assessment use)
.
├── Code
│   ├── DrawFW.py
│   ├── LV1.py
│   ├── LV2.py
│   ├── LV3.py
│   ├── LV4.py
│   ├── MyFirstJupyterNb.ipynb
│   ├── TestR.R
│   ├── TestR.py
│   ├── blackbirds.py
│   ├── fmr.R
│   ├── profileme.py
│   ├── profileme2.py
│   ├── regex.py
│   ├── run_LV.py
│   ├── run_fmr_R.py
│   ├── timeitme.py
│   └── using_os.py
├── Data
│   ├── NagyEtAl1999.csv
│   ├── QMEE_Net_Mat_edges.csv
│   ├── QMEE_Net_Mat_nodes.csv
│   ├── TestOaksData.csv
│   └── blackbirds.txt
├── Result
│   ├── Foodweb.pdf
│   ├── LV1_model.pdf
│   ├── LV2_model.pdf
│   ├── LV3_model.pdf
│   ├── LV4_model.pdf
│   ├── LV_model.pdf
│   ├── TestR.Rout
│   ├── TestR_errFile.Rout
│   ├── errorFile.Rout
│   ├── outputFile.Rout
│   └── readme.txt
└── readme.txt


1.Data folder:
Some fasta files and csv files got from github.
Used wget or git clone 

2.Code folder:
Except from the practices .py during python lectures, there are 9 python scripts for practical assessment.
(1) LV1.py, lv2.py, LV3.py and LV4.py
Plot the Lotka-Volterra model
(2) DrawFW.py
Draw a foodweb
(3) blackbirds.py
Practice regex in python and extract info from txt dataset
(4) run_LV.py
Run and profile LV1.py and LV2.py
(5) run_fmr_R.py
Run the Rscript fmr.R through python. And show if the run was successful and prints the error message if there is an error
(6) using_os.py
Use the subprocess.os module to get files and dirs in the directory

3.Result folder:
Here is where the result from Code file goes into.


Thanks for reading me! I hope you or myself later on find it helpful~
