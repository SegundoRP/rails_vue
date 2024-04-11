# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'json'

# class for get earthqueakes for the last 30 days
class UsgsClient
  API_URL = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'

  def earthquakes_last_month
    response = build_get_request
    JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
  end

  # private

  def build_url
    URI(API_URL.to_s)
  end

  def build_get_request
    url = build_url
    request = Net::HTTP::Get.new(url)
    request['Content-Type'] = 'application/json'
    Net::HTTP.start(url.host, url.port, use_ssl: url.scheme == 'https') do |http|
      http.request(request)
    end
  end
end
