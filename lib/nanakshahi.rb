require 'nanakshahi/version'
require 'date'

# Nanakshahi Calendar based on research by Pal Singh Purewal
class Nanakshahi
  include Comparable
  class Error < StandardError; end

  MONTHS =  %w(Chet Vaisakh Jeth Harh Sawan Bhadon Asu Katik Maghar Poh Magh Phagun)
  MONTHS_PA = %w(ਚੇਤ ਵੈਸਾਖ ਜੇਠ ਹਾੜ ਸਾਵਣ ਭਾਦੋਂ ਅੱਸੂ ਕੱਤਕ ਮੱਘਰ ਪੋਹ ਮਾਘ ਫੱਗਣ)

  # #
  # Create a Nanakshahi date object.
  #   At rest store the dates both as:
  #     Gregorian - for calculations and time navigation
  #     Nanakshahi - for quick recall
  # attr_reader :gregorian_date, :nanakshahi_date
  attr_reader :day, :month, :year
  def initialize(year=1, month=1, day=1)
    @day = day
    @month = month
    @year = year
  end

  def <=>(other)
    (self.day <=> other.day) && (self.month <=> other.month) && (self.year <=> other.year)
  end

  # #
  # Gregorian to Nanakshahi date
  #
  def self.from_gregorian(gyear, gmonth, gday)
    # Start of time -  1 Chet, 1 Nanakshahi
    nanakshahi_epoch_in_gregorian = Date.new(1469,3,14)
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

    # #
    # The months follow the same index as MONTHS constant
    #   therefore although in Gregorian calendar Poh is first
    #   month of the nanakshahi year, it is at index 9
    #   sort of a merry-go-round.
    nanakshahi_months =  [
      (Date.new(gyear,3,14)..Date.new(gyear,4,13)).to_a,
      (Date.new(gyear,4,14)..Date.new(gyear,5,14)).to_a,
      (Date.new(gyear,5,15)..Date.new(gyear,6,14)).to_a,
      (Date.new(gyear,6,15)..Date.new(gyear,7,15)).to_a,
      (Date.new(gyear,7,16)..Date.new(gyear,8,15)).to_a,
      (Date.new(gyear,8,16)..Date.new(gyear,9,14)).to_a,
      (Date.new(gyear,9,15)..Date.new(gyear,10,14)).to_a,
      (Date.new(gyear,10,15)..Date.new(gyear,11,13)).to_a,
      (Date.new(gyear,11,14)..Date.new(gyear,12,13)).to_a,
      (Date.new(gyear,12,14)..Date.new(gyear,12,31)).to_a.concat((Date.new(gyear,1,1)..Date.new(gyear,1,12)).to_a),
      (Date.new(gyear,1,13)..Date.new(gyear,2,11)).to_a,
      (Date.new(gyear,2,12)..Date.new(gyear,3,13)).to_a
    ]

    row = nanakshahi_months.detect{|month| month.include?(gdate)}
    nday, nmonth = [row.index(gdate), nanakshahi_months.index(row)]

    # Months are 1 indexed, arrays are 0 indexed
    nmonth += 1
    nday += 1

    Nanakshahi.new(nyear, nmonth, nday)
  end

  # #
  # Nanakshahi to Gregorian date
  #
  def to_gregorian
    last_nmonth_of_gyear = 10 # ਪੋਹ 
    last_nday_of_gyear = 18 # ੧੮

    if month <=last_nmonth_of_gyear && day <=last_nday_of_gyear
      gyear = year + 1468
    else
      gyear = year + 1469
    end

    nanakshahi_months =  [
      (Date.new(gyear,3,14)..Date.new(gyear,4,13)).to_a,
      (Date.new(gyear,4,14)..Date.new(gyear,5,14)).to_a,
      (Date.new(gyear,5,15)..Date.new(gyear,6,14)).to_a,
      (Date.new(gyear,6,15)..Date.new(gyear,7,15)).to_a,
      (Date.new(gyear,7,16)..Date.new(gyear,8,15)).to_a,
      (Date.new(gyear,8,16)..Date.new(gyear,9,14)).to_a,
      (Date.new(gyear,9,15)..Date.new(gyear,10,14)).to_a,
      (Date.new(gyear,10,15)..Date.new(gyear,11,13)).to_a,
      (Date.new(gyear,11,14)..Date.new(gyear,12,13)).to_a,
      (Date.new(gyear,12,14)..Date.new(gyear,12,31)).to_a.concat((Date.new(gyear,1,1)..Date.new(gyear,1,12)).to_a),
      (Date.new(gyear,1,13)..Date.new(gyear,2,11)).to_a,
      (Date.new(gyear,2,12)..Date.new(gyear,3,13)).to_a
    ]

    nanakshahi_months[month - 1][day - 1]
  end
end