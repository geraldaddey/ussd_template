# frozen_string_literal: true
# 

module Service
  class ModuleService < Menu::Base
    def process
      verify_module
    end

    def verify_module
      puts "CURRENT MODULE ==> #{@data[:entity_info][:acme_module]}"
      case @data[:entity_info][:acme_module]
      when MICROCREDIT
        Menu::RequestLoan.process(@params.merge(page: '1', activity_type: REQUEST, menu_function: REQUEST_LOAN))
      when SHOWS
        Menu::ETicket.process(@params.merge(page: '1', activity_type: REQUEST, menu_function: E_TICKET))
      else
        Menu::Main.process(@params.merge(page: '1', activity_type: REQUEST))
      end
    rescue StandardError => e
      puts "Error Verifying Module ==> #{e.inspect}"
    end
  end
end
