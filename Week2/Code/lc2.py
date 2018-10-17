#! /user/bin/env python3

"""Use list comprehensions/loops and control statement to select info in tuples"""

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'



# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.
 
# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 

# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 

###Using loops
#1.use control statement to select the 2nd item in tuple and check if it is greater than 100
rainfall_loops = set()
for info in rainfall:               #use for loop to add in the tuples in tuple
    if info[1] > 100:
        rainfall_loops.add(info)
print("rainfall greater than 100mm", rainfall_loops)

#2.use control statement to select the 2nd item in tuple and check if it is less than 50
rainfall_loops = set()
for info in rainfall:
    if info[1] < 50:
        rainfall_loops.add(info)
print("rainfall less than 50mm", rainfall_loops)

###Using list comprehension
#1.print month and rainfall if the amount is greater than 100mm
rainfall_lc = set([info for info in rainfall if info[1] > 100])
print(rainfall_lc)
#2.print month and rainfall if the amount is less than 50mm
rainfall_lc = set([info for info in rainfall if info[1] < 50])
print(rainfall_lc)






