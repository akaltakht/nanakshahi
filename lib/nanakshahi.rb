require 'nanakshahi/version'
require 'nanakshahi/ndate'
# require_relative 'nanakshahi/ndate'
require 'date'

# Nanakshahi Calendar based on research by Pal Singh Purewal
class Nanakshahi
  class Error < StandardError; end

  MONTHS =  %w(Chet Vaisakh Jeth Harh Sawan Bhadon Asu Katik Maghar Poh Magh Phagun)
  MONTHS_PA = %w(ਚੇਤ ਵੈਸਾਖ ਜੇਠ ਹਾੜ ਸਾਵਣ ਭਾਦੋਂ ਅੱਸੂ ਕੱਤਕ ਮੱਘਰ ਪੋਹ ਮਾਘ ਫੱਗਣ)

  # #
  # Create a Nanakshahi date object.
  #   At rest store the dates both as:
  #     Gregorian - for calculations and time navigation
  #     Nanakshahi - for quick recall
  attr_reader :gregorian_date, :nanakshahi_date
  def initialize(year=1469, month=3, day=14)
    @gregorian_date = Date.new(year, month, day)
    @nanakshahi_date = self.class.to_nanakshahi(year, month, day)
  end

  # #
  # Gregorian to Nanakshahi date
  #
  def self.to_nanakshahi(gyear, gmonth, gday)
    # Start of time -  1 Chet, 1 Nanakshahi
    nanakshahi_epoch = Date.new(1469,3,14)
    gdate = Date.new(gyear, gmonth, gday)

    # Implement ਧੁੰਦਕਾਲ(Before Nanak - from Bhai Gurdas's vaar) later
    # Any date prior to nanakshahi_epoch returns nil for now
    return nil if gdate < nanakshahi_epoch

    # Before Chet 1, it is previous year in Nanakshahi
    if (gmonth <= nanakshahi_epoch.month) && (gday < nanakshahi_epoch.day)
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

    Ndate.new(nyear, nmonth, nday)
  end

  # #
  # Nanakshahi to Gregorian date
  #
  def self.to_gregorian(nyear, nmonth, nday)
  end
end