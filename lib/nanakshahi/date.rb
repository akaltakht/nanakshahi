# Monkey Patch Ruby Date object
#
class Date
  # Adds conversion of date object to Nanakshahi in Ruby Date class
  #
  # @return [Nanakshahi] returns corresponding Nanakshahi date object after conversion
  def to_nanakshahi
    Nanakshahi.from_gregorian(self.year, self.mon, self.day)
  end
end
