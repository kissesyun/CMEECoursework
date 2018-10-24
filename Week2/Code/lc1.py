#! /usr/bin/env python3

"""Use list comprehensions/loops and control statement to select info in tuples"""

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

###Using loops to creat 3 lists
latin_loops = set()
for info in birds:       
    latin_loops.add(info[0])            #tuple[] to access tuple inside tuple
print("latin names are", latin_loops)

name_loops = set()
for info in birds:
    name_loops.add(info[1])
print("common names are", name_loops)

mass_loops = set()
for info in birds:
    mass_loops.add(info[2])
print("mean body mass are", mass_loops)

###Using list comprehensions to do the same job
latin_lc = set([info[0] for info in birds])
print(latin_lc)

name_lc = set([info[1] for info in birds])
print(name_lc)

mass_lc = set([info[2] for info in birds])
print(mass_lc)

