Here are Shiyun’s week1（01.10.2018 - 07.10.2018）files for CMEE.

The content is about 1.Unix, 2.shell scripting, 3.version control with git and 4.LaTex.
1. Basic Unix commands: 
   (1)brew install software, e.g.visual studio code
   (2)open new file and folder and move around, mkdir, touch, nano, cp, mv
   (3)ls, cd, pwd, man
   (4)wc, grep, find, echo, cat
2. Bash script:
   (1)run example .sh files
   (2)use read to enter variable.
3. Version control using git to trace the changes I made and back up:
   (1)have remote repository on github and use ssh to link my local repository with my local one.
   (2)use git add, git commit and git push
   (3)always check git status
   (4)add gitignore to stop tracing some certain files
4. LaTex writing scientific documents:
   (1)install LaTex
   (2)turn .tex to pdf by pdflatex 
   (3)add citation by bibtex, citation information in .bib file
                        
The commands run in Bash or other Unix-based env.
Program needed to be installed: LaTex 
4 folders included.

1.Data folder:
Some fasta files and csv files got from github.
Used wget or git clone 

2.Code folder:
  (1)csvtospace.sh (shell script to convert commas to spaces in a file)
  (2)FirstExample.tex (LaTex example script), FirstBiblio.bib (bibliography file),   CompileLaTeX.sh (latex running script)
  (3) UnixPrac1.txt (practical for Unix chapter in a txt including answers to 5 questions)

3.Result folder:
Here is where the result from Code goes into.

4.Sandbox folder:
some simple practice bash scripts (learn and test) including:
boilerplate.sh
ConcatenateTwoFile,sh
CountLines.sh
MyExampleScript.sh
tabtocsv.sh
variable.sh

