## FILEPATH: /${APP}/MANAGEMENT/COMMANDS/SEED.PY

from django.core.management import BaseCommand, call_command
from user.models import User

class Command(BaseCommand):
	help = "Seed the application with test data for development."

	def handle(self, *args, **options):
		call_command('flush', '--no-input')
		call_command('loaddata','auth')
		call_command('loaddata', 'content')
		call_command('loaddata', 'listing')

		# FIX THE PASSWORDS OF FIXTURES
		for user in User.objects.all():
			user.set_password(user.password)
			user.save()
