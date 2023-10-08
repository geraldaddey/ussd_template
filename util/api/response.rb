# frozen_string_literal: true

module ExternalApi
  class Response
    attr_accessor :data, :success, :message

    def initialize(response)
      @response = response.with_indifferent_access
      @response_code = @response[:resp_code]
    end

    def self.create(params)
      new(params).process
    end

    def process
      case @response_code
      when '000', '075'
        @success = true
      else
        @success = false
        @message = @response[:resp_desc] || @response[:error_message]
        @error_name = @response[:error_name]
      end
      @data = @response

      self
    end
  end
end
