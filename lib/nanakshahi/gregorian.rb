require "date"

module Gregorian
  # #
  # classs method Gregorian to Nanakshahi date
  # returns a Nanakshahi date object
  def from_gregorian(gyear, gmonth, gday)
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
end
