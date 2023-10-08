# frozen_string_literal: true

require 'sinatra'
require 'dotenv'
Dotenv.load('.env')

environment = ENV['RACK_ENV']
set :environment, environment

require 'sinatra/activerecord'
require 'byebug'
require 'redis'
require 'rubocop'
require 'faraday'
require 'phonelib'
require 'date'

disable :run, :reload

configure do
  $redis = Redis.new(host: 'localhost', port: 6379)
end

configure :development do
  disable :show_exceptions
  disable :raise_errors
end

require './app'
require './controller/init'
require './models/init'
require './util/init'

Phonelib.default_country = COUNTRY_CODE

# configure redis
configure do
  $redis = Redis.new(host: 'localhost', port: 6379)
end

run Sinatra::Application
