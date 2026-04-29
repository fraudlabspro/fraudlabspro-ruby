require 'uri'
require 'net/http'
require "fraudlabspro_ruby/configuration"
require "fraudlabspro_ruby/version"

module FraudlabsproRuby
  module Api
    class Payment

      # Report the final payment status back to the system, helping improve fraud detection and risk assessment.
      def self.feedback(params = {})
        uri = URI.parse("https://api.fraudlabspro.com/v2/payment/feedback")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Post.new(uri.request_uri)
        request.set_form_data({
          'key' => FraudlabsproRuby::Configuration.api_key,
          'format' => 'json',
          'source' => 'sdk-ruby',
          'source_version' => FraudlabsproRuby::VERSION,
          'email' => params[:email],
          'status' => params[:status],
          'message' => params[:message],
          'fraudlabspro_id' => params[:fraudlabspro_id] || ''
        })

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