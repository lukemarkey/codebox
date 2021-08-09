# POPULATE DICTIONARY INITIAL VALUES
data = {'a':1,'b':2,'c':3}
data = dict(a=1, b=2, c=3)
data = {k: v for k, v in (('a', 1),('b',2),('c',3))}

# INSERT/UPDATE VALUES
data['a']=1  # updates if 'a' exists, else adds 'a'
data.update({'a':1})
data.update(dict(a=1))
data.update(a=1)
data.update({'c':3,'d':4})  # updates 'c' and adds 'd'

# MERGE DICTIONARY
data3 = {}
data3.update(data)  # Modifies data3, not data
data3.update(data2)  # Modifies data3, not data2

# DELETE ITEMS
del data[key]  # Removes specific element in a dictionary
data.pop(key)  # Removes the key & returns the value
data.clear()  # Clears entire dictionary

# CHECK IF KEY IN DICTIONARY
if key in data:

# ITERATE PAIRS IN A DICTIONARY
for key, value in data.items(): # Iterates through the pairs
for key in data.keys(): # Iterates just through key, ignoring the values
for value in data.values(): # Iterates just through value, ignoring the keys

# CREATE DICTIONARY FROM 2 LISTS
data = dict(zip(list_with_keys, list_with_values))

## INITIALIZE DICTIONARY WITH LIST OF KEYS AND INITIAL DEFAULT VALUE
data = dict.fromkeys(Key_list, 'initial_default_value')
