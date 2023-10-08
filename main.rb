


require 'sinatra'
require 'sinatra/activerecord'
require 'yaml'
require 'faraday'
require 'sendgrid-ruby'
require 'bigdecimal'
require 'bigdecimal/util'
require 'email_validator'
require 'time'
require 'byebug' 

def get_notice()

  time_due = TIME_LOCK_MAIN
  time_now = Time.now
  minutes = ((time_due - time_now) * 24 * 60).to_i

  notice="ATTENTION: There will be a scheduled maintenance on this system from #{TIME_LOCK_STR} to #{END_LOCK_STR}. Please take note"
  notice
end


post '/' do
  request.body.rewind
  puts "#################################################################################"
  puts "###########################       ACME  USSD           #########################"
  puts "###########################       ACME  USSD          #########################"
  puts "###########################       ACME  USSD          #########################"
  puts "#################################################################################"


  # process(request.body.read)

  s_params = JSON.parse(request.body.read)
 puts " FROM MAIN  #{s_params} "

 current_time = Time.now
 if TIME_LOCK_MAIN <= current_time

   mobile_number = s_params['msisdn']

   if END_TIME_LOCK_MAIN <= current_time
     process(s_params)
   else

     if WHITELIST_NUMBERS.include? mobile_number
       process(s_params)
     else
       puts "scheduled maintenance. Thank you. mobile_number = #{mobile_number} "
       puts "System maintenance in progress.\nTry again later. mobile_number = #{mobile_number} "
       expire_session(s_params,"System upgrade in progress.\nTry again later.")
     end

   end

 else
   process(s_params)
 end


end
