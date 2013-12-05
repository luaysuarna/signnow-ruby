module Signnow
  module Request
    class Connection
      include Helpers
      attr_reader :https

      def initialize(request_info)
        @info = request_info
      end

      def setup_https
        @https             = Net::HTTP.new(api_url, Net::HTTP.https_default_port)
        @https.use_ssl     = true
        @https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      def request
        https.start do |connection|
          https.request(https_request)
        end
      end

      protected

      def authentication
        return {} unless @info.authentication[:type]
        case @info.authentication[:type]
        when :basic
          raise AuthenticationError unless Signnow.api_key
          {'Authorization' => "Basic #{Signnow.api_key}}"}
        when :user_token
          raise AuthenticationError unless @info.authentication[:token]
          {'Authorization' => "Bearer #{@info.authentication[:token]}}"}
        else
          {}
        end
      end

      def https_request
        https_request = case @info.http_method
                        when :post
                          Net::HTTP::Post.new(@info.url, authentication)
                        when :put
                          Net::HTTP::Put.new(@info.url, authentication)
                        when :delete
                          Net::HTTP::Delete.new(@info.url, authentication)
                        else
                          Net::HTTP::Get.new(@info.path_with_params(@info.url, @info.data.merge(authentication)))
                        end

        if [:post, :put].include?(@info.http_method)
          https_request.body = JSON.generate(normalize_params(@info.data))
        end

        https_request
      end

      # Returns the api url foir this request or default
      def api_url
        domain + '.' + API_BASE
      end

      # Returns the domain for the current request or the default one
      def domain
        return @info.subdomain if @info
        DOMAIN_BASE
      end
    end
  end
end
