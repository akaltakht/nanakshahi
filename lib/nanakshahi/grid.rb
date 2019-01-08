module Grid
  # Class method that return a date grid
  def date_grid(gyear)
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
end
