module Signnow
  module Authentications
    class Base
      class << self
        # Retrieves an oauth token from the Signnow API
        #
        # @param [Hash] attributes Attributes to pass to the API
        # @return [Array] The available objects
        def authenticate(attributes = {})
          response = Signnow.request(:post, nil, self.api_authenticate_url, attributes, ooptions_for_authentication)
          self.new(response["data"])
        end

        # URl for the authenticate endpoint
        # overwrite this in the model if the api is not well named
        #
        def api_authenticate_url
          "#{self.name.split("::").last.downcase}"
        end
        protected :api_authenticate_url

        # Options for the authentication mehtod
        #
        # @return [Hash]
        def ooptions_for_authentication
          { auth_type: :basic }
        end
      end
    end
  end
end
