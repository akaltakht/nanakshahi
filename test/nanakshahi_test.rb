require "test_helper"

class NanakshahiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Nanakshahi::VERSION
  end

  def test_ਪਹਿਲੀ_ਤਰੀਕ_ਨਾਨਕਸ਼ਾਹੀ
    date = Nanakshahi.new
    assert date.gregorian_date == Date.new(1469, 3, 14)
  end
end
