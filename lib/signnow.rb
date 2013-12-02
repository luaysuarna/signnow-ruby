require "net/http"
require "net/https"
require "json"
require "signnow/version"

module Signnow
  DOMAIN_BASE = 'capi-eval'
  API_BASE    = 'signnow.com/api/'
  API_VERSION = 'v1'
  ROOT_PATH   = File.dirname(__FILE__)

  @@api_key = nil

  autoload :Base,             "signnow/base"
  autoload :Client,           "signnow/client"

  module Operations
    autoload :All,    "signnow/operations/all"
    autoload :Create, "signnow/operations/create"
    autoload :Delete, "signnow/operations/delete"
    autoload :Find,   "signnow/operations/find"
    autoload :Update, "signnow/operations/update"
  end

  module Request
    autoload :Base,       "signnow/request/base"
    autoload :Connection, "signnow/request/connection"
    autoload :Helpers,    "signnow/request/helpers"
    autoload :Info,       "signnow/request/info"
    autoload :Validator,  "signnow/request/validator"
  end

  class SignnowError < StandardError; end
  class AuthenticationError < SignnowError; end
  class APIError            < SignnowError; end

  # Makes a request against the Signnow API
  #
  # @param [Symbol] http_method The http method to use, must be one of :get, :post, :put and :delete
  # @param [String] api_url The API url to use
  # @param [Hash] data The data to send, e.g. used when creating new objects.
  # @return [Array] The parsed JSON response.
  def self.request(http_method, api_url, data)
    info = Request::Info.new(http_method, api_url, data)
    Request::Base.new(info).perform
  end
end
