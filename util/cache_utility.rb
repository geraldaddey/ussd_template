# frozen_string_literal: true

module CacheUtility
  def fetch_data
    @cache = Cache.fetch(@params).cache
    @data = JSON.parse(@cache).with_indifferent_access
  end

  def store_data(new_data)
    fetch_data
    Cache.store(@params.merge(cache: @data.merge(new_data).to_json))
  end
end
