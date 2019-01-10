require "date"
require "i18n"
I18n.load_path << Dir[File.expand_path("config/locales") + "/*.yml"]
require "nanakshahi/version"
require "nanakshahi/grid"
require "nanakshahi/utils"
require "nanakshahi/date"

# Nanakshahi Calendar date based on research by Pal Singh Purewal
# @author Arvinder Singh
# @see http://panjabilab.com Panjabi Lab
# @since 0.1.0
# @attr_reader [Integer] year Year part of Nanakshahi date object
# @attr_reader [Integer] month Month part of Nanakshahi date object
# @attr_reader [Integer] day Day part of Nanakshahi date object
class Nanakshahi
  include Comparable
  extend Utils
  extend Grid

  # Returns today as a Nanakshahi date
  def self.today
    Date.today.to_nanakshahi
  end

  attr_reader :year, :month, :day

  # Creates new instance of Nanakshahi
  #
  # @param [Integer] year Year part of Nanakshahi date
  # @param [Integer] month Month part of Nanakshahi date
  # @param [Integer] day Day part of Nanakshahi date
  def initialize(year = 1, month = 1, day = 1)
    @day = day
    @month = month
    @year = year
  end

  # Converts Nanakshahi to Gregorian date
  #
  # @return [Date] Converts nanakshahi into corresponding gregorian# as Date object
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

  # String representation of Nanakshahi object
  #
  # @return [String] String representation of Nanakshahi
  def to_s
    era = year < 1 ? :Dhundkaal : :Nanakshahi
    "#{day} #{I18n.t(:nanakshahi_months)[month]}, #{year_zero_correction(year)} #{era}"
  end

  # Gurmukhi String representation of Nanakshahi object
  #
  # @return [String] Gurmukhi String representation of Nanakshahi
  def to_gurmukhi
    era = year < 1 ? :ਧੁੰਦਕਾਲ : :ਨਾਨਕਸ਼ਾਹੀ
    "#{panjabi_numerals(day)} #{I18n.t(:nanakshahi_months, locale: :pa)[month]}, #{panjabi_numerals(year_zero_correction(year))} #{era}"
  end

  # Checks Nanakshahi leap year
  #
  # @return [Boolean] True if Nanakshahi year's Phagun has 31 days
  def leap?
    self.to_gregorian.leap?
  end

  protected

  # Implementation of spaceship operator to enable comparision
  #
  # @param [Nanakshahi] other Other object to compare with
  # @return [Integer]
  #   nil if not a Nanakshahi object
  #   -1 if self < other
  #    0 if self == other
  #    1 if self > other
  def <=>(other)
    return nil unless self.is_a?(Nanakshahi) && other.is_a?(Nanakshahi)
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
  #
  # @param [Integer] dyear Year
  # @return [Integer] Year corrected for year 0
  def year_zero_correction(dyear)
    dyear < 1 ? dyear.abs + 1 : dyear.abs
  end

  # Converts english numerals to Gurmukhi
  #
  # @param [Integer] number A numeric usually date
  # @return [String] Panjabi representation of date
  def panjabi_numerals(number)
    number.to_s.chars.map { |digit| I18n.t(:digits, locale: :pa)[digit.to_i] }.join
  end
end
