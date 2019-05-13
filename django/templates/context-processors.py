## CREATE GLOBAL DICTIONARY FOR PROJECT IN TEMPLATES (CALL AS {{default_title}}, {{default_description}}, etc.)
## CREATE CONTEXT_PROCESSORS.PY IN APP ROOT
## ADD APP.CONTEXT_PROCESSORS.FUNCTION TO SETTINGS

def website_context(request):
	return {
		'default_title': "Atlanta Web Design & Digital Marketing | Luke Markey Freelance",
		'default_description': 'Atlanta freelance services for web design and custom web development. I also specialize in Atlanta SEO and digital marketing services.',
	}
