# frozen_string_literal: true
# 



  # module MCE 
module Menu

  class RequestLoan < Menu::Base

    def process
      page = REQUEST_LOAN_PAGES[@page]
      return unless page

      page.process(@params)
    
    end
  end
end
