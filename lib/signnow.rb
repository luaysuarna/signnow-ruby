require "net/http"
require "net/https"
require "json"
require "signnow/version"
require 'base64'

module Signnow
  DOMAIN_BASE = 'api'
  TEST_DOMAIN_BASE = 'capi-eval'
  API_BASE    = 'signnow.com'
  API_BASE_PATH = nil
  TEST_API_BASE_PATH = 'api'
  API_VERSION = 'v1'
  ROOT_PATH   = File.dirname(__FILE__)

  @@configuration = {}

  autoload :Base,           "signnow/base"
  autoload :User,           "signnow/user"
  autoload :Document,       "signnow/document"
  autoload :Client,         "signnow/client"

  module Authentications
    autoload :Base,   "signnow/authentications/base"
    autoload :Oauth,  "signnow/authentications/oauth"
  end

  module Operations
    autoload :All,    "signnow/operations/all"
    autoload :Create, "signnow/operations/create"
    autoload :Delete, "signnow/operations/delete"
    autoload :Find,   "signnow/operations/find"
    autoload :Show,   "signnow/operations/show"
    autoload :DownloadLink,   "signnow/operations/download_link"
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

  # Returns the set api key
  #
  # @return [String] The api key
  def self.encoded_app_credentials
    return unless configuration[:app_id] && configuration[:app_secret]
    configuration[:encoded_app_credentials] ||=
      Base64.strict_encode64("#{configuration[:app_id]}:#{configuration[:app_secret]}")
  end

  # Use thisfunciotn with a block to add app credentials configuration
  # Example:
  #
  # Signnow.configure do |config|
  #   config[:app_id] = 'your_app_id'
  #   config[:app_secret] = 'your_app_secret'
  # end
  def self.configure
    return unless block_given?
    yield(configuration)
  end

  # Returns configuration hash
  # @return [Hash]
  def self.configuration
    @@configuration
  end

  # Makes a request against the Signnow API
  #
  # @param [Symbol] http_method The http method to use, must be one of :get, :post, :put and :delete
  # @param [String] domain The API domain to use
  # @param [String] api_url The API url to use
  # @param [Hash] data The data to send, e.g. used when creating new objects.
  # @return [Array] The parsed JSON response.
  def self.request(http_method, domain, api_url, data, options={})
    info = Request::Info.new(http_method, domain, api_url, data, options)
    Request::Base.new(info).perform
  end

  # Returns the domain base of the api depending on the env
  #
  def self.domain
    if configuration[:use_test_env?]
      TEST_DOMAIN_BASE
    else
      DOMAIN_BASE
    end
  end

  # Returns the api base path depending on the env
  #
  def self.base_path
    if configuration[:use_test_env?]
      TEST_API_BASE_PATH
    else
      API_BASE_PATH
    end
  end

  # Returns the api uri
  #
  def self.uri
    uri = "https://#{domain}"
    base_path && uri += "/#{base_path}"
    uri
  end
end
