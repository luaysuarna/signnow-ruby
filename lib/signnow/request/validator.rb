module Signnow
  module Request
    class Validator
      attr_reader :info
      attr_accessor :response

      def initialize(info)
        @info = info
      end

      def validated_data_for(incoming_response)
        self.response = incoming_response
        verify_response_code
        info.data = JSON.parse(response.body)
        validate_response_data
        info.data
      end

      protected

      def verify_response_code
        raise AuthenticationError if response.code.to_i == 401
        raise NotFound if response.code.to_i == 404
        raise APIError if response.code.to_i >= 500
      end

      def validate_response_data(body=nil)
        body ||= info.data
        if body.is_a?(Hash)
          if body['404']
            fail NotFound.new(body['404'])
          elsif body['error']
            handle_api_error(body['code'], body['error'])
          elsif body['errors']
            body['errors'].each do |error|
              handle_api_error(error['code'], error['message'])
            end
          end
        end
      end

      def handle_api_error(code, message)
        error = case code
                when 1539  then InvalidToken.new(message)
                when 65536 then EmptyDocuments.new(message)
                else            APIError.new(message)
                end
        fail error
      end
    end
  end
end
