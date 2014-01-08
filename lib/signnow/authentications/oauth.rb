module Signnow
  module Authentications
    class Oauth < Base
      include Signnow::Operations::Create

      attr_accessor :created, :access_token, :token_type, :expires_in,
        :refresh_token, :scope, :last_login

      class << self
        # Returns the redirect url to authorize
        #
        # @param [Hash] options
        # @option options [String] redirect_url () redirect url to receive the code param
        def authorize_url(options = {})
          protocol = "https"
          base_url = "#{protocol}://#{domain}.#{API_BASE}"
          path = "/proxy/index.php/authorize"
          params = {
            client_id: Signnow.configuration[:app_id],
            redirect_uri: options[:redirect_uri],
            response_type: 'code'
          }

          "#{base_url}#{path}?#{URI.encode_www_form(params)}"
        end

        protected

        def api_authenticate_url
          "oauth2/token"
        end

        # Attributes for the authentication mehtod
        # overwrite this in the class to add attributes
        #
        # @param [Hash] attributes to merge with
        # @return [Hash]
        def attributes_for_authentication(attributes={})
          { grant_type: 'authorization_code' }.merge(attributes)
        end
      end

      # Initializes the object using the given attributes
      #
      # @param [Hash] attributes The attributes to use for initialization
      def initialize(attributes = {})
        set_attributes(attributes)
        parse_timestamps
      end

      # Sets the attributes
      #
      # @param [Hash] attributes The attributes to initialize
      def set_attributes(attributes)
        attributes.each_pair do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # Parses UNIX timestamps and creates Time objects.
      def parse_timestamps
        @created = Time.at(created.to_i) if created
        @expires_in = Time.at(expires_in.to_i) if expires_in
        @last_login = Time.at(last_login.to_i) if last_login
      end
    end
  end
end
