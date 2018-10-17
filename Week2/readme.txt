Here are Shiyun’s week2（08.10.2018 - 14.10.2018）files for CMEE.

The content is about Python
1. Python variables and operators, as well as data structures(list,tuple,set)
2. Python input and output(text,csv)
3. Write python script(shebang, docstring, internal variables, functions define and modules, main function)
4. Control statements in python (if,elif,while,for) and list comprehensions.
5. Unit testing(doctest) and debugging (pdb)

The commands run in Bash or other Unix-based env.
Program needed to be installed: python3, ipython3; other packages not specifically used in this week’s practicals (install python3-pip to install some python package)

4 folders included.(Results in the Result file are ignored for assessment use)
.
├── Code
│   ├── align_seqs.py
│   ├── align_seqs_better.py
│   ├── align_seqs_fasta.py
│   ├── basic_csv.py
│   ├── basic_io.py
│   ├── boilerplate.py
│   ├── cfexercises1.py
│   ├── cfexercises2.py
│   ├── control_flow.py
│   ├── debugme.py
│   ├── dictionary.py
│   ├── lc1.py
│   ├── lc2.py
│   ├── loops.py
│   ├── oaks_debugme.py
│   ├── scope.py
│   ├── sysargv.py
│   ├── test_control_flow.py
│   ├── tuple.py
│   └── using_name.py
├── Data
│   ├── TestOaksData.csv
│   ├── bodymass.csv
│   ├── fasta
│   │   ├── 407228326.fasta
│   │   ├── 407228412.fasta
│   │   └── E.coli.fasta
│   ├── seq.csv
│   └── testcsv.csv
├── Result
│   ├── JustOaksData.csv
│   ├── alignment.txt
│   ├── alignment_better.txt
│   ├── alignment_fasta.txt
│   └── readme.txt
├── Sandbox
│   ├── test.txt
│   └── testout.txt
└── readme.txt


1.Data folder:
Some fasta files and csv files got from github.
Used wget or git clone 

2.Code folder:
Except from the practices .py during python lectures, there are 8 python scripts for practical assessment.
(1) lc1.py and lc2.py
Use list comprehensions/loops and control statement to select info in tuples
(2) dictionary.py
Use python to populate a dictionary and access tuple in tuple
(3) tuple.py
Print tuples in tuple on separate line
(4) align_seqs.py
Align two given DNA sequences, show the best alignment and score
(5) align_seqs_fasta.py
Align two DNA sequences, show the best alignment and score. Need to take external arguments
(6) align_seqs_better.py
An updated version of align_seqs.py. Align two given DNA sequences, show all the best alignments and their score
(7) oaks_debugme.py
Check if the input species name matches the specific genus in a csv file. So that we know which ones the in the species recording csv belong to the certain genus
  

3.Result folder:
Here is where the result from Code file goes into.

4.Sandbox folder:
Some simple practical test files.

Thanks for reading me! I hope you or myself later on find it helpful~
