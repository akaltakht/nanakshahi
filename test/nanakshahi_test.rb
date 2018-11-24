require "test_helper"

class NanakshahiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Nanakshahi::VERSION
  end

  # def test_today_class_method_creates_a_new_year_object
  #   nanakshahi = Nanakshahi.today
  #   assert nanakshahi.year == Date.today.year
  # end

  def test_today_method
    assert Nanakshahi.today == "Today is the day"
  end
end
