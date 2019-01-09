require "date"
require "i18n"
I18n.load_path << Dir[File.expand_path("config/locales") + "/*.yml"]
require "nanakshahi/version"
require "nanakshahi/constants"
require "nanakshahi/grid"
require "nanakshahi/utils"
require "nanakshahi/date"

# Nanakshahi Calendar date based on research by Pal Singh Purewal
# @author Arvinder Singh
# @since 0.1.0
class Nanakshahi
  include Comparable
  extend Constants
  extend Utils
  extend Grid

  # Returns today as a Nanakshahi date
  def self.today
    Date.today.to_nanakshahi
  end

  attr_reader :year, :month, :day

  def initialize(year = 1, month = 1, day = 1)
    @day = day
    @month = month
    @year = year
  end

  # #
  # Nanakshahi to Gregorian date
  #
  def to_gregorian
    last_nmonth_of_gyear = 10 # ਪੋਹ
    last_nday_of_gyear = 18 # ੧੮

    if month <= last_nmonth_of_gyear && day <= last_nday_of_gyear
      gyear = year + 1468
    else
      gyear = year + 1469
    end

    nanakshahi_months = self.class.date_grid(gyear)
    nanakshahi_months[month - 1][day - 1]
  end

  def to_s
    era = year < 1 ? :Dhundkaal : :Nanakshahi
    "#{day} #{I18n.t(:nanakshahi_months)[month]}, #{year_zero_correction(year)} #{era}"
  end

  def to_gurmukhi
    era = year < 1 ? :ਧੁੰਦਕਾਲ : :ਨਾਨਕਸ਼ਾਹੀ
    "#{panjabi_numerals(day)} #{I18n.t(:nanakshahi_months, locale: :pa)[month]}, #{panjabi_numerals(year_zero_correction(year))} #{era}"
  end

  protected

  # Implementation of spaceship operator to enable comparision
  #
  def <=>(other)
    return nil unless self.is_a?(Nanakshahi) && other.is_a?(Nanakshahi)
    # Compare year
    if ((self.year < other.year) ||
        (self.year == other.year && self.month < other.month) ||
        (self.year == other.year && self.month == other.month && self.day < other.day))
      return -1
    elsif self.year == other.year && self.month == other.month && self.day == other.day
      return 0
    else
      return 1
    end
  end

  private

  # Considering no year 0 just like in Gregorian
  # Year 1 Dhundkaal precedes 1 Nanakshahi
  def year_zero_correction(dyear)
    dyear < 1 ? dyear.abs + 1 : dyear.abs
  end

  def panjabi_numerals(number)
    # I18n.locale = :pa
    number.to_s.chars.map { |digit| I18n.t(:digits, locale: :pa)[digit.to_i] }.join
  end
end
