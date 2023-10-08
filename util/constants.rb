# frozen_string_literal: true

# config
COUNTRY_CODE = 'GH'

# MODULES
GENERAL_MERCHANT = 'GEN'
OIL_MARKETING_COMPANY = 'OMC'
MICROCREDIT = 'MCE'
SHOWS = 'SHW'

# MENU
MAIN_MENU = 'main_menu'
CONTACT_US = 'contact_us'
MAKE_PAYMENT = 'make_payment'
MORE_MENU = 'more_menu'
PAGINATE_MENU = 'paginate_menu'
REQUEST_LOAN = 'request_loan'
LOAN_REPAYMENT = 'loan_repayment'
E_TICKET = 'e_ticket'

# MENUS
MENU_FUNCTIONS = {
  MAIN_MENU => Menu::Main,
  MAKE_PAYMENT => Menu::MakePayment,
  CONTACT_US => Menu::ContactUs,
  REQUEST_LOAN => Menu::RequestLoan,
  LOAN_REPAYMENT => Menu::LoanRepayment,
  E_TICKET => Menu::ETicket
}.freeze

# ENDPOINTS
RETRIEVE_ENTITY_INFO = '/retrieve_entity_info'
PROCESS_PAYMENT_REQUEST = '/process_payment_req'
GET_CHARGE_INFO = '/get_charge_info'

# NAVIGATION
BACK = '00'
THANK_YOU = 'Thank you for using acme ussd by Gerald Addey. Please wait for your payment prompt to approve the transaction'

# ACTIVITY
RESPONSE = 'response'
REQUEST = 'request'

# MODULE PAGES
#move to pages constants 
MAKE_PAYMENT_PAGES = {
  '1' => Page::MakePayment::Amount,
  '2' => Page::MakePayment::Reference,
  '3' => Page::MakePayment::Summary
}.freeze

LOAN_REPAYMENT_PAGES = {
  '1' => Page::LoanRepayment::AccountReference,
  '2' => Page::LoanRepayment::Amount,
  '3' => Page::LoanRepayment::Summary
}.freeze

REQUEST_LOAN_PAGES = {
  '1' => Page::RequestLoan::MainMenu,
  '2' => Page::RequestLoan::FirstName,
  '3' => Page::RequestLoan::LastName,
  '4' => Page::RequestLoan::GhanaCard,
  '5' => Page::RequestLoan::AccountReference,
  '6' => Page::RequestLoan::Location,
  '7' => Page::RequestLoan::LoanAmount,
  '8' => Page::RequestLoan::Summary
}.freeze

E_TICKET_PAGES = {
  '1' => Page::ETicket::MainMenu,
  '2' => Page::ETicket::Date,
  '3' => Page::ETicket::SelectTicket,
  '4' => Page::ETicket::TicketNumber,
  '5' => Page::ETicket::Email, 
  '6' => Page::ETicket::ConfirmEmail,
  '7' => Page::ETicket::Summary
}.freeze


# API
HEADERS = { 'Content-Type' => 'application/json' }.freeze
ACME_CONN = Faraday.new(url: (ENV['ACME_API_URL']).to_s, headers: HEADERS, ssl: { verify: false }) do |faraday|
  # faraday.request  :url_encoded             # form-encode POST params

  faraday.response :logger                  # log requests to STDOUT

  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end

set :ACME_CONN, ACME_CONN
