module Signnow
  module Operations
    module Show
      module ClassMethods
        # Shows a given object
        #
        # @param [Integer] id The id of the object that should be shown
        # @return [Signnow::Base] The found object
        def show(attributes={})
          response = Signnow.request(:get, nil, api_show_url(attributes[:id]), {}, options_for_show(attributes))
          self.new(response)
        end

        # URl for the show endpoint
        # overwrite this in the model if the api is not well named
        #
        def api_show_url(id=nil)
          url = "#{self.name.split("::").last.downcase}"
          url += "/#{id}" if id
          url
        end
        protected :api_show_url

        # Options for show
        # overwrite this in the model to set security
        #
        # @return [Hash]
        def options_for_show(attributes)
          raise AuthenticationError unless attributes[:access_token]
          {
            auth_type: :user_token,
            auth_token: attributes[:access_token]
          }
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
