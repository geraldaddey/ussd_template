# frozen_string_literal: true

module Menu
  class Manager < Menu::Base
    def process
      fetch_data
      params = @params.merge(tracker: @data[:tracker])
      menu = MENU_FUNCTIONS[@data[:tracker][:menu_function]]
      return unless menu

      menu&.process(params)
    end
  end
end
