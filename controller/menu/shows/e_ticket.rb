# frozen_string_literal: true
#  

module Menu
  class ETicket < Menu::Base
    def process
        page = E_TICKET_PAGES[@page]
        return unless page 
      
      page&.process(@params)
    end

  end
end
