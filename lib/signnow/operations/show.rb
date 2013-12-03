module Signnow
  module Operations
    module Show
      module ClassMethods
        # Shows a given object
        #
        # @param [Integer] id The id of the object that should be shown
        # @return [Signnow::Base] The found object
        def show(id=nil)
          url = "#{self.name.split("::").last.downcase}"
          url += "/#{id}" if id
          response = Signnow.request(:get, nil, url, {})
          self.new(response["data"])
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
