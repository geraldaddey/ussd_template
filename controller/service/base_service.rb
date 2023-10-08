# frozen_string_literal: true

module Session
  class Base < Menu::Base 
    
    def initialize(params)
      @message_type = params[:msg_type]
      @ussd_body = params[:ussd_body]
      @params = params
      @display_message = params[:display_message]
      @session_id = params[:session_id]
    end

    def self.process(params)
      new(params).process
    end
  end
end
