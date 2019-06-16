###########################################################################
## FORMVIEW FOR PROCESSING A CONTACT FORM
###########################################################################

from django.http import HttpResponse, HttpResponseRedirect
from django.urls import reverse, reverse_lazy
from django.shortcuts import render, redirect, render_to_response
from django.template.loader import render_to_string
from django.core.mail import send_mail

from django.views.generic import TemplateView, FormView

from website.forms import ContactForm

class ContactPageView(FormView):
	template_name = 'website/contact.html'
	form_class = ContactForm
	success_url = '/contact/'

	def get_context_data(self, **kwargs):
		context = super(ContactPageView, self).get_context_data(**kwargs)
		return context

	def get_success_url(self):
		return reverse_lazy('home')

	def form_valid(self, form, **kwargs):
		context = self.get_context_data(**kwargs)

		website = form.cleaned_data['website']
		name = form.cleaned_data['name']
		email = form.cleaned_data['email']
		phone = form.cleaned_data['phone']
		company = form.cleaned_data['company']
		details = form.cleaned_data['details']

		text_content = 'Website: ' + website + ' Name: ' + name + ' Email: ' + email + ' Phone: ' + phone + ' Company: ' + company + ' Details: ' + details
		html_content = render_to_string('website/email/contact-form.html', {
			'website': website,
			'name': name,
			'email': email,
			'phone': phone,
			'company': company,
			'details': details,
		})

		alert = Object()
		alert.text = '<p>Success!</p><p>Your message was sent successfully.</p>'
		alert.type = 'success'
		context['alert'] = alert

		send_mail(
			subject = 'New Contact Lead from Website',
			message = text_content,
			from_email = 'Messenger <mail@markey.agency>',
			recipient_list = ['luke.h.markey@gmail.com'],
			fail_silently = False,
			html_message = html_content
		)

		## form.send_email() ## TODO - UPDATE FORM CLASS WITH SEND EMAIL FUNCTION

		return super().form_valid(form) ## REDIRECT TO SUCCESS URL
		## return self.render_to_response(context)

	def form_invalid(self, form, **kwargs):
		context = self.get_context_data(**kwargs)

		return super().form_invalid(form)

###########################################################################
## BASIC TEMPLATE VIEW
###########################################################################

from django.http import HttpResponse, HttpResponseRedirect
from django.urls import reverse, reverse_lazy
from django.shortcuts import render, redirect, render_to_response
from django.template.loader import render_to_string

from django.views.generic import TemplateView

class ServiceWebDesignPageView(TemplateView):
	template_name = 'website/services/web-design.html'

	def get_context_data(self, **kwargs):
		context = super(ServiceWebDesignPageView, self).get_context_data(**kwargs)
		return context
