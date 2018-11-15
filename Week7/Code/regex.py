import re
MyStr = 'an example'
match = re.search(r'\w*\s', MyStr) # what pattern is this?
if match:                      
    print('found a match:', match.group()) 
else:
    print('did not find a match')   

match = re.search(r'2' , "it takes 2 to tango")
match.group()

match = re.search(r'\d' , "it takes 2 to tango") #find number
match.group()

match = re.search(r'\d.*' , "it takes 2 to tango") # * means everything behind
match.group()

match = re.search(r'\s\w{1,3}\s', 'once upon a time') # ???
match.group()

match = re.search(r'\s\w*$', 'once upon a time') # $ means the last one
match.group()

re.search(r'\w*\s\d.*\d', 'take 2 grams of H2O').group() 

re.search(r'^\w*.*\s', 'once upon a time').group() # ^ means the first one

re.search(r'^\w*.*?\s', 'once upon a time').group()

re.search(r'<.+>', 'This is a <EM>first</EM> test').group()

re.search(r'<.+?>', 'This is a <EM>first</EM> test').group()

re.search(r'\d*\.?\d*','1432.75+60.22i').group() # \. means to find a literal dot

re.search(r'[AGTC]+', 'the sequence ATTCGT').group()

re.search(r'\s+[A-Z]{1}\w+\s\w+', 'The bird-shit frog''s name is Theloderma asper').group()

MyStr = 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s&]+",MyStr) #[\w\s] ensures that any combination of word characters and spaces is found.
match.group()

match = re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s&]+",MyStr)
match.group()

match = re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s&]+",MyStr)
if match:
    print(match.group(0))
    print(match.group(1))
    print(match.group(2))
    print(match.group(3))

MyStr = "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory; Another academic, a-academic@imperial.ac.uk, Some other stuff thats equally boring; Yet another academic, y.a_academic@imperial.ac.uk, Some other stuff thats even more boring"
emails = re.findall(r'[\w\.-]+@[\w\.-]+', MyStr) #returns a list of all the emails found
for email in emails:
    print(email)

f = open('../Data/TestOaksData.csv', 'r')
found_oaks = re.findall(r"Q[\w\s].*\s", f.read())

found_oaks


