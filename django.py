# TODO
# class based view get_queryset function
# add namespaces to app/modules for urls

# COMMANDS
python manage.py flush --no-input # FLUSH DATABASE

# SCAFFOLD: URL
from django.urls import path
from django.conf.urls import url

from website import views

app_name = 'website' # namespace urls in template

urlpatterns = [
	path('', views.HomePageView.as_view(), name='home'),
	path('about/', views.AboutPageView.as_view(), name='about'),
]

# SCAFFOLD: VIEW
from django.shortcuts import render
from django.views.generic import TemplateView

class HomePageView(TemplateView):
	template_name = 'website/home.html'

	def get_context_data(self, **kwargs):
		context = super(HomePageView, self).get_context_data(**kwargs)
		return context

# VIEW: SEND MAIL

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

## FORM: CONTACT FORM
from django import forms

class ContactForm(forms.Form):
	name = forms.CharField(
		widget=forms.TextInput(attrs={'placeholder': 'Name'}),
		required=True
	)
	from_email = forms.EmailField(
		widget=forms.EmailInput(attrs={'placeholder': 'Email'}),
		required=True
	)

	message = forms.CharField(
		widget=forms.Textarea(attrs={'placeholder': 'Message'}),
		required=True
	)

# VIEW: QUERY MODEL BY MULTIPLE CATEGORIES
from django.db.models import Q
query = Model.objects.filter(Q(category=category) | Q(category1=category), is_active=True)


