# frozen_string_literal: true
#  

module Menu
  class MakePayment < Menu::Base
    def process
    page =  MAKE_PAYMENT_PAGES[@page] 
    return unless page
    
    page.process(@params)
  end
  end
end
