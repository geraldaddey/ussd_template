# frozen_string_literal: true

module Page
  module RequestLoan
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
          Page::RequestLoan::FirstName.process(@params.merge(activity_type: REQUEST))
        when '2'
          Page::LoanRepayment::AccountReference.process(@params.merge(activity_type: REQUEST))
        when '3'
          Page::ContactUs::Details.process(@params.merge(activity_type: REQUEST, menu_function: REQUEST_LOAN))
        else
          @message_prepend = "Invalid Option. \n"
          process_request
        end
      end

      def process_request
        log_display(display_message)
        render_page({
                      page: '1',
                      menu_function: REQUEST_LOAN,
                      activity_type: RESPONSE
                    })
      end

      def display_message
        entity_name = @data[:entity_info][:entity_name]
        message = <<~MSG
          Welcome to #{entity_name}

          1. Request Loan
          2. Loan Repayment
          3. Contact Us

        MSG

        @message_prepend + message
      end
    end
  end
end
