# frozen_string_literal: true

module Page
  module RequestLoan
    class Location < Menu::Base
      def process
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
          Page::RequestLoan::AccountReference.process(@params.merge(activity_type: REQUEST))
        else
          store_data({location: @ussd_body})
          Page::RequestLoan::LoanAmount.process(@params.merge(activity_type: REQUEST))
        end
      end

      def process_request
        log_display(display_message)
        render_page({
                      page: '6',
                      menu_function: REQUEST_LOAN,
                      activity_type: RESPONSE
                    })
      end

      def display_message
        fetch_data
        entity_name = @data[:entity_info][:entity_name]
        message = <<~MSG
          #{entity_name}

          Enter Your Location:

          #{BACK}. Back

        MSG

        @message_prepend + message
      end
    end
  end
end
