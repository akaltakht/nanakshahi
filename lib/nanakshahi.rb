require 'nanakshahi/version'
require 'date'

# Nanakshahi Calendar based on research by Pal Singh Purewal
class Nanakshahi
  class Error < StandardError; end

  MONTHS =  %w(Chet Vaisakh Jeth Harh Sawan Bhadon Asu Katik Maghar Poh Magh Phagun)
  MONTHS_PA = %w(ਚੇਤ ਵੈਸਾਖ ਜੇਠ ਹਾੜ ਸਾਵਣ ਭਾਦੋਂ ਅੱਸੂ ਕੱਤਕ ਮੱਘਰ ਪੋਹ ਮਾਘ ਫੱਗਣ)
  
	GURPURBS = [
			chet: {
				'1': ['Nanakshahi New Year', 'Gurgaddi Guru Har Rai Sahib'],
				'6': ['Joti Jot Guru Hargobind Sahib']
			},
			vaisakh: {
				'1': ['Vaisakhi'],
				'3': ['Joti Jot Guru Angad Sahib', 'Gurgaddi Guru Amardas Sahib', 'Joti Jot Guru Harkrishan Sahib', 'Gurgaddi Guru Tegh Bahadur Sahib'],
				'5': ['Parkash Guru Angad Sahib', 'Parkash Guru Tegh Bahadur Sahib'],
				'19': ['Parkash Guru Arjan Sahib ']
			},
			jeth: {
				'9': ['Parkash Guru Amardas Sahib'],
				'28': ['Gurgaddi Guru Hargobind Sahib']
			},
			harh: {
				'2': ['Shaheedi Guru Arjan Sahib'],
				'18': ['Foundation Day Sri Akal Takht Sahib'],
				'21': ['Parkash Guru Hargobind Sahib']
			},
			sawan: {
				'6': ['Miri-Piri Day'],
				'8': ['Parkash Guru Harkrishan Sahib']
			},
			bhadon: {
				'15': ['Completion Guru Granth Sahib'],
				'17': ['First Parkash Guru Granth Sahib']
			},
			assu: {
				'2': ['Joti Jot Guru Amardas Sahib', 'Gurgaddi Guru Ramdas Sahib', 'Joti Jot Guru Ramdas Sahib', 'Gurgaddi Guru Arjan Sahib'],
				'4': ['Gurgaddi Guru Angad Sahib'],
				'8': ['Joti Jot Guru Nanak Sahib'],
				'25': ['Parkash Guru Ramdas Sahib']
			},
			katik: {
				'6': ['Joti Jot Guru Har Rai Sahib', 'Gurgaddi Guru Harkrishan Sahib', 'Gurgaddi Adi Guru Granth Sahib '],
				'7': ['Joti Jot Guru Gobind Singh Sahib']
			},
			maghar: {
				'11': ['Gurgaddi Guru Gobind Singh Sahib', 'Shaheedi Day Guru Tegh Bahadur Sahib']
			},
			poh: {
				'23': ['Parkash Guru Gobind Singh Sahib']
			},
			magh: {
				'19': ['Parkash Guru Har Rai Sahib']
			}
		]

  # #
  # Create a gregorian (CE) date object. 
  #   At rest store the dates as CE
  #   as the caculation becomes easier.
  def initialize(year=1469, month=3, day=14)  
    @date = Date.new(year,month, day)
  end

  def to_nanakshahi
    # 1 Chet, 1 Nanakshahi
    nanakshahi_epoch = Date.new(1469,3,14)
    # Before Chet 1, it is previous year in Nanakshahi
    if (@date.month < nanakshahi_epoch.month) && (@date.day < nanakshahi_epoch.day)
      year = nanakshahi_year(year - 1)
    else
      year = nanakshahi_year(year)
    end

    # #
    # The months follow the same index as MONTHS constant
    #   therefore although in Gregorian calendar Poh is first
    #   month of the nanakshahi year, it is at index 9
    #   sort of a merry-go-round.
    nanakshahi_months =  [
      (Date.new(year,3,14)..Date.new(year,4,13)),
      (Date.new(year,4,14)..Date.new(year,5,14)),
      (Date.new(year,5,15)..Date.new(year,6,14)),
      (Date.new(year,6,15)..Date.new(year,7,15)),
      (Date.new(year,7,16)..Date.new(year,8,15)),
      (Date.new(year,8,16)..Date.new(year,9,14)),
      (Date.new(year,9,15)..Date.new(year,10,14)),
      (Date.new(year,10,15)..Date.new(year,11,13)),
      (Date.new(year,11,14)..Date.new(year,12,13)),
      (Date.new(year-1,12,14)..Date.new(year,1,12)),
      (Date.new(year,1,13)..Date.new(year,2,11)),
      (Date.new(year,2,12)..Date.new(year,3,13))
    ]

    nanakshahi_months.each_with_index do |dates, index|
			if dates === @date
				day = dates.to_a.find_index(@date)
        month = index
        return {year: year, month: month, day: day}
			end
    end
    
  end

  private
  def nanakshahi_year(year)
    year - 1468
  end
  
end