# frozen_string_literal: true

module Page
  module LoanRepayment
    class Summary < Menu::Base
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
        if valid_option(@ussd_body)
          Service::PaymentService.process_payment(@params)
          log_display(THANK_YOU)
          end_session(THANK_YOU)
        elsif @ussd_body == BACK
           Page::LoanRepayment::Amount.process(@params.merge(activity_type: REQUEST))
        else
          @message_prepend = "Invalid Reference"
          process_request
        end
      end

      def process_request
        Service::PaymentService.process_charge(@params)
        log_display(display_message)
        render_page({
                      page: '3',
                      menu_function: LOAN_REPAYMENT,
                      activity_type: RESPONSE
                    })
      end

      def display_message
        entity_name = @data[:entity_info][:entity_name]
        message = <<~MSG
        #{entity_name}
        Summary
          
        Account/Reference: #{@data[:account_reference]}
        Amount: #{@data[:loan_amount]}

          1. Proceed
          #{BACK}. Back

        MSG

        @message_prepend + message
      end
    end
  end
end
