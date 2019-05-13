from django.db import models
from django.utils.text import slugify
from datetime import date

# REFERENCE MODEL RELATIONSHIPS BY SLUG

class ModelManager(models.Manager):
	def get_by_natural_key(self, slug):
		return self.get(slug=slug)

# MODEL TEMPLATE

class Model(models.Model):

	# list model choices for a select menu
	LISITNG_STATUS = (
		('A', 'Active'),
		('P', 'Pending'),
		('T', 'Trashed')
	)

	name = models.CharField(max_length=200, unique=True)
	slug = models.SlugField(max_length=200, editable=False)

	description = models.TextField(max_length=2000, blank=True, null=True)

	status = models.CharField(max_length=200, choices=LISITNG_STATUS, default='A')

	## FROM APP.STORAGE IMPORT THUMBNAILSTORAGE
	image_aws = models.ImageField(storage=ThumbnailStorage(), blank=True, null=True)
	image_local = models.ImageField(upload_to='images/%m-%Y/', default='images/default.jpg')
	pdf = models.FileField(upload_to='uploads/%m-%Y/')

	price =  models.DecimalField(max_digits=6, decimal_places=2)

	date = models.DateField(default=date.today)
	created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
    	ordering = ['-updated_at']
    	verbose_name_plural = 'Models'

	def __str__(self): # set the name of the model
		return self.name

	def __unicode__(self): # allow many to many iteration in django template
		return self.name

	def save(self, *args, **kwargs):
		if not self.id: # ONLY UPDATE SLUG ON CREATE
			self.slug = slugify(self.name) # AUTOMATICALLY UPDATE SLUG WITH MODEL NAME
		super(Model, self).save(*args, **kwargs)
