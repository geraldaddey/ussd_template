# frozen_string_literal: true

# require_relative '../../util/api/base'

module Dial
  class Base
    attr_accessor :menu

    def initialize(payload, menu: Menu)
      @menu = menu
      params = parse_payload(payload)
      @params = params
      @ussd_body = params[:ussd_body]
      @message_type = params[:msg_type]
      @phone = params[:msisdn]
      @service_code = params[:service_code]
      @nw_code = params[:nw_code]
    end

    def parse_payload(payload)
      JSON.parse(payload)&.with_indifferent_access
    end
  end
end
