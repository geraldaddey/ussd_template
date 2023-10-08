# frozen_string_literal: true

class Cache
  attr_accessor :mobile_number, :session_id, :cache

  def initialize(params)
    @session_id = params[:session_id]
    @mobile_number = params[:mobile_number]
    @cache = params[:cache] || '{}'
  end

  def self.store(params)
    session_id = params[:session_id]
    mobile_number = params[:msisdn]
    cache = { cache: params[:cache] }
    $redis.hset("#{session_id}-#{mobile_number}-cache", cache)
  end

  def self.fetch(params)
    session_id = params[:session_id]
    mobile_number = params[:msisdn]
    tracking_data = $redis.hgetall("#{session_id}-#{mobile_number}-cache")
    new(tracking_data.with_indifferent_access)
  end
end
