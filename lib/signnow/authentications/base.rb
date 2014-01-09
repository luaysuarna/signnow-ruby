module Signnow
  module Authentications
    class Base
      class << self
        # Retrieves an oauth token from the Signnow API
        #
        # @param [Hash] attributes Attributes to pass to the API
        # @return [Array] The available objects
        def authenticate(attributes = {})
          response = Signnow.request(
            :post,
            nil,
            self.api_authenticate_url,
            attributes_for_authentication(attributes),
            options_for_authentication.merge(
              use_form_data: true
            )
          )
          self.new(response)
        end

        protected

        # URl for the authenticate endpoint
        # overwrite this in the model if the api is not well named
        #
        def api_authenticate_url
          "#{self.name.split("::").last.downcase}"
        end

        # Options for the authentication mehtod
        #
        # @return [Hash]
        def options_for_authentication
          { auth_type: :basic }
        end

        # Attributes for the authentication mehtod
        # overwrite this in the class to add attributes
        #
        # @param [Hash] attributes to merge with
        # @return [Hash]
        def attributes_for_authentication(attributes={})
          {}.merge(attributes)
        end

        def domain
          if Signnow.configuration[:use_test_env?]
            'eval'
          else
            'www'
          end
        end
      end
    end
  end
end
