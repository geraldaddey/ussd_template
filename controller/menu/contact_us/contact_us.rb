# frozen_string_literal: true
#  

module Menu
  class ContactUs < Menu::Base
    def process
      case @page
      when '1'
        Page::ContactUs::Details.process(@params)
      end
    end
  end
end
  