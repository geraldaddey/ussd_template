# frozen_string_literal: true


module Page
  module RequestLoan
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
          # Service::PaymentService.process_loan(@params)
          loan_requested = "You have successfully made a loan request of #{fetch_data[:loan_amount]}. You will be contacted soon for further details. Thank you for using this service"
          log_display(loan_requested) 
          end_session(loan_requested)
        elsif @ussd_body == BACK
           Page::RequestLoan::LoanAmount.process(@params.merge(activity_type: REQUEST))
        else
          @message_prepend = "Invalid Reference"
          process_request
        end
      end

      def process_request
        Service::PaymentService.process_charge(@params)
        log_display(display_message)
        render_page({
                      page: '8',
                      menu_function: REQUEST_LOAN,
                      activity_type: RESPONSE
                    })
      end

      def display_message
        entity_name = @data[:entity_info][:entity_name]
         
        message = <<~MSG
          #{entity_name}
          Summary
          
          Name: #{@data[:first_name]} #{@data[:last_name]}
          Ghana Card: #{@data[:ghana_card]}
          Reference: #{@data[:account_reference]}
          Location: #{@data[:location]}
          Loan Amount: #{@data[:loan_amount]}
          
          1. Proceed
          #{BACK}. Back

        MSG
 
        @message_prepend + message
      end
    end
  end
end
