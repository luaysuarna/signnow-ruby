module Signnow
  module Authentications
    class Oauth < Base
      include Signnow::Operations::Create

      attr_accessor :created, :access_token, :token_type, :expires_in,
        :refresh_token, :scope

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
        @created = Time.at(created_at) if created
      end

      def api_authenticate_url
        "/oauth2/token"
      end
      protected :api_authenticate_url
    end
  end
end
