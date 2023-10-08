# frozen_string_literal: true


module Page
  module MakePayment
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
           Page::MakePayment::Reference.process(@params.merge(activity_type: REQUEST))
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
                      menu_function: MAKE_PAYMENT,
                      activity_type: RESPONSE
                    })
      end

      def display_message
        entity_name = @data[:entity_info][:entity_name]
         
        message = <<~MSG
          #{entity_name}
          Summary
          
          Name/Ref: #{@data[:reference]}
          Amount: #{@data[:amount]}
          Charge: #{fetch_data[:charge_info][:fee]}
          Total: #{@data[:charge_info][:total_amount]}
          
          1. Proceed
          #{BACK}. Back

        MSG

        @message_prepend + message
      end
    end
  end
end
