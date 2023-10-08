# frozen_string_literal: true

require 'dotenv'
environment = ENV['RACK_ENV'] || 'development'
Dotenv.load("config/#{environment}.env")
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'

namespace :db do
  task :load_config do
    require './app'
  end
end
