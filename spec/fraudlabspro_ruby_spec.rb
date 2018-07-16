require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "FraudlabsproRuby" do
  it "work correctly with order validate" do
    FraudlabsproRuby::Configuration.api_key = 'YOUR_API_KEY'
    result = FraudlabsproRuby::Api::Order.validate(
      ip: '146.112.62.105'
    )
    expect(result).not_to be nil
    expect(result.code).to eq '200'
  end

  it "work correctly with get transaction" do
    FraudlabsproRuby::Configuration.api_key = 'YOUR_API_KEY'
    result = FraudlabsproRuby::Api::Order.getTransaction(
      transaction_id: '20180713-ZNVPV4',
      id_type: FraudlabsproRuby::Api::Order::FLP_ID
    )
    expect(result).not_to be nil
    expect(result.code).to eq '200'
  end

end
