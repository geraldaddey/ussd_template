# frozen_string_literal: true
#  

module Menu
  class LoanRepayment < Menu::Base
    def process
      page =  LOAN_REPAYMENT_PAGES[@page]
      return unless page


       page.process(@params)
    end
  end
end
