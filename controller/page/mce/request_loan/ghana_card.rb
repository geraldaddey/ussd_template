# frozen_string_literal: true

module Page
  module RequestLoan
    class GhanaCard < Menu::Base
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
        if valid_ghana_card?(@ussd_body)
          store_data({ ghana_card: @ussd_body })
          Page::RequestLoan::AccountReference.process(@params.merge(activity_type: REQUEST))
        elsif @ussd_body == BACK
          Page::Main::MainMenu.process(@params.merge(activity_type: REQUEST))
        else
          @message_prepend = "Invalid Card Number\n"
          process_request
        end
      end

      def process_request
        log_display(display_message)
        render_page({
                      page: '4',
                      menu_function: REQUEST_LOAN,
                      activity_type: RESPONSE
                    })
      end

      def display_message
        entity_name = @data[:entity_info][:entity_name]
        message = <<~MSG
          #{entity_name}

          Enter Ghana Card Number (Exclude GHA)

          #{BACK}. Back

        MSG

        @message_prepend + message
      end
    end
  end
end
