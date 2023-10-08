  # frozen_string_literal: true
  
  # require './controller/menu/helpers/input_validator'

  module Menu
    class Base
     include InputValidator, LoggerHelper

      def initialize(params)
        @params = params
        @tracker = params[:tracker]
        @activity_type = @params[:activity_type] || @tracker&.[](:activity_type)
        @ussd_body = params[:ussd_body]
        @mobile_number = params[:msisdn]
        @session_id = params[:session_id]
        @message_append = params[:message_append]
        @message_prepend = params[:message_prepend].to_s
        @network = params[:nw_code].to_s
        initialize_pages
      end

      def fetch_data
        @cache = Cache.fetch(@params).cache
        @data = JSON.parse(@cache).with_indifferent_access
      end
  
      def store_data(new_data)
        fetch_data
        Cache.store(@params.merge(cache: @data.merge(new_data).to_json))
      end
  

      def self.process(params)
        new(params).process
      end

      def end_session(message = 'Service Unavailable. Please try again later')
        Session::Manager.end(
          @params.merge(display_message: message)
        )
      end

      def render_main_menu(options = {})
        @params[:page] = '1'
        Page::Main::First.process(@params.merge(options))
      end
      
      def render_page(options)
        params = @params.merge(options) 
        puts "PARAMS ==> #{params.inspect}"
        fetch_data
        
        tracker_data = {
          message_type: params[:msg_type],
          page: params[:page],
          ussd_body: params[:ussd_body],
          menu_function: params[:menu_function],
          mobile_number: @mobile_number,
          session_id: params[:session_id],
          activity_type: params[:activity_type],
          pagination_page: params[:pagination_page]
        }

        activty_tracker_data = {

        session_id: params[:session_id],
        mobile_number: @mobile_number,
        activity_type: @data[:entity_info][:acme_module],
        entity_div_name: @data[:entity_info][:entity_name],
        entity_div_code: @data[:entity_info][:entity_code],
        service_label: @data[:entity_info][:service_label],
        activity_type_menu:  params[:menu_function],
        payment_reference: @data[:reference],
        amount: @data[:amount],
        total_amount: @data[:total_amount],
        charge: @data[:charge],
        service_code: @data[:service_code]
        }  
          

        # KEEP RECORDS (TRACK DATA) 
        ActivityTracker.create!(activty_tracker_data) 
        store_data({ tracker: tracker_data }) 

        Session::Manager.continue(
          @params.merge(display_message: display_message)
        )
      end

      private

      def initialize_pages
        @page = @params[:page] || @tracker&.[](:page)
      end
    end
  end
