require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "FraudlabsproRuby" do
  it "work correctly with send sms" do
    FraudlabsproRuby::Configuration.api_key = $test_api_key
    result = FraudlabsproRuby::Api::SMSVerification.sendSMS(
      tel: '+123456789',
      mesg: 'Hi, your OTP is <otp>.',
      otp_timeout: 3600,
      country_code: 'US'
    )
    data = JSON.parse(result.body)
    if $test_api_key == 'YOUR_API_KEY'
      expect(data['error']).to eq 'API key not found.'
    else
      expect(data['error']).to eq 'Invalid phone number.'
    end
  end

  it "work correctly with verify otp" do
    FraudlabsproRuby::Configuration.api_key = $test_api_key
    result = FraudlabsproRuby::Api::SMSVerification.verifySMS(
      tran_id: 'UNIQUE_TRANS_ID',
      otp: 'OTP_RECEIVED'
    )
    data = JSON.parse(result.body)
    if $test_api_key == 'YOUR_API_KEY'
      expect(data['error']).to eq 'API key not found.'
    else
      expect(data['error']).to eq 'Invalid OTP.'
    end
  end

end
