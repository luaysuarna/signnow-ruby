module Signnow
  module Operations
    module DownloadLink
      module ClassMethods
        # Request a one time download
        #
        def download_link(attributes={})
          response = Signnow.request(:get, nil, api_download_link_url(attributes[:id]), {}, options_for_download_link(attributes))
          response['link']
        end

        # URl for the show endpoint
        # overwrite this in the model if the api is not well named
        #
        def api_download_link_url(id=nil)
          url = "#{self.name.split("::").last.downcase}"
          url += "/#{id}" if id
          url += "/download/link"
          url
        end
        protected :api_download_link_url

        # Options for show
        # overwrite this in the model to set security
        #
        # @return [Hash]
        def options_for_download_link(attributes)
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
