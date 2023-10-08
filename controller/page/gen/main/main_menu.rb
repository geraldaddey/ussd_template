# frozen_string_literal: true

module Page
  module Main
    class MainMenu < Menu::Base
      def process
        fetch_data
        case @activity_type
        when REQUEST
          process_request
        when RESPONSE
          process_response
        end
      end

      private

      def process_response
        case @ussd_body
        when '1'
          Page::MakePayment::Amount.process(@params.merge(activity_type: REQUEST))
        when '2'
          Page::ContactUs::Details.process(@params.merge(activity_type: REQUEST))
        else
          @message_prepend = "Invalid Option. \n"
          process_request
        end
      end

      def process_request
        log_display(display_message)
        render_page({
                      page: '1',
                      menu_function: MAIN_MENU,
                      activity_type: RESPONSE
                    })
      end

      def display_message
        entity_name = @data[:entity_info][:entity_name]
        message = <<~MSG
          Welcome to #{entity_name}

          1. Make Payment
          2. Contact Us

        MSG

        @message_prepend + message
      end
    end
  end
end
