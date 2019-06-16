## CREATE GLOBAL DICTIONARY FOR PROJECT IN TEMPLATES (CALL AS {{default_title}}, {{default_description}}, etc.)
## CREATE CONTEXT_PROCESSORS.PY IN APP ROOT
## ADD APP.CONTEXT_PROCESSORS.FUNCTION TO SETTINGS

###########################################################################
## SAMPLE CONTEXT PROCESSOR
###########################################################################

from website.models import Event
from django.utils import timezone

today = timezone.now()

def website_context(request):

	try:
		events = Event.objects.all()
		upcoming_events = events.filter(date__date__gt=today)
		expired_events = events.filter(date__date__lt=today)
	except:
		events = None
		upcoming_events = None
		expired_events = None

	return {
		'events': events,
		'upcoming_events': upcoming_events,
		'expired_events': expired_events,
		'default_title': "Atlanta Web Design & Digital Marketing | Luke Markey Freelance",
		'default_description': 'Atlanta freelance services for web design and custom web development. I also specialize in Atlanta SEO and digital marketing services.',
	}
