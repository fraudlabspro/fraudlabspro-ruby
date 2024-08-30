require 'uri'
require 'net/http'
require 'digest/sha1'
require "fraudlabspro_ruby/configuration"
require "fraudlabspro_ruby/version"

module FraudlabsproRuby
  module Api
    class Order

      # Order statuses.
      APPROVE = 'APPROVE';
      REJECT = 'REJECT';
      REJECT_BLACKLIST = 'REJECT_BLACKLIST';

      # Payment methods.
      CREDIT_CARD = 'CREDITCARD'
      PAYPAL = 'PAYPAL';
      CASH_ON_DELIVERY = 'COD';
      BANK_DEPOSIT = 'BANKDEPOSIT';
      GIFT_CARD = 'GIFTCARD';
      CRYPTO = 'CRYPTO';
      WIRE_TRANSFER = 'WIRED';
      OTHERS = 'OTHERS';

      # ID types.
      FLP_ID = 'fraudlabspro_id';
      ORDER_ID = 'user_order_id';


      # Validate order for possible fraud.
      def self.validate(params = {})
        if params[:email] != nil
          email_domain = params[:email][(params[:email].index('@') + 1)..-1]
        end

        if params[:phone] != nil
          params[:phone] = params[:phone].scan(/\d/).join('')
        end

        if params[:amount] != nil
          params[:amount] = '%.2f' % params[:amount]
        end

        if params[:card_number] != nil
          params[:card_number] = params[:card_number][0..5]
        end

        uri = URI.parse("https://api.fraudlabspro.com/v2/order/screen")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Post.new(uri.request_uri)
        request.set_form_data({
          'key' => FraudlabsproRuby::Configuration.api_key,
          'format' => 'json',
          'source' => 'sdk-ruby',
          'source_version' => FraudlabsproRuby::VERSION,
          'flp_checksum' => params[:flp_checksum] || '',

          # Billing information.
          'ip' => params[:ip],
          'first_name' => params[:first_name] || '',
          'last_name' => params[:last_name] || '',
          'username_hash' => do_hash(params[:username]) || '',
          'email' => params[:email] || '',
          'email_domain' => email_domain || '',
          'user_phone' => params[:phone] || '',
          'bill_addr' => params[:bill_addr] || '',
          'bill_city' => params[:bill_city] || '',
          'bill_state' => params[:bill_state] || '',
          'bill_zip_code' => params[:bill_zip_code] || '',
          'bill_country' => params[:bill_country] || '',

          # Order information.
          'user_order_id' => params[:user_order_id] || '',
          'user_order_memo' => params[:user_order_memo] || '',
          'amount' => params[:amount] || 0,
          'quantity' => params[:quantity] || 1,
          'currency' => params[:currency] || 'USD',
          'department' => params[:department] || '',
          'payment_gateway' => params[:payment_gateway] || '',
          'payment_mode' => params[:payment_mode] || '',

          # Credit card information.
          'bin_no' => params[:card_number] || '',
          'card_hash' => do_hash(params[:card_number]) || '',
          'avs_result' => params[:card_avs] || '',
          'cvv_result' => params[:card_cvv] || '',

          # Shipping information.
          'ship_first_name' => params[:ship_first_name] || '',
          'ship_last_name' => params[:ship_last_name] || '',
          'ship_addr' => params[:ship_addr] || '',
          'ship_city' => params[:ship_city] || '',
          'ship_state' => params[:ship_state] || '',
          'ship_zip_code' => params[:ship_zip_code] || '',
          'ship_country' => params[:ship_country] || ''
        })

        response = http.request(request)

        if response == nil
          return false
        else
          return response
        end
      end

      # Sends feedback back to FraudLabs Pro.
      def self.feedback(params = {})
        uri = URI.parse("https://api.fraudlabspro.com/v2/order/feedback")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Post.new(uri.request_uri)
        request.set_form_data({
          'key' => FraudlabsproRuby::Configuration.api_key,
          'format' => 'json',
          'id' => params[:transaction_id],
          'action' => params[:status] || '',
          'note' => params[:note] || ''
        })

        response = http.request(request)

        if response == nil
          return false
        else
          return response
        end
      end

      # Gets transaction result.
      def self.getTransaction(params = {})
        if params[:id_type] == nil
          params[:id_type] = ''
        end

        uri = URI.parse("https://api.fraudlabspro.com/v2/order/result?key=" + FraudlabsproRuby::Configuration.api_key + "&format=json&id=" + params[:transaction_id] + "&id_type=" + params[:id_type])
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

      # Hashes a string to protect its real value.
      def self.do_hash(value)
        hash = 'fraudlabspro_' + value.to_s
        for i in 0..65536
          hash = Digest::SHA1.hexdigest('fraudlabspro_' + hash)
        end
        return hash
      end

    end
  end
end
