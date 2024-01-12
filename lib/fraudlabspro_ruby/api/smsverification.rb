require 'uri'
require 'net/http'
require "fraudlabspro_ruby/configuration"
require "fraudlabspro_ruby/version"

module FraudlabsproRuby
  module Api
    class SMSVerification

      # Send SMS Verification for authentication.
      def self.sendSMS(params = {})
        if params[:tel].index('+') != 0
          params[:tel] = '+' + params[:tel]
        end

        uri = URI.parse("https://api.fraudlabspro.com/v2/verification/send")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Post.new(uri.request_uri)
        request.set_form_data({
          'key' => FraudlabsproRuby::Configuration.api_key,
          'format' => 'json',
          'source' => 'sdk-ruby',
          'source_version' => FraudlabsproRuby::VERSION,
          'tel' => params[:tel],
          'mesg' => params[:mesg] || '',
          'otp_timeout' => params[:otp_timeout] || 3600,
          'country_code' => params[:country_code] || ''
        })

        response = http.request(request)

        if response == nil
          return false
        else
          return response
        end
      end

      # Get Verification result.
      def self.verifySMS(params = {})
        uri = URI.parse("https://api.fraudlabspro.com/v2/verification/result?key=" + FraudlabsproRuby::Configuration.api_key + "&format=json&tran_id=" + params[:tran_id] + "&otp=" + params[:otp])
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(uri.request_uri)

        response = http.request(request)

        if response == nil
          return false
        else
          return response
        end
      end

    end
  end
end