# frozen_string_literal: true

require "test_helper"

class IpgeobaseTest < Minitest::Test
  def setup
    stub_request(:get, "http://ip-api.com/xml/83.169.216.199")
      .to_return(body: File.new("#{__dir__}/fixtures/response_body.xml"), status: 200)
  end

  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_lookup
    ip_meta = Ipgeobase.lookup("http://ip-api.com/xml/83.169.216.199")
    assert_equal ip_meta.country, "Russia"
    assert_equal ip_meta.countryCode, "RU"
  end
end
