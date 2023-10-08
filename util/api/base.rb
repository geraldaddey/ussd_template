# frozen_string_literal: true

module ExternalApi
  class Base
    def initialize(params)
      @payload = params[:payload]
      @endpoint = params[:endpoint]
    end

    def make_connection
      @api_connection = Faraday.new(
        url: (ENV['ACME_API_URL']).to_s,
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    def self.process(params)
      api = new(params)
      api.make_connection
      api.process
    end

    def process_response
      begin
        response = JSON.parse(@response.body)
      rescue JSON::ParserError => e
        return parse_error(e)
      end

      Api::Response.create(response)
    end

    def parse_error(error)
      response = {
        error_name: error.class.name,
        error_message: error.message,
        resp_code: '071'
      }

      Api::Response.create(response)
    end
  end
end
