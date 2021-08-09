# REPEAT LOOP UNTIL VALIDATION PASSES
while True:
	value = input('Please enter a distance value in kilometers: ')
	try: # test that the input can be converted to a float
		kilometers = float(value)
	except ValueError: # if the input is not able to be converted or blank, prompt user for a new value.
		print('Please enter a valid number')
		continue
	break # if the above statements complete, then break the while loop

# CHECK FOR VALID NUMBER
try:
	kilometers = float(value)
except ValueError:
	print('Please enter a valid number')
