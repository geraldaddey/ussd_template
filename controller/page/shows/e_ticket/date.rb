# frozen_string_literal: true

module Page
  module ETicket
    class Date < Menu::Base
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
        when BACK
          Page::RequestLoan::MainMenu.process(@params.merge(activity_type: REQUEST))
        else
          store_data({ account_reference: @ussd_body })
          Page::LoanRepayment::Amount.process(@params.merge(activity_type: REQUEST))

        end
      end

      def process_request
        log_display(display_message)
        render_page({
                      page: '2',
                      menu_function: E_TICKET,
                      activity_type: RESPONSE
                    })
      end

      def display_message
        entity_name = @data[:entity_info][:entity_name]
        message = <<~MSG
          #{entity_name}

          1. Dates from endpoint

          #{BACK}. Back

        MSG

        @message_prepend + message
      end
    end
  end
end
