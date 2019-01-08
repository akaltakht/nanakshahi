require "date"
require "nanakshahi/version"
require "nanakshahi/constants"
require "nanakshahi/gregorian"
require "nanakshahi/grid"

# Nanakshahi Calendar date based on research by Pal Singh Purewal
# @author Arvinder Singh
# @since 0.1.0
class Nanakshahi
  include Comparable
  extend Constants
  extend Gregorian
  extend Grid

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
end
