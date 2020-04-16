require "test_helper"

class NanakshahiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Nanakshahi::VERSION
  end

  def test_default_date_nanakshahi
    date = Nanakshahi.new
    assert date == Nanakshahi.new(1, 1, 1)
  end

  def test_ndate_object
    ndate = Nanakshahi.new(2016, 8, 12)
    assert ndate.day == 12
  end

  # Two test cases from the Pal Singh Purewal's paper
  def test_from_gregorian_returns_correct_ndate_object
    assert Nanakshahi.from_gregorian(1469, 3, 14) == Nanakshahi.new(1, 1, 1)
  end

  def test_14_march_2004_CE_from_gregorian
    assert Nanakshahi.from_gregorian(2004, 3, 14) == Nanakshahi.new(536, 1, 1)
  end

  # Test for leap year dates
  def test_non_leap_year_1_march_falls_on_18_phagun
    assert Nanakshahi.from_gregorian(2001, 3, 1) == Nanakshahi.new(532, 12, 18)
  end

  def test_leap_year_1_march_falls_on_19_phagun
    assert Nanakshahi.from_gregorian(2000, 3, 1) == Nanakshahi.new(531, 12, 19)
  end

  # As leap year date falls on the last month of Nanakshahi,
  # leap year in the Nanakshahi is the year that ends on March 13
  # of leap year in Gregorian
  # Thus it may appear that a leap year in CE as non-leap in Nanakshahi
  # and the year prior in Nanakshahi as leap
  def test_last_day_of_non_leap_nanakshahi_year_is_phagun_30
    assert Nanakshahi.from_gregorian(2001, 3, 13) == Nanakshahi.new(532, 12, 30)
  end

  def test_last_day_of_leap_nanakshahi_year_is_phagun_31
    assert Nanakshahi.from_gregorian(2000, 3, 13) == Nanakshahi.new(531, 12, 31)
  end

  # Test #to_gregorian method
  def test_1_chet_1_to_gregorian
    assert Nanakshahi.new.to_gregorian == Date.new(1469, 3, 14)
  end

  def test_Nanakshahi_536_1_1_to_gregorian
    assert Nanakshahi.new(536, 1, 1).to_gregorian == Date.new(2004, 3, 14)
  end

  # Test Comparables
  def test_less_than
    assert Nanakshahi.new(536, 1, 1) < Nanakshahi.new(536, 1, 2)
  end

  def test_greater_than
    assert Nanakshahi.new(536, 1, 2) > Nanakshahi.new(536, 1, 1)
  end

  def test_equality
    assert Nanakshahi.new(536, 1, 1) == Nanakshahi.new(536, 1, 1)
  end

  def test_inequality
    assert Nanakshahi.new(536, 1, 2) != Nanakshahi.new(536, 1, 1)
  end

  def test_to_s_method
    assert Nanakshahi.from_gregorian(1460, 9, 10).to_s == "26 Bhadon, 9 Dhundkaal"
  end

  # Test to_gurmukhi
  def test_to_gurmikhi_method
    assert Nanakshahi.from_gregorian(1460, 9, 10).to_gurmukhi == "੨੬ ਭਾਦੋਂ, ੯ ਧੁੰਦਕਾਲ"
  end

  def test_date_class_monkeypatching
    assert Date.new(2019, 1, 8).to_nanakshahi == Nanakshahi.new(550, 10, 26)
  end

  def test_today_method
    assert Nanakshahi.today == Date.today.to_nanakshahi
  end

  def test_year_method
    assert Nanakshahi.new(550, 10, 12).year == 550
  end

  def test_month_method
    assert Nanakshahi.new(550, 10, 12).month == 10
  end

  def test_day_method
    assert Nanakshahi.new(550, 10, 12).day == 12
  end

  # Test for leap year
  def test_nanak_550_is_not_leap_year
    assert Nanakshahi.new(550, 10, 12).leap? == false
  end

  def test_nanak_551_is_leap_year
    assert Nanakshahi.new(552).leap? == true
  end

  def test_2018_jan_10_should_be_a_thursday
    assert Nanakshahi.from_gregorian(2018,1,10).wday_name == 'Thursday'
  end

  def test_2018_jan_10_should_be_a_ਵੀਰਵਾਰ
    assert Nanakshahi.from_gregorian(2018,1,10).vaar == 'ਵੀਰਵਾਰ'
  end

  def test_chet_1_should_be_gurpurab
    assert Nanakshahi.new(550,1,1).gurpurab?
  end

  def test_chet_2_should_not_be_gurpurab
    assert ! Nanakshahi.new(550,1,2).gurpurab?
  end

  def test_gurpurabs_method_returns_vaisakhi_on_vaisakh_1
    assert Nanakshahi.new(550,2,1).gurpurabs.include?('Vaisakhi')
  end

  def test_no_gurpurabs_on_vaisakh_2
    assert ! Nanakshahi.new(550,2,2).gurpurabs
  end

  def test_gurupurabs_methods_returns_atleast_3_gurpurab_on_vaisakh_2
    assert Nanakshahi.new(550,2,3).gurpurabs.size >= 3
  end

  def test_march_13_2020_returns_1_vaisakh_552
    assert Nanakshahi.new(552,2,1) == Date.new(2020,4,14).to_nanakshahi
  end
end
