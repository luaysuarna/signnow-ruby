module Signnow
  module Authentications
    class Base
      class << self
        # Retrieves an oauth token from the Signnow API
        #
        # @param [Hash] options Options to pass to the API
        # @return [Array] The available objects
        def authenticate(options = {})
          response = Signnow.request(:post, nil, self.api_authenticate_url, options)
          self.new(response["data"])
        end

      end

      def api_authenticate_url
        "#{self.name.split("::").last.downcase}"
      end
      protected :api_authenticate_url
    end
  end
end
