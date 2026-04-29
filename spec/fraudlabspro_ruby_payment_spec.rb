require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "FraudlabsproRuby" do
  it "work correctly with payment feedback" do
    FraudlabsproRuby::Configuration.api_key = $test_api_key
    result = FraudlabsproRuby::Api::Payment.feedback(
      email: '',
      status: 'declined',
      message: 'Call Issuer. Pick Up Card. (2047)'
    )
    data = JSON.parse(result.body)
    if $test_api_key == 'YOUR_API_KEY'
      expect(data['error']['error_message']).to eq 'INVALID API KEY'
    else
      expect(data['error']['error_message']).to eq 'INVALID EMAIL ADDRESS'
    end
  end

end
