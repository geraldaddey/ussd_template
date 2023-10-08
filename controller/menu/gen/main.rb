# frozen_string_literal: true

module Menu
  class Main < Menu::Base
    def process
      case @page
      when '1'
        Page::Main::MainMenu.process(@params)
      end
    end
  end
end
