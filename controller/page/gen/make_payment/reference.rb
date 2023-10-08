# frozen_string_literal: true

module Page
  module MakePayment
    class Reference < Menu::Base
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
           Page::MakePayment::Amount.process(@params.merge(activity_type: REQUEST))
        else
          store_data({reference: @ussd_body})
          Page::MakePayment::Summary.process(@params.merge(activity_type: REQUEST))
        end
      end

      def process_request
        log_display(display_message)
        render_page({
                      page: '2',
                      menu_function: MAKE_PAYMENT,
                      activity_type: RESPONSE
                    })
      end

      def display_message
        acme_module = @data[:entity_info][:acme_module]
        reference = acme_module == 'OMC' ? 'Attendant ID' : 'Your Name/Reference'
        entity_name = @data[:entity_info][:entity_name]
        
        message = <<~MSG
          #{entity_name}

          Enter #{reference}:
          
          #{BACK}. Back

        MSG

        @message_prepend + message
      end
    end
  end
end
