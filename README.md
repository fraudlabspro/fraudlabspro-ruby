[![Latest Stable Version](https://img.shields.io/gem/v/fraudlabspro_ruby.svg)](https://rubygems.org/gems/fraudlabspro_ruby)
[![Total Downloads](https://img.shields.io/gem/dt/fraudlabspro_ruby.svg)](https://rubygems.org/gems/fraudlabspro_ruby)

FraudLabs Pro Ruby SDK
========================
This Ruby module enables user to easily implement fraud detection feature into their solution using the API from https://www.fraudlabspro.com.

Below are the features of this Ruby module:
- Fraud analysis and scoring
- IP address geolocation & proxy validation
- Email address validation
- Credit card issuing bank validation
- Transaction velocity validation
- Device transaction validation
- Blacklist validation
- Custom rules trigger
- Email notification of fraud orders
- Mobile app notification of fraud orders

This module requires API key to function. You may subscribe a free API key at https://www.fraudlabspro.com

# Developer Documentation
To learn more about installation, usage, and code examples, please visit the developer documentation at [https://fraudlabspro-ruby.readthedocs.io/en/latest/index.html.](https://fraudlabspro-ruby.readthedocs.io/en/latest/index.html)


# Reference

#### Payment Method

| Payment Method                                 |
| ---------------------------------------------- |
| FraudlabsproRuby::Api::Order::CREDIT_CARD      |
| FraudlabsproRuby::Api::Order::PAYPAL           |
| FraudlabsproRuby::Api::Order::CASH_ON_DELIVERY |
| FraudlabsproRuby::Api::Order::BANK_DEPOSIT     |
| FraudlabsproRuby::Api::Order::GIFT_CARD        |
| FraudlabsproRuby::Api::Order::CRYPTO           |
| FraudlabsproRuby::Api::Order::WIRE_TRANSFER    |
| FraudlabsproRuby::Api::Order::OTHERS           |



#### Feedback Status

| Feedback Status                                | Description                                 |
| ---------------------------------------------- | ------------------------------------------- |
| FraudlabsproRuby::Api::Order::APPROVE          | Approves an order that under review status. |
| FraudlabsproRuby::Api::Order::REJECT           | Rejects an order than under review status.  |
| FraudlabsproRuby::Api::Order::REJECT_BLACKLIST | Rejects and blacklists an order.            |




LICENCE
=====================
See the LICENSE file.
