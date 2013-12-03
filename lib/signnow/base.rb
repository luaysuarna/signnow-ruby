module Signnow
  class Base
    include Signnow::Operations::All
    include Signnow::Operations::Create
    include Signnow::Operations::Find

    attr_accessor :created

    # Initializes the object using the given attributes
    #
    # @param [Hash] attributes The attributes to use for initialization
    def initialize(attributes = {})
      set_attributes(attributes)
      parse_timestamps
    end

    # Sets the attributes
    #
    # @param [Hash] attributes The attributes to initialize
    def set_attributes(attributes)
      attributes.each_pair do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    # Parses UNIX timestamps and creates Time objects.
    def parse_timestamps
      @created = Time.at(created_at) if created
    end
  end
end
