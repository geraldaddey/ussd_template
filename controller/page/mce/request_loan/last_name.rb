# frozen_string_literal: true

module Page
  module RequestLoan
    class LastName < Menu::Base
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
          Page::RequestLoan::FirstName.process(@params.merge(activity_type: REQUEST))
        else
          store_data({ last_name: @ussd_body })
          Page::RequestLoan::GhanaCard.process(@params.merge(activity_type: REQUEST))
        end
      end

      def process_request
        log_display(display_message)
        render_page({
                      page: '3',
                      menu_function: REQUEST_LOAN,
                      activity_type: RESPONSE
                    })
      end

      def display_message
        entity_name = @data[:entity_info][:entity_name]
        message = <<~MSG
          #{entity_name}

          Enter Last Name:

          #{BACK}. Back

        MSG

        @message_prepend + message
      end
    end
  end
end
