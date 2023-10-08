# frozen_string_literal: true

module Service
  class NetworkService < Menu::Base
    # network service
    def process
      check_network
    end

    def check_network
      networks = {
        '01' => 'MTN',
        '02' => 'VOD',
        '03' => 'TIG',
        '04' => 'AIR'
      }

      network = networks[@network]
      store_data({ network: network }) if network
      #rescue here
    end
  end
end
