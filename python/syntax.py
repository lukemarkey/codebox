import sys

# DECLARE EMPTY VARIABLE
variable = None

# GET ARGUMENTS FROM COMMAND LINE (python script.py flag)
if len(sys.argv) > 1:
	if sys.argv[1] == 'flag':
		print('flag')
	else:
		print('command not recognized, please use one of the following flags:')
		print('flag')
		sys.exit(1)
else:
	print('no flag used when calling script')
	sys.exit(1)
