module Signnow
  module Operations
    module Find
      module ClassMethods
        # Finds a given object
        #
        # @param [Integer] id The id of the object that should be found
        # @return [Signnow::Base] The found object
        def find(id)
          response = Signnow.request(:get, nil, "#{self.name.split("::").last.downcase}s/#{id}", {})
          self.new(response["data"])
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
