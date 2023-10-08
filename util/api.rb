# frozen_string_literal: true
#  

# simple in-house implementation for an api for dev environment only
module Api
  
  def self.get_request(endpoint, params = {})
    response = ACME_CONN.get(endpoint, params)
    JSON.parse(response.body)&.with_indifferent_access
  end

  def self.post_request(endpoint, payload = {})
    response = ACME_CONN.post(endpoint) do |request|
      request.headers['Content-Type'] = 'application/json'
      request.body = payload.to_json
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def parse_payload(payload)
    JSON.parse(payload.body)&.with_indifferent_access
  end
end
