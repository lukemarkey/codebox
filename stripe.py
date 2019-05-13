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
