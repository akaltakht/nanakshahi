# Nanakshahi date class
class Ndate
    class Error < StandardError; end

    attr_reader :day, :month, :year
    def initialize(year, month, day)
        @day = day
        @month = month
        @year = year
    end

    # #
    # For testing equality of two Ndate objects
    def ==(other)
        self.day == other.day && self.month == other.month && self.year == other.year
    end
end