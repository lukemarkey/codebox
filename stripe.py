# standard checkout integration

<form action="{% url 'charge' %}" method="post">
  {% csrf_token %}
  <script src="https://checkout.stripe.com/checkout.js" class="stripe-button"
          data-key="{{key}}"
          data-description="A Django Charge"
          data-amount="500"
          data-locale="auto"></script>
</form>

## custom html checkout integration

<script src="https://checkout.stripe.com/checkout.js"></script>

<button id="customButton">Purchase</button>

<script>
var handler = StripeCheckout.configure({
  key: '${STRIPE_PUBIC_API_KEY}',
  image: 'https://stripe.com/img/documentation/checkout/marketplace.png',
  locale: 'auto',
  token: function(token) {
    // You can access the token ID with `token.id`.
    // Get the token ID to your server-side code for use.
  }
});

document.getElementById('customButton').addEventListener('click', function(e) {
  // Open Checkout with further options:
  handler.open({
    name: 'LUKE MARKEY INC.',
    email: 'test@gmail.com',
    description: '2 widgets',
    amount: 2000,
    zipCode: true
  });
  e.preventDefault();
});

// Close Checkout on page navigation:
window.addEventListener('popstate', function() {
  handler.close();
});
</script>

## handle checkout payment on backend

stripe.api_key = "${STRIPE_PRIVATE_API_KEY}"

# Token is created using Checkout or Elements!
# Get the payment token ID submitted by the form:
token = request.form['stripeToken'] # Using Flask

charge = stripe.Charge.create(
    amount=999,
    currency='usd',
    description='Example charge',
    source=token,
)

## save credit card and create customer on payment

stripe.api_key = "${STRIPE_PRIVATE_API_KEY}"

# Create a Customer:
customer = stripe.Customer.create(
  source='tok_mastercard',
  email='paying.user@example.com',
)

# Charge the Customer instead of the card:
charge = stripe.Charge.create(
  amount=1000,
  currency='usd',
  customer=customer.id,
)

# YOUR CODE: Save the customer ID and other info in a database for later.

# When it's time to charge the customer again, retrieve the customer ID.
charge = stripe.Charge.create(
  amount=1500, # $15.00 this time
  currency='usd',
  customer=customer_id, # Previously stored, then retrieved
)

## update customer's default payment method

stripe.api_key = "${STRIPE_PRIVATE_API_KEY}"

stripe.Customer.modify('cus_V9T7vofUbZMqpv',
 source='tok_visa',
)

###########################################################################
## STRIPE VIEW CHARGE LOGIC
###########################################################################

try:
    charge = stripe.Charge.create(
      amount={{amount}},
      currency="usd",
      customer={{customer}},
      description={{description}},
      metadata={{this.id}}
  )
except stripe.error.CardError as e:
    # Problem with the card
    pass
except stripe.error.RateLimitError as e:
    # Too many requests made to the API too quickly
    pass
except stripe.error.InvalidRequestError as e:
    # Invalid parameters were supplied to Stripe API
    pass
except stripe.error.AuthenticationError as e:
    # Authentication Error: Authentication with Stripe API failed (maybe you changed API keys recently)
    pass
except stripe.error.APIConnectionError as e:
    # Network communication with Stripe failed
    pass
except stripe.error.StripeError as e:
    # Stripe Error
    pass
else:
    #success

###########################################################################
## STRIPE SESSION
###########################################################################

stripe.api_key = 'sk_test_GwQ7dDLVGQt09EO6a0HaeDG300kFYCvJaW'

session = stripe.checkout.Session.create(
  payment_method_types=['card'],
  line_items=[{
    'name': 'T-shirt',
    'description': 'Comfortable cotton t-shirt',
    'images': ['https://example.com/t-shirt.png'],
    'amount': 500,
    'currency': 'usd',
    'quantity': 1,
  }],
  success_url='https://example.com/success',
  cancel_url='https://example.com/cancel',
)
