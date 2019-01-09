require "date"

module Utils
  NANAKSHAHI_EPOCH_IN_GREGORIAN = Date.new(1469, 3, 14)
  # #
  # classs method Gregorian to Nanakshahi date
  # returns a Nanakshahi date object
  def from_gregorian(gyear, gmonth, gday)
    # Start of time -  1 Chet, 1 Nanakshahi
    gdate = Date.new(gyear, gmonth, gday)

    # Before Chet 1, it is previous year in Nanakshahi
    if (gmonth <= NANAKSHAHI_EPOCH_IN_GREGORIAN.month) && (gday < NANAKSHAHI_EPOCH_IN_GREGORIAN.day)
      nyear = gyear - NANAKSHAHI_EPOCH_IN_GREGORIAN.year
    else
      nyear = gyear - (NANAKSHAHI_EPOCH_IN_GREGORIAN.year - 1)
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
