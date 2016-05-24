module Clashinator
  module Exceptions
    class ResponseError < Base
      attr_reader :response

      def initialize(response)
        @response = response
      end

      def to_s
        super +
          format(' (%s)', data.map { |k, v| %(#{k}: "#{v}") }.join(', '))
      end

      def error_code
        data[:error_code] || data['error_code']
      end

      private

      def data
        @data ||= begin
          JSON.parse(response.body)
        rescue JSON::ParserError
          { error_code: response.status, reason: response.body.reason }
        end
      end
    end
  end
  end