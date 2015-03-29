Rails.configuration.stripe = {
  :publishable_key => "pk_test_uHaCkXOtG2nh0WPe1k3VJ6eE",
  :secret_key => "sk_test_l5YX1bsUnU9yUUAKhxr9eTDQ"
  }

Stripe.api_key = Rails.configuration.stripe[:secret_key]