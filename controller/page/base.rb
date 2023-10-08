# frozen_string_literal: true

module Page
  class Base
    def initialize(params)
      @page = params[:page]
      @tracker = params[:tracker]
      @mobile_number = params[:mobile_number]
      @ussd_body = params[:ussd_body]
      @session_id = params[:session_id]
      @params = params
    end

    def self.process(params)
      new(params).process
    end
  end
end
