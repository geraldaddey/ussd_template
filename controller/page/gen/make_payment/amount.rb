# frozen_string_literal: true

module Page
  module MakePayment
    class Amount < Menu::Base
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
        if valid_amount?(@ussd_body)
          store_data({ amount: @ussd_body })
          Page::MakePayment::Reference.process(@params.merge(activity_type: REQUEST))
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
                      page: '1',
                      menu_function: MAKE_PAYMENT,
                      activity_type: RESPONSE
                    })
      end

      def display_message
        entity_name = @data[:entity_info][:entity_name]
        message = <<~MSG
          #{entity_name}

          Enter Amount:

          #{BACK}. Back

        MSG

        @message_prepend + message
      end
    end
  end
end
