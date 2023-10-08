# frozen_string_literal: true

module Menu
  class More < Menu::Base
    def process
      case @page
      when '1'
        Page::More::First.process(@params)
      else
        render_main_menu({ message_prepend: "option not implemented yet!!!!\n" })
      end
    end
  end
end
