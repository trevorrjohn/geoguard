require "geoguard/configuration"
require "geoguard/version"
require "rest_client"

module GeoGuard
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end

  def self.update(cache_headers: {})
    path = "/v1/update/#{configuration.format}/geostream"
    headers = {
      'X-Geostream-License-Key' => configuration.license,
      'X-Geostream-Client-Id' => configuration.client_id
    }.merge(cache_headers)
    response = RestClient.get("#{configuration.host}#{path}", headers)
    response.body if response.code >= 200 && response.code < 300
  end
end
