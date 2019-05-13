###########################################################################
## SIMPLE CONTACT FORM
###########################################################################

from django import forms

class ContactForm(forms.Form):

	CONTACT_INQUIRY = (
		('S', 'Sales'),
		('P', 'Product Sample'),
		('G', 'General Inquiry')
	)

	name = forms.CharField(required=True) ## REQUIRED=TRUE BY DEFAULT, REQUIRED=FALSE TO MAKE OPTIONAL
	email = forms.EmailField(required=False)
	message = forms.CharField(widget=forms.Textarea(), required=False)

	phone = forms.CharField(required=False) ## PHONE AS CHARFIELD BY DEFAULT OR LIBRARY VALIDATOR

	request = forms.ChoiceField(choices=CONTACT_INQUIRY)

	# INITIATE UPDATES AFTER FORM RENDERED
	def __init__(self, *args, **kwargs):
		super(ContactForm, self).__init__(*args, **kwargs)
		self.fields['name'].widget.attrs.update({'placeholder': 'Name', 'class': 'form-control'})
		self.fields['email'].widget.attrs.update({'placeholder': 'Email', 'class': 'form-control'})
		self.fields['message'].widget.attrs.update({'placeholder': 'Message', 'class': 'form-control'})
		self.fields['request'].widget.attrs.update({'class': 'form-control'})

	# GET VALUES IN FORM FROM UPDATEVIEW AND ADD NEW FORM DATA
	def form_valid(self, form):
		form.instance.net = form.instance.qty * form.instance.price
