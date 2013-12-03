module Signnow
  module Request
    class Info
      attr_accessor :http_method, :api_url, :data, :domain, :authentication

      def initialize(http_method, domain, api_url, data, options={})
        @http_method = http_method
        @domain      = domain
        @api_url     = api_url
        @data        = data
        @authentication = {}
        @authentication[:type] = options[:auth_type]
        @authentication[:token] = options[:auth_token]
      end

      def url
        url = "/#{domain}.#{api_url}"
        if has_id?
          url += "/#{data[:id]}"
          data.delete(:id)
        end

        url
      end

      def path_with_params(path, params)
        unless params.empty?
          encoded_params = URI.encode_www_form(params)
          [path, encoded_params].join("?")
        else
          path
        end
      end

      protected

      def has_id?
        data[:id].present?
      end
    end
  end
end
