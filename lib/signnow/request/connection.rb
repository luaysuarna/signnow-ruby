module Signnow
  module Request
    class Connection
      include Helpers
      attr_reader :https

      def initialize(request_info)
        @info = request_info
      end

      def setup_https
        @https             = Net::HTTP.new( @info.subdomain + '.' + API_BASE, Net::HTTP.https_default_port)
        @https.use_ssl     = true
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
          {'Authorization' => "Basic #{Signnow.api_token}}"}
        when :user_token
          {'Authorization' => "Bearer #{Signnow.oauth.access_token}}"}
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
          request.body = JSON.generate(normalize_params(@info.data))
        end

        https_request
      end
    end
  end
end
