# frozen_string_literal: true

  module LoggerHelper
    def log_display(content)
      separator = '#' * 75
      puts '╭─────────────────────╮'.center(75)
      puts '│                     │'.center(75)
      puts '│     GERALD ADDEY     │'.center(75)
      puts '│        ACME         │'.center(75)
      puts '│                     │'.center(75)
      puts '╰─────────────────────╯'.center(75)
      puts separator
      puts content.center(75)
      puts separator
    end
  end
