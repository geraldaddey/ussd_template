# frozen_string_literal: true

module Page
  module RequestLoan
    class LoanAmount < Menu::Base
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
        if valid_loan_amount?(@ussd_body)
          store_data({ loan_amount: @ussd_body })
          Page::RequestLoan::Summary.process(@params.merge(activity_type: REQUEST))
        elsif @ussd_body == BACK
          Page::Main::MainMenu.process(@params.merge(activity_type: REQUEST))
        else
          @message_prepend = "Invalid amount \n"
          process_request
        end
      end

      def process_request
        log_display(display_message)
        render_page({
                      page: '7',
                      menu_function: REQUEST_LOAN,
                      activity_type: RESPONSE
                    })
      end

      def display_message
        entity_name = fetch_data[:entity_info][:entity_div_name]
        message = <<~MSG
          #{entity_name}

          Enter Loan Amount:

          #{BACK}. Back

        MSG

        @message_prepend + message
      end
    end
  end
end
