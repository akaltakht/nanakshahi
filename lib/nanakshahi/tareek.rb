require "date"

class Nanakshahi
  # Implementation of date(Tareek) class for Nanakshahi.
  #
  # @author Arvinder Singh
  # @abstract
  # @since 0.1.0
  # @attr [Int] year Nanakshahi year
  # @attr [Int] month Nanakshahi month
  # @attr [Int] day Nanakshahi day
  # @attr_reader [Int] year Year value of the Tareek object
  # @attr_reader [Int] month Month(1-12) value of the Tareek object
  # @attr_reader [Int] day Day(1-31) value of the Tareek object
  include Comparable

  class Error < StandardError; end

  def self.date_grid(gyear)
    # #
    # The months follow the same index as MONTHS constant
    #   therefore although in Gregorian calendar Poh is first
    #   month of the nanakshahi year, it is at index 9
    #   sort of a merry-go-round.
    [
      (Date.new(gyear, 3, 14)..Date.new(gyear, 4, 13)).to_a,
      (Date.new(gyear, 4, 14)..Date.new(gyear, 5, 14)).to_a,
      (Date.new(gyear, 5, 15)..Date.new(gyear, 6, 14)).to_a,
      (Date.new(gyear, 6, 15)..Date.new(gyear, 7, 15)).to_a,
      (Date.new(gyear, 7, 16)..Date.new(gyear, 8, 15)).to_a,
      (Date.new(gyear, 8, 16)..Date.new(gyear, 9, 14)).to_a,
      (Date.new(gyear, 9, 15)..Date.new(gyear, 10, 14)).to_a,
      (Date.new(gyear, 10, 15)..Date.new(gyear, 11, 13)).to_a,
      (Date.new(gyear, 11, 14)..Date.new(gyear, 12, 13)).to_a,
      (Date.new(gyear, 12, 14)..Date.new(gyear, 12, 31)).to_a.concat((Date.new(gyear, 1, 1)..Date.new(gyear, 1, 12)).to_a),
      (Date.new(gyear, 1, 13)..Date.new(gyear, 2, 11)).to_a,
      (Date.new(gyear, 2, 12)..Date.new(gyear, 3, 13)).to_a,
    ]
  end

  MONTHS = %w(Chet Vaisakh Jeth Harh Sawan Bhadon Asu Katik Maghar Poh Magh Phagun)
  MONTHS_PA = %w(ਚੇਤ ਵੈਸਾਖ ਜੇਠ ਹਾੜ ਸਾਵਣ ਭਾਦੋਂ ਅੱਸੂ ਕੱਤਕ ਮੱਘਰ ਪੋਹ ਮਾਘ ਫੱਗਣ)

  attr_reader :year, :month, :day

  def initialize(year = 1, month = 1, day = 1)
    @day = day
    @month = month
    @year = year
  end

  # Implementation of spaceship operator to enable comparision
  #
  # @author Arvinder Singh
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

  # #
  # Gregorian to Nanakshahi date
  #
  def self.from_gregorian(gyear, gmonth, gday)
    # Start of time -  1 Chet, 1 Nanakshahi
    nanakshahi_epoch_in_gregorian = Date.new(1469, 3, 14)
    gdate = Date.new(gyear, gmonth, gday)

    # Implement ਧੁੰਦਕਾਲ(Before Nanak - from Bhai Gurdas's vaar) later
    # Any date prior to nanakshahi_epoch_in_gregorian returns nil for now
    return nil if gdate < nanakshahi_epoch_in_gregorian

    # Before Chet 1, it is previous year in Nanakshahi
    if (gmonth <= nanakshahi_epoch_in_gregorian.month) && (gday < nanakshahi_epoch_in_gregorian.day)
      nyear = gyear - 1469
    else
      nyear = gyear - 1468
    end

    nanakshahi_months = date_grid(gyear)

    row = nanakshahi_months.detect { |month| month.include?(gdate) }
    nday, nmonth = [row.index(gdate), nanakshahi_months.index(row)]

    # Months are 1 indexed, arrays are 0 indexed
    nmonth += 1
    nday += 1
    # Create a new Nanakshahi::Date object
    self.new(nyear, nmonth, nday)
  end

  protected :<=>
end
