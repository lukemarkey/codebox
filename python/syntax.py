###########################################################################
## SCRIPT MAIN FUNCTIONS
###########################################################################

def commands():
	print()
	print('Commands:')
	print()
	print('python3 yp.py generate <resource>')
	print('python3 yp.py pages <resource>')
	print('python3 yp.py urls <resource>')
	print('python3 yp.py contacts <resource>')
	print('python3 yp.py csv <resource>')
	print('python3 yp.py commands')
	print()
	sys.exit(1)

if __name__ == '__main__':

	ARG01 = sys.argv[1] if len(sys.argv) > 1 else None
	ARG02 = sys.argv[2] if len(sys.argv) > 2 else None

	SCRIPT_OPTIONS = {
		'generate': generate_resource,
		'pages': generate_pages,
		'csv': generate_csv,
		'commands': commands
	}.get(ARG01, commands)

	SCRIPT_OPTIONS()
	sys.exit(1)
