# frozen_string_literal: true

module Paginator
  def paginate_data(pages_data, _number_of_options_per_page, data_key)
    structured_data = []

    pages_data.each_with_index do |data, i|
      option_no = i + 1

      option_string = "#{option_no}.#{data[data_key.to_s]} \n"

      option_data = data.merge(
        'option' => option_no.to_s,
        'option_string' => option_string
      )

      structured_data.push(option_data)
    end

    structured_data.each_slice(2).to_a
  end
end
