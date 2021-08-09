string = 'Luke Markey'

# STRING VALIDATORS
string.isalnum()
string.isalpha()
string.isdigit()
string.islower()
string.isspace()
string.isupper()

# STRING MODIFICATIONS
string.lower()
string.upper()
string.strip('substring')
string.lstrip('substring')
string.rstrip('substring')

# REPLACE SUBSTRING WITH NEW TEXT IN STRING
string.replace('old','new')

# ACCESS CHARACTERS IN A STRING
print(string[4]) # returns: ' '
print(string[-3]) # returns: 'k'

# RETURN INDEX OF SUBSTRING IN STRING
index = string.index('Markey') # 5

# SLICE STRING
slice = string[2:6] # 'ke M'
slice = string[:-4] # 'Luke Ma'

# CHARACTER LENGTH OF STRING
length = len(string) # 11

# FORMAT VARIABLES WITHIN A STRING
string = 'Coordinates: {latitude}, {longitude}'.format(latitude='37.24N', longitude='-115.81W')
## % OPERATOR FOR VARIABLES WITHIN A STRING
string = '%d is for an int, %s is for a string, and %f is for a floating point' % (3, 'luke', 4.5)

# FORMAT SPACES IN A STRING
print(format('String', '30s'))
