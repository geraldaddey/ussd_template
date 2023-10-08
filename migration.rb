


require 'sinatra'
require 'json'
require 'sinatra/activerecord'
require './models/model'


#    t.string  :name
#    t.decimal   :amount, precision: 12, scale: 2


ActiveRecord::Migration.create_table :more_helpers do |t|
  t.string  :session_id
  t.string      :mobile_number
  t.integer      :last
  t.integer      :current
  t.string      :function
  t.string      :page

  t.timestamps null: false
end
