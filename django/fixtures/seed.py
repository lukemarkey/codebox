from django.core.management import BaseCommand, call_command

from user.models import User
from website.models import Inventory, PageContent

class Command(BaseCommand):

	help = "Seed the application with test data for development."

	def handle(self, *args, **options):

		call_command('flush', '--no-input')
		call_command('loaddata','auth')
		call_command('loaddata', 'page')
		call_command('loaddata', 'content')
		call_command('loaddata', 'page-content-list')
		call_command('loaddata', 'inventory')

		# FIX THE PASSWORDS FOR USERS
		for user in User.objects.all():
			user.set_password(user.password)
			user.save()

		## POPULATE SLUGS FOR INVENTORY FIXTURE
		for item in Inventory.objects.all():
			item.save()
