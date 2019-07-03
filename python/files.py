# FILE PERMISSIONS
# W: WRITE (CLEARS EXISTING FILE)
# R: READ
# A: APPEND
# X: CREATES NEW FILE, OR IF FILE EXISTS: OPERATION FAILS
# R+: BOTH READING AND WRITING

# FILE METHODS
read() #: This function reads the entire file and returns a string
readline() #: This function reads lines from that file and returns as a string. It fetch the line n, if it is been called nth time.
readlines() #: This function returns a list where each element is single line of that file.
write() #: This function writes a fixed sequence of characters to a file.
writelines() #: This function writes a list of string.
append() #: This function append string to the file instead of overwriting the file.

# ABSOLUTE PATH OF FILE
import os
os.path.abspath('~/file.txt')

## TOUCH FILE
open('file.txt', 'a').close()

# OPEN AND READ FILE
with open('file.txt', 'r') as f:
	for line in f:
		print line

# OPEN AND SAVE DATA TO FILE
results = [
	['one','two','three'],
	[1,2,3],
]
with open('file.txt', 'w+') as file:
	try:
		for record in results:
			file.write(" ".join(record)) # write each record separated by a space
			file.write("\n") # add a new line for the next record
	except Exception as e: # handle and print out any errors that occur
		print("Error entering the data in to the file: ", e)

# LOAD JSON FROM OPENED FILE
import json
with open('file', 'r') as json_file:
	decoded_json = json.load(json_file)
