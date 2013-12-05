module Signnow
  class Client
    attr_reader :access_token

    # Creates an account object using the given Signnow user.
    # existing account.
    #
    # @param [String] User access token to use the signnow api.
    def initialize(access_token=nil)
      @access_token = access_token
      self
    end

    # Executes block with the access token
    #
    # @param [block] block to execute
    #
    # @example [description]
    # client = Signnow::Client.new('_user_auth_')
    # client.perform! do |access_token|
    #   Signnow::User.show(access_token: access_token)
    # end
    def perform!(&block)
      raise Signnow::AuthenticationError unless access_token
      block.call(access_token)
    end

  end
end
