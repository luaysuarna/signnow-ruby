module Signnow
  class User < Base
    include Signnow::Operations::Show

    attr_accessor :id, :email, :first_name, :last_name, :attributes, :active,
      :type, :pro, :created, :emails, :identity, :subscriptions, :credits,
      :has_atticus_access, :is_logged_in, :teams

    # Initializes the object using the given attributes
    #
    # @param [Hash] attributes The attributes to use for initialization
    def initialize(attributes = {})
      super(attributes)
      parse_booleans
    end

    def email
      return @email if @email
      return unless emails
      emails.first
    end

    # Parses Boolean fileds.
    def parse_booleans
      @active = ( active == '1' ) if active and active.is_a? String
      @pro = ( pro == 1 ) if pro and pro.is_a? Integer
    end
    protected :parse_booleans

  end
end
