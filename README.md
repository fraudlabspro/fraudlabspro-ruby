FraudLabs Pro Ruby SDK
========================
This Ruby module enables user to easily implement fraud detection feature into their solution using the API from https://www.fraudlabspro.com.

Below are the features of this PHP module:
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




Usage Example
============
### Validate Order

#### Object Properties

| Property Name       | Property Type | Description                                                  |
| ------------------- | ------------- | ------------------------------------------------------------ |
| ip                  | string        | IP address of online transaction. It supports both IPv4 and IPv6 address format. |
| first_name          | string        | User's first name.                                           |
| last_name           | string        | User's last name.                                            |
| username            | string        | User's username.                                             |
| password            | string        | User's password.                                             |
| email               | string        | User's email address.                                        |
| phone               | string        | User's phone number.                                         |
| bill_addr           | string        | Street address of billing address.                           |
| bill_city           | string        | City of billing address.                                     |
| bill_state          | string        | State of billing address. It supports state codes, e.g. NY (New York), for state or province of United States or Canada. Please refer to [State & Province Codes](https://www.fraudlabspro.com/developer/reference/state-and-province-codes) for complete list. |
| bill_zip_code       | string        | Postal or ZIP code of billing address.                       |
| bill_country        | string        | Country of billing address. It requires the input of ISO-3166 alpha-2 country code, e.g. US for United States. Please refer to [Country Codes](https://www.fraudlabspro.com/developer/reference/country-codes) for complete list. |
| user_order_id       | string        | Merchant identifier to uniquely identify a transaction. It supports maximum of 15 characters user order id input. |
| user_order_memo     | string        | Merchant description of an order transaction. It supports maximum of 200 characters. |
| amount              | float         | Amount of the transaction.                                   |
| quantity            | integer       | Total quantity of the transaction.                           |
| currency            | string        | Currency code used in the transaction. It requires the input of ISO-4217 (3 characters) currency code, e.g. USD for US Dollar. Please refer to [Currency Codes](https://www.fraudlabspro.com/developer/reference/currency-codes) for complete list. |
| department          | string        | Merchant identifier to uniquely identify a product or service department. |
| payment_mode        | string        | Payment mode of transaction. Valid values: creditcard, affirm, paypal, googlecheckout, bitcoin, cod, moneyorder, wired, bankdeposit, elviauthorized, paymitco, cybersource, sezzle, viabill, amazonpay, pmnts_gateway, giftcard, others.  |
| card_number         | string        | Billing credit card number or BIN number.                    |
| card_avs            | string        | The single character AVS result returned by the credit card processor. Please refer to [AVS & CVV2 Response Codes](https://www.fraudlabspro.com/developer/reference/avs-and-cvv2-response-codes) for details. |
| card_cvv            | string        | The single character CVV2 result returned by the credit card processor. Please refer to [AVS & CVV2 Response Codes](https://www.fraudlabspro.com/developer/reference/avs-and-cvv2-response-codes) for details. |
| ship_addr           | string        | Street address of shipping address.                          |
| ship_city           | string        | City of shipping address.                                    |
| ship_state          | string        | State of shipping address. It supports state codes, e.g. NY - New York, for state or province of United States or Canada. Please refer to [State & Province Codes](https://www.fraudlabspro.com/developer/reference/state-and-province-codes) for complete list. |
| ship_zip_code       | string        | Postal or ZIP code of shipping address.                      |
| ship_country        | string        | Country of shipping address. It requires the input of ISO-3166 alpha-2 country code, e.g. US for United States. Please refer to [Country Codes](https://www.fraudlabspro.com/developer/reference/country-codes) for complete list. |


```
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
  card_number: '4556553172971283',

  # Shipping information
  ship_addr: '4469 Chestnut Street',
  ship_city: 'Tampa',
  ship_state: 'FL',
  ship_zip_code: '33602',
  ship_country: 'US'
)
```



### Get Transaction

#### Parameter Properties

| Parameter Name | Parameter Type | Description                                                  |
| -------------- | -------------- | ------------------------------------------------------------ |
| transaction_id | string         | FraudLabs Pro transaction ID or Order ID.                    |
| id_type        | string         | ID type. Either: **FraudlabsproRuby::Api::Order::FLP_ID** or **FraudlabsproRuby::Api::Order::ORDER_ID** |

```
require 'fraudlabspro_ruby'

FraudlabsproRuby::Configuration.api_key = 'YOUR_API_KEY'

result = FraudlabsproRuby::Api::Order.getTransaction(
  transaction_id: '20180713-ZNVPV4',
  id_type: FraudlabsproRuby::Api::Order::FLP_ID
)
```



### Feedback

#### Object Properties

| Property Name   | Property Type | Description                                                  |
| --------------- | ------------- | ------------------------------------------------------------ |
| transaction_id  | string        | Unique transaction ID generated from **Validate** function.  |
| status          | string        | Perform APPROVE, REJECT, or REJECT_BLACKLIST action to transaction.	Refer to [reference section](#feedback-status) for status code. |
| note            | string        | Notes for the feedback request.                              |

```
require 'fraudlabspro_ruby'

FraudlabsproRuby::Configuration.api_key = 'YOUR_API_KEY'

result = FraudlabsproRuby::Api::Order.feedback(
  transaction_id: '20180713-ZNVPV4',
  status: FraudlabsproRuby::Api::Order::APPROVE
)
```




## SMS Verification

### Send SMS Verification

#### Object Properties

| Property Name | Property Type | Description                                                  |
| ------------- | ------------- | ------------------------------------------------------------ |
| tel           |    string     | The recipient mobile phone number in E164 format which is a plus followed by just numbers with no spaces or parentheses. |
| mesg          |    string     | The message template for the SMS. Add &lt;otp&gt; as placeholder for the actual OTP to be generated. Max length is 140 characters. |
| otp_timeout   |    integer    | Timeout feature for OTP value in seconds. Default is 3600 seconds(1 hour). Max timeout is 86400 seconds(24 hours). |
| country_code  |    string     | ISO 3166 country code for the recipient mobile phone number. If parameter is supplied, then some basic telephone number validation is done. |

```
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

#### Object Properties

| Property Name | Property Type | Description                                                  |
| ------------- | :-----------: | ------------------------------------------------------------ |
| tran_id       |    string     | The unique ID that was returned by the Send SMS Verification that triggered the OTP sms. |
| otp           |    string     | The OTP that was sent to the recipient’s phone. |

```
require 'fraudlabspro_ruby'

FraudlabsproRuby::Configuration.api_key = 'YOUR_API_KEY'

result = FraudlabsproRuby::Api::SMSVerification.verifySMS(
  tran_id: 'UNIQUE_TRANS_ID',
  otp: 'OTP_RECEIVED'
)
```



# Reference

#### Payment Method

| Payment Method                                 |
| ---------------------------------------------- |
| FraudlabsproRuby::Api::Order::CREDIT_CARD      |
| FraudlabsproRuby::Api::Order::PAYPAL           |
| FraudlabsproRuby::Api::Order::GOOGLE_CHECKOUT  |
| FraudlabsproRuby::Api::Order::CASH_ON_DELIVERY |
| FraudlabsproRuby::Api::Order::MONEY_ORDER      |
| FraudlabsproRuby::Api::Order::WIRE_TRANSFER    |
| FraudlabsproRuby::Api::Order::BANK_DEPOSIT     |
| FraudlabsproRuby::Api::Order::BITCOIN          |
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
