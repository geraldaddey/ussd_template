# frozen_string_literal: true

class ProcessingError < StandardError
  attr_reader :page

  def initialize(msg, page: {})
    super(msg)
    @page = page
  end
end

error ProcessingError do
  error = env['sinatra.error'] 
  logger.error "An error occurred: #{error.message}"
  logger.error "Page: #{error.page.inspect}"
  status 500
end