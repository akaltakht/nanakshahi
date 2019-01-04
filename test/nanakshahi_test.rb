require "test_helper"

class NanakshahiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Nanakshahi::VERSION
  end

  def test_default_date_gregorian
    date = Nanakshahi.new
    assert date.gregorian_date == Date.new(1469, 3, 14)
  end

  def test_default_date_nanakshahi
    date = Nanakshahi.new
    assert date.nanakshahi_date == Ndate.new(1, 1, 1)
  end

  def test_ndate_object
    ndate = Ndate.new(2016, 8, 12)
    assert ndate.day == 12
  end

  # Two test cases from the Pal Singh Purewal's paper
  def test_to_nanakshahi_returns_correct_ndate_object
    assert Nanakshahi.to_nanakshahi(1469, 3, 14) == Ndate.new(1,1,1)
  end

  def test_14_march_2004_CE_to_nanakshahi
    assert Nanakshahi.to_nanakshahi(2004, 3, 14) == Ndate.new(536,1,1)
  end

  # Test for leap year dates
  def test_non_leap_year_1_march_falls_on_18_phagun
    assert Nanakshahi.to_nanakshahi(2001, 3, 1) == Ndate.new(532, 12, 18)
  end

  def test_leap_year_1_march_falls_on_19_phagun
    assert Nanakshahi.to_nanakshahi(2000, 3, 1) == Ndate.new(531, 12, 19)
  end

  # As leap year date falls on the last month of Nanakshahi,
  # leap year in the Nanakshahi is the year that ends on March 13
  # of leap year in Gregorian
  # Thus it may appear that a leap year in CE as non-leap in Nanakshahi
  # and the year prior in Nanakshahi as leap
  def test_last_day_of_non_leap_nanakshahi_year_is_phagun_30
    assert Nanakshahi.to_nanakshahi(2001,3,13) == Ndate.new(532, 12, 30)
  end

  def test_last_day_of_leap_nanakshahi_year_is_phagun_31
    assert Nanakshahi.to_nanakshahi(2000,3,13) == Ndate.new(531, 12, 31)
  end
end
