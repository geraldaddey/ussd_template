# frozen_string_literal: true

# require_relative '../menu/base'

module Service
  class EntityService < Menu::Base
    def process
      retrieve_entity_info
      fetch_data
      Service::ModuleService.process(@params)
    end

    def retrieve_entity_info
      response = Api.get_request(RETRIEVE_ENTITY_INFO, {
                                   mobile_number: @mobile_number,
                                   service_code: service_code
                                 })
      puts "RESPONSE ==> #{response.inspect}"
      if valid_response?(response)
        entity_info = extract_entity_info(response)
        store_data(entity_info: entity_info)
      end
    rescue StandardError => e
      puts "Error Retrieving Entity Info ==> #{e.inspect}"
    end

    def service_code
      fetch_data
      @data[:service_code].nil? ? @ussd_body : @data[:service_code]
    rescue StandardError => e
      puts "Error Retrieving Service Code ==> #{e.inspect}"
    end

    private

    def valid_response?(response)
      response && response['resp_code'] == '00'
    end

    def extract_entity_info(response)
      {
        entity_code: response[:data][:entity_div_code],
        service_label: response[:data][:service_label],
        entity_name: response[:data][:entity_div_name],
        service_code: response[:data][:service_code],
        acme_module: response[:data][:activity_type]
      }.compact
    end
  end
end
