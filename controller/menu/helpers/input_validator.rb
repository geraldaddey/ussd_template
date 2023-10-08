# frozen_string_literal: true

module InputValidator
  def valid_amount?(ussd_body)
    /^(?!00)[0-9]+(\.[0-9]+)?$/.match?(ussd_body)
  end

  def valid_loan_amount?(ussd_body)
    /^[0-9]+(\.[0-9]+)?$/.match?(ussd_body)
  end

  def valid_option(ussd_body)
    ussd_body == '1'
  end

  def valid_reference(ussd_body)
    ussd_body.length.between?(1, 20)
  end

  def valid_ghana_card?(ussd_body)
    /\A\d{10}\z/.match?(ussd_body)
  end
end
