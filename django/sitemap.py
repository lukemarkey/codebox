from django.urls import reverse

from django.contrib.sitemaps import Sitemap
from website.models import Product

class PageSitemap(Sitemap):
	changefreq = 'monthly'
	priority = 1.0
	protocol = 'https'

	def items(self):
		pages = [
			'website:home-page',
			'website:about-page',
			'website:contact-page',
			'website:refunds-page',
			'website:terms-page',
		]
		return pages

	def location(self, item):
		return reverse(item)


class ProductSitemap(Sitemap):
	changefreq = 'monthly'
	priority = 1.0
	protocol = 'https'

	def items(self):
		return Product.objects.all()

	def lastmod(self, obj):
		return obj.updated_at
