from django.core.management import BaseCommand, call_command

from user.models import User
from website.models import Page, PageContent

class Command(BaseCommand):

	help = "Seed the application with test data for development."

	def handle(self, *args, **options):

		## CLEAR DATABASE
		call_command('flush', '--no-input')

		## LOAD AUTH FIXTURE
		call_command('loaddata','auth')
		# FIX THE PASSWORDS FOR USERS
		for user in User.objects.all():
			user.set_password(user.password)
			user.save()

		## LOAD PAGE FIXTURE
		call_command('loaddata', 'page')
		## POPULATE SLUGS FOR PAGE FIXTURE
		for item in Page.objects.all():
			item.save()

		## LOAD PAGE CONTENT FIXTURE
		call_command('loaddata', 'page-content')
		## POPULATE SLUGS FOR PAGE CONTENT FIXTURE
		for item in PageContent.objects.all():
			item.save()
