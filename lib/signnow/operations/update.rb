module Signnow
  module Operations
    module Update

      module ClassMethods
        # Updates a object
        # @param [Integer] id The id of the object that should be updated
        # @param [Hash] attributes The attributes that should be updated
        def update_attributes(id, attributes)
          response = Signnow.request(:put, nil, "#{self.name.split("::").last.downcase}/#{id}", attributes)
          self.new(response["data"])
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      # Updates a object
      #
      # @param [Hash] attributes The attributes that should be updated
      def update_attributes(attributes)
        response = Signnow.request(:put, nil, "#{self.class.name.split("::").last.downcase}/#{id}", attributes)
        set_attributes(response["data"])
      end
    end
  end
end
