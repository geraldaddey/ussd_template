# frozen_string_literal: true

require 'sinatra'

post '/' do
  Dial::Manager.new(request.body.read).process
end
