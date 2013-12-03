module Signnow
  module Operations
    module All
      module ClassMethods
        # Retrieves all available objects from the Signnow API
        #
        # @param [Hash] options Options to pass to the API
        # @return [Array] The available objects
        def all(options = {})
          response = Signnow.request(:get, nil, "#{self.name.split("::").last.downcase}/", options)
          results_from response
        end

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
