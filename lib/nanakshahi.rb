require 'nanakshahi/version'
require 'date'

# Nanakshahi Calendar based on research by Pal Singh Purewal
class Nanakshahi
  class Error < StandardError; end

  MONTHS =  %w(Chet Vaisakh Jeth Harh Sawan Bhadon Asu Katik Maghar Poh Magh Phagun)
  MONTHS_PA = %w(ਚੇਤ ਵੈਸਾਖ ਜੇਠ ਹਾੜ ਸਾਵਣ ਭਾਦੋਂ ਅੱਸੂ ਕੱਤਕ ਮੱਘਰ ਪੋਹ ਮਾਘ ਫੱਗਣ)

  # #
  # Create a Nanakshahi date object. 
  #   At rest store the dates as CE
  #   as the caculation becomes easier.
  attr_reader :gregorian_date, :nanakshahi_date
  def initialize(year=1469, month=3, day=14)
    @gregorian_date = Date.new(year,month,day)
    @nanakshahi_date = self.class.to_nanakshahi(@gdate)
  end

  # #
  # Gregorian to Nanakshahi date 
  #   
  def self.to_nanakshahi(gdate)
  end

  # #
  # Nanakshahi to Gregorian date 
  #   
  def self.to_gregorian(ndate)
  end
end