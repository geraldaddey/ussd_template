# frozen_string_literal: true

module ExternalApi
  class Post < ExternalApi::Base
    def process
      make_request
    rescue StandardError => e
      parse_error(e)
    end

    private

    def make_request
      @response = @api_connection.post do |request|
        request.url @endpoint
        request.options.timeout = 180
        request.body = @payload.to_json
      end

      process_response
    end
  end
end
