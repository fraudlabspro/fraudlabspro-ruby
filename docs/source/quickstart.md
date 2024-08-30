# Quickstart

## Dependencies

This module requires API key to function. You may subscribe a free API key at https://www.fraudlabspro.com

## Installation

Install this package using the command as below:

```
gem install fraudlabspro_ruby
```

## Sample Codes

### Validate Order

You can validate your order as below:

```ruby
require 'fraudlabspro_ruby'

FraudlabsproRuby::Configuration.api_key = 'YOUR_API_KEY'

result = FraudlabsproRuby::Api::Order.validate(
  ip: '146.112.62.105',
  first_name: 'Hector',
  last_name: 'Henderson',
  email: 'hh5566@gmail.com',
  phone: '561-628-8674',

  # Billing information
  bill_addr: '1766 PowderHouse Road',
  bill_city: 'West Palm Beach',
  bill_state: 'FL',
  bill_zip_code: '33401',
  bill_country: 'US',

  # Order information
  user_order_id: '67398',
  user_order_memo: 'Online Shop',
  amount: '79.89',
  quantity: '1',
  currency: 'USD',
  payment_mode: FraudlabsproRuby::Api::Order::CREDIT_CARD,
  payment_gateway: FraudlabsproRuby::Api::Order::CREDIT_CARD,
  card_number: '4556553172971283',

  # Shipping information
  ship_first_name: 'Hector',
  ship_last_name: 'Henderson',
  ship_addr: '4469 Chestnut Street',
  ship_city: 'Tampa',
  ship_state: 'FL',
  ship_zip_code: '33602',
  ship_country: 'US'
)
```

### Get Transaction

You can get the details of a transaction as below:

```ruby
require 'fraudlabspro_ruby'

FraudlabsproRuby::Configuration.api_key = 'YOUR_API_KEY'

result = FraudlabsproRuby::Api::Order.getTransaction(
  transaction_id: '20180713-ZNVPV4',
  id_type: FraudlabsproRuby::Api::Order::FLP_ID
)
```

### Feedback

You can approve, reject or ignore a transaction as below:

```ruby
require 'fraudlabspro_ruby'

FraudlabsproRuby::Configuration.api_key = 'YOUR_API_KEY'

result = FraudlabsproRuby::Api::Order.feedback(
  transaction_id: '20180713-ZNVPV4',
  status: FraudlabsproRuby::Api::Order::APPROVE
)

```

### Send SMS Verification

You can send SMS verification for authentication purpose as below:

```ruby
require 'fraudlabspro_ruby'

FraudlabsproRuby::Configuration.api_key = 'YOUR_API_KEY'

result = FraudlabsproRuby::Api::SMSVerification.sendSMS(
  tel: '+123456789',
  mesg: 'Hi, your OTP is <otp>.',
  otp_timeout: 3600,
  country_code: 'US'
)
```

### Get SMS Verification Result

You can verify the OTP sent by Fraudlabs Pro SMS verification API as below:

```ruby
require 'fraudlabspro_ruby'

FraudlabsproRuby::Configuration.api_key = 'YOUR_API_KEY'

result = FraudlabsproRuby::Api::SMSVerification.verifySMS(
  tran_id: 'UNIQUE_TRANS_ID',
  otp: 'OTP_RECEIVED'
)
```