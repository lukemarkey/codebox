###########################################################################
## FUNCTIONAL VIEW TEMPLATE
###########################################################################

from django.http import HttpResponse, HttpResponseRedirect
from django.urls import reverse, reverse_lazy
from django.shortcuts import render, redirect

## MUST PASS URL PARAMETERS AS METHOD INPUTS
def function_view(request, url_param_one, url_param_two):
	post_variable = request.POST.get('form_param')
	url_variable = request.GET.get('url_param')
	url_variable = url_param_one

	return redirect('app:url_name', param=param)

###########################################################################
## CLASS BASED BASIC TEMPLATE VIEW
###########################################################################

from django.http import HttpResponse, HttpResponseRedirect
from django.urls import reverse, reverse_lazy
from django.shortcuts import render, redirect, render_to_response
from django.template.loader import render_to_string
from django.core.mail import send_mail

from django.views.generic import TemplateView

class HomePageView(TemplateView):
	template_name = 'website/home.html'

	def get_context_data(self, **kwargs):
	    context = super(HomePageView, self).get_context_data(**kwargs)
	    parameter = self.kwargs['parameter'] ## GET URL PARAMETER
	    return context

###########################################################################
## GENERIC CLASSES FOR VIEW UTILITY
###########################################################################

## GENERIC OBJECT FOR AGGREGATING QUERY DATA
class Object:

	## RENDER OBJECT AS JSON
	def toJSON(self):
		return json.dumps(self, default=lambda o: o.__dict__, sort_keys=True, indent=4)

###########################################################################
## VIEW QUERY TEMPLATES
###########################################################################

items = Model.objects.all() ## GET ALL MODELS
recent_items = Model.objects.all()[:5] ## GET 5 MOST RECENT MODELS

managed_model_by_slug = Model.objects.get_by_natural_key('slug') ## RETURN OBJECT BY SLUG NOT PK

url_paramter_model = Model.objects.get(slug=self.kwargs.get('slug')) ## GET OBJECT BY URL PARAMETER

models = Model.objects.get(pk=primary_key) ## GET PARENT MODEL
filtered_models = models.filter(filter=filter_by) ## GET SUB MODELS FROM PARENT QUERY
ordered_models = filtered_models.order_by('property_name') ## ORDER SUB MODELS BY ASSIGNMENT

model = Model.objects.filter(pk=primary_key) ## GET MODEL TO BE UPDATED
model = Model.objects.filter(pk=primary_key).update(element=updated_element) ## GET, UPDATE, AND SAVE

###########################################################################
## VIEW QUERY FILTERS
###########################################################################

## ADDITIONAL PRODUCTS QUERY
context['plaques'] = Product.objects.exclude(slug=self.kwargs['plaque_slug']).filter(categories__slug='tribute-plaques')[:6]

## BASIC EXCLUDE AND FILTER BY LIST
products = Product.objects.exclude(categories__slug='tribute-plaques')
categories = ProductCategory.objects.filter(slug__in=['flags', 'crosses', 'military', 'special-forces', 'veterens', 'public-services'])

###########################################################################
## VIEW METHOD FORM VALID SEND MAIL
###########################################################################

def form_valid(self, form, **kwargs):

	context = self.get_context_data(**kwargs)

	name = form.cleaned_data.get('name')
	from_email = form.cleaned_data.get('email')
	subject = form.cleaned_data.get('subject')
	phone = form.cleaned_data.get('phone')
	message = form.cleaned_data.get('message')

	text_content = "Name: " + name + " Email: " + from_email + " Subject: " + subject + " Phone: " + phone + " Message: " + message
	html_content = render_to_string('website/email/contact-form.html', {
		'name': name,
		'email': from_email,
		'subject': subject,
		'phone': phone,
		'message': message
	})

	send_mail(
		subject = "New River Church Contact Request",
		message = text_content,
		from_email = 'Messenger <mail@rivercanton.com>',
		recipient_list = ['mitch@rivercanton.com', 'mitchellpinion@gmail.com'],
		fail_silently = False,
		html_message = html_content
	)
