# frozen_string_literal: true

module Dial
  class Manager
    def initialize(json)
      params = JSON.parse(json)&.with_indifferent_access
      @message_type = params[:msg_type]
      @mobile_number = params[:msisdn]
      @ussd_body = params[:ussd_body]
      @params = params
    end

    def process
      case @message_type
      when '0'
        first_dial
      when '1'
        continuous_dial
      end
    end

    private

    def first_dial
        Service::NetworkService.process(@params)
        Service::EntityService.process(@params)
        raise ProcessingError
    end

    def continuous_dial
      Menu::Manager.process(@params)
    end
  end
end
