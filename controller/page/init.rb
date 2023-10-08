# frozen_string_literal: true
 

root = ::File.dirname(__FILE__)
require ::File.join(root, 'base')
# -------------------------------------------
require ::File.join(root, 'gen/main/main_menu') 
 
# MAKE PAYMENT 
require ::File.join(root, 'gen/make_payment/amount')
require ::File.join(root, 'gen/make_payment/reference')
require ::File.join(root, 'gen/make_payment/summary') 

 
# CONTACT US
require ::File.join(root, 'contact_us/details')


# REQUEST LOAN
require ::File.join(root, 'mce/request_loan/first_name')
require ::File.join(root, 'mce/request_loan/last_name')
require ::File.join(root, 'mce/request_loan/ghana_card')
require ::File.join(root, 'mce/request_loan/account_reference')
require ::File.join(root, 'mce/request_loan/location')
require ::File.join(root, 'mce/request_loan/loan_amount')
require ::File.join(root, 'mce/request_loan/main_menu')
require ::File.join(root, 'mce/request_loan/summary')


#LOAN REPAYMENT 
require ::File.join(root, 'mce/loan_repayment/account_reference.rb')
require ::File.join(root, 'mce/loan_repayment/amount.rb')
require ::File.join(root, 'mce/loan_repayment/summary.rb')

# E_TICKET
require ::File.join(root, 'shows/e_ticket/main_menu.rb')
require ::File.join(root, 'shows/e_ticket/email.rb')
require ::File.join(root, 'shows/e_ticket/confirm_email.rb')
require ::File.join(root, 'shows/e_ticket/select_ticket.rb')
require ::File.join(root, 'shows/e_ticket/ticket_number.rb')
require ::File.join(root, 'shows/e_ticket/date.rb')
require ::File.join(root, 'shows/e_ticket/summary.rb')
