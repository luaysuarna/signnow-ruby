module Signnow
  module Operations
    module All
      module ClassMethods
        # Retrieves all available objects from the Signnow API
        #
        # @param [Hash] options Options to pass to the API
        # @return [Array] The available objects
        def all(options = {})
          response = Signnow.request(:get, nil, api_all_url , options)
          results_from response
        end

        # URl for the all endpoint
        # overwrite this in the model if the api is not well named
        #
        def api_all_url
          "#{self.name.split("::").last.downcase}"
        end
        protected :api_all_url

        private
        def results_from(response)
          results = []
          response["data"].each do |obj|
            results << self.new(obj)
          end
          results
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

    end
  end
end
