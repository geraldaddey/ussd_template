# frozen_string_literal: true

module Menu
  class Paginate < Menu::Base
    def process
      case @page
      when '1'
        Page::Paginate::First.process(@params)
      when '2'
        Page::Paginate::Second.process(@params)
      end
    end
  end
end
