require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "FraudlabsproRuby" do
  it "work correctly with invalid Api Key" do
    FraudlabsproRuby::Configuration.api_key = ''
    result = FraudlabsproRuby::Api::Order.validate(
      ip: '8.8.8.8'
    )
    data = JSON.parse(result.body)
    expect(data['fraudlabspro_message']).to eq 'INVALID API KEY'
  end

  it "work correctly with Api Key exist" do
    if $test_api_key == 'YOUR_API_KEY'
      print "/*
* You could enter a FraudLabs Pro API Key in spec/spec_helper.rb
* for real web service calling test.
* 
* You could sign up for a free API key at https://www.fraudlabspro.com/pricing
* if you do not have one.
*/"
      expect($test_api_key).to eq 'YOUR_API_KEY'
    else
      expect($test_api_key).to_not eq 'YOUR_API_KEY'
    end
  end

  it "work correctly with validate order" do
    FraudlabsproRuby::Configuration.api_key = $test_api_key
    result = FraudlabsproRuby::Api::Order.validate(
      ip: '8.8.8.8'
    )
    data = JSON.parse(result.body)
    if $test_api_key == 'YOUR_API_KEY'
      expect(data['fraudlabspro_id']).to eq 'NA'
    else
      expect(data['ip_country']).to eq 'US'
    end
  end

  it "work correctly with get transaction" do
    FraudlabsproRuby::Configuration.api_key = $test_api_key
    result = FraudlabsproRuby::Api::Order.getTransaction(
      transaction_id: '20180713-ZNVPV4',
      id_type: FraudlabsproRuby::Api::Order::FLP_ID
    )
    data = JSON.parse(result.body)
    expect(data['fraudlabspro_id']).to eq 'NA'
  end

  it "work correctly with validate order" do
    FraudlabsproRuby::Configuration.api_key = $test_api_key
    result = FraudlabsproRuby::Api::Order.feedback(
      transaction_id: '20180713-ZNVPV4',
      status: FraudlabsproRuby::Api::Order::APPROVE
    )
    data = JSON.parse(result.body)
    if $test_api_key == 'YOUR_API_KEY'
      expect(data['fraudlabspro_message']).to eq 'INVALID API KEY'
    else
      expect(data['fraudlabspro_message']).to eq 'INVALID TRANSACTION ID'
    end
  end

end
