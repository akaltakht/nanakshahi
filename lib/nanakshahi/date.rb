# Monkey Patch Ruby Date object
class Date
  def to_nanakshahi
    Nanakshahi.from_gregorian(self.year, self.mon, self.day)
  end
end
