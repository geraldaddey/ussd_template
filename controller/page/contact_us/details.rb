# frozen_string_literal: true
# 

module Page
  module ContactUs
    class Details < Menu::Base
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
        if @ussd_body == BACK
          Page::Main::MainMenu.process(@params.merge(activity_type: REQUEST))
        else
          @message_prepend = "Invalid Input \n"
          process_request
        end
      end

      def process_request
        log_display(display_message)
        render_page({
                      page: '1',
                      menu_function: CONTACT_US,
                      activity_type: RESPONSE
                    })
      end

      def display_message
        message = <<~MSG
        Contact Us
        
        Tel: 0302955701/0302502257
        Email: Support@acmesolutions.com
        Powered by 
        
        #{BACK}. Back
        
        MSG

        @message_prepend + message
      end
    end
  end
end
