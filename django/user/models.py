## USER MODEL FOR PROJECT

from django.contrib.auth.models import AbstractUser
from django.contrib.auth.base_user import BaseUserManager
from django.db import models

class UserManager(BaseUserManager):
	def get_by_natural_key(self, username):
		return self.get(username=username)

class User(AbstractUser):

	# DEFINE ADDITIONAL FIELDS HERE
	objects = UserManager()

	# DEFINE THE CUSTOM PERMISSIONS RELATED TO USER.
	class Meta:
		# permissions = (
		# 	("Admin Permissions", "user_admin"),
		# 	("Member Permissions", "user_member"),
		# )

	def __str__(self):
		return self.username

	def __unicode__(self):
		return self.username
