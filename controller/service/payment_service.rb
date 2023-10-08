# frozen_string_literal: true
 

module Service
  class PaymentService < Menu::Base


    def amount
      fetch_data[:entity_info][:acme_module] == 'MCE' ? @data[:loan_amount] : @data[:amount]
    end
    
    def entity_code
      fetch_data[:entity_info][:entity_code]
    end

    def process_loan
      
      # response from loan endpoint 
      # if response && response[:resp_code]== '00'
      #   response
      # else
      #   error_message = response ? "Error Processing Loan => Error code: #{response[:resp_code]}: #{response[:resp_desc]}" : 'Unknown error'
      #   raise StandardError, error_message
      # end

    end

    def process_charge
      response = Api.get_request(GET_CHARGE_INFO, amount: amount, entity_div_code: entity_code, payment_mode: 'MOM')
      puts "CHARGE INFO ==> #{response.inspect}"

      charge_info = {
        total_amount: response[:data][:total_amount],
        fee: response[:data][:fee]
      }

      store_data(charge_info: charge_info)
    end
        
    def process_payment 
      fetch_data
      payload = generate_payment_payload(@data)

      response = Api.post_request(PROCESS_PAYMENT_REQUEST, payload)



      if response && response[:resp_code] == '015'
        response
      else
        error_message = response ? "Error Processing Payment => Error code: #{response[:resp_code]}: #{response[:resp_desc]}" : 'Unknown error'
        raise StandardError, error_message
      end
    end
    


    
    def self.process_loan(params)
      new(params).process_loan
    end
    
    def self.process_payment(params)
      new(params).process_payment
    end

    def self.process_charge(params)
      new(params).process_charge
    end

    private

    def generate_payment_payload(data)
      if data[:entity_info][:acme_module] == 'MCE'
         amount = data[:loan_amount]
      else 
        amount = data[:charge_info][:total_amount]  
      end
      pan = data[:tracker][:mobile_number]
      customer_number = data[:tracker][:mobile_number]
      entity_code = data[:entity_info][:entity_div_code]
      charge = data[:charge_info][:fee]
      # if data[:tracker][:menu_function] == REQUEST_LOAN || data[:tracker][:menu_function] == LOAN_REPAYMENT
      if data[:entity_info][:acme_module] == 'MCE'
        reference = data[:account_reference]
     else 
        reference = data[:reference]
     end
    
      network = data[:network]
      entity_code = data[:entity_info][:entity_code]
    
      payload = {
        amount: amount,
        nw: network,
        pan: pan,
        customer_number: customer_number,
        entity_div_code: entity_code,
        src: 'USSD',
        payment_mode: 'MOM',
        charge: charge,
        reference: reference
      }
    end
  end
end
