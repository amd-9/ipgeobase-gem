# frozen_string_literal: true

require_relative "ipgeobase/version"
require 'uri'
require 'net/http'
require 'happymapper'

module Ipgeobase
  class Error < StandardError; end

  class IpMeta
    include HappyMapper

    tag 'query'
    element :city, String, tag: 'city'
    element :country , String, tag: 'country'
    element :countryCode, String, tag: 'countryCode'
    element :lat, Float, tag: 'lat'
    element :lon , Float, tag: 'lon'
  end
  
  def self.lookup(address)
    uri = URI(address)
    res = Net::HTTP.get_response(uri)
    IpMeta.parse(res.body, single: true) if res.is_a?(Net::HTTPSuccess)
  end
end
