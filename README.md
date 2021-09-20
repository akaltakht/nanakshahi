ਨਾਨਕਸ਼ਾਹੀ (Nanakshahi)[![Gem Version](https://badge.fury.io/rb/nanakshahi.svg)](https://badge.fury.io/rb/nanakshahi)  ![Build Status](https://github.com/akaltakht/nanakshahi/actions/workflows/gempush.yml/badge.svg)
========

ਨਾਨਕਸ਼ਾਹੀ ਇੱਕ ਰੂਬੀ ਪਰੋਗਰਾਮਿੰਗ ਭਾਸ਼ਾ ਚ ਲਿਖਿਆ ਗਿਆ gem ਹੈ ਜੋ ਕਿ [ਪਾਲ ਸਿੰਘ ਪੁਰੇਵਾਲ](http://purewal.biz/) ਦੁਆਰਾ ਲਿਖੇ ਗਏ [ਮੂਲ ਨਾਨਕਸ਼ਾਹੀ ਕਲੰਡਰ](http://www.purewal.biz/Gurbani_and_Nanakshahi_Calendar.pdf) ਤੇ ਅਧਾਰਿਤ ਹੈ।

ਇਹ ਆਮ/ਗਰਿਗੋਰੀਅਨ ਕਲੰਡਰ ਦੀਆਂ ਤਰੀਕਾਂ ਤੋਂ ਨਾਨਕਸ਼ਾਹੀ ਤੇ ਵਾਪਸ ਬਦਲਣ ਦੇ ਤਰੀਕੇ ਮੁਹੱਈਆ ਕਰਵਾਉਂਦਾ ਹੈ। ਤੁਸੀਂ ਇਸ ਨੂੰ ਕਿਸੇ ਵੀ ਰੂਬੀ ਪਰੋਗਰਾਮ ਵਿੱਚ ਨਾਨਕਸ਼ਾਹੀ ਤਰੀਕਾਂ ਵਰਤਣ ਲਈ ਵਰਤ ਸਕਦੇ ਹੋ।

Nanakshahi is a ruby gem for Nanakshahi Calendar based on the [original work](http://www.purewal.biz/Gurbani_and_Nanakshahi_Calendar.pdf) by [Pal Singh Purewal](http://purewal.biz/).

It provides helper methods to convert a Gregorian or Common Era(CE) date into Nanakshahi date and vice versa. You can use it to enable Nankshahi dates in any of your applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nanakshahi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nanakshahi

## Usage

To start using Nanakshahi gem

```ruby
require 'nanakshahi'
```

### Create a Nanakshahi date object

```ruby
date = Nanakshahi.new # Creates an object with 1 Chet, Nanakshahi
date = Nanakshahi.new(553)
date = Nanakshahi.new(553, 7)
date = Nanakshahi.new(550, 7, 6)
date = Nanakshahi.today
```

### Using common calendar/gregorian date

```ruby
date = Nanakshahi.from_gregorian(2021,9,21)
=> #<Nanakshahi:0x00007fbec18410e8 @day=7, @month=7, @year=553>
ndate = date.to_gregorian
=> #<Date: 2021-09-21 ((2459479j,0s,0n),+0s,2299161j)>
```

### Is it a gurpurab?

```ruby
Nanakshahi.new(550,1,1).gurpurab?
```

### What Gurpurabs fall on this day?

```ruby
Nanakshahi.new(550,1,1).gurpurabs
```

### Converting date object to Nanakshahi

Nankshahi gem monkey-patches `Date` class to provide it `to_nanakshahi` method

```ruby
date = Date.new(2019-2-18)
p date.to_nanakshahi
```

### Printing Nanakshahi date

#### Roman

`to_s` method prints Nanakshahi date either Nanakshahi or Dhundkaal suffix (pre-Guru Nanak). To take care of 0 year correction, like gregorian, it is assumed that 1 Dhundkaal precedes 1 Nanakshahi when printed with suffix.

```ruby
date = Nanakshahi.new(1400-2-18)
puts date
```

#### Gurmukhi

`to_gurmukhi` prints the date in Gurmukhi characters, complete with Gurmukhi numerals.

```ruby
date = Nanakshahi.new(1400-2-18)
puts date.to_gurmukhi
```

#### Shahmukhi

`to_shahmukhi` prints the date in Shahmukhi characters, complete with Shahmukhi numerals.

```ruby
date = Nanakshahi.today
puts date.to_shahmukhi
```

### Recommendations
The following was not part of the seminal work by Pal Singh Purewal, but constituted part of recommendations in our paper [Building an Open-Source Nanakshahi Calendar: Identity and a Spiritual and Computational Journey(Singh et al., 2020)](https://sikhresearchjournal.org/building-an-open-source-nanakshahi-calendar-identity-and-a-spiritual-and-computational-journey-by-arvinder-singh-amandeep-singh-amarpreet-singh-harvinder-singh-parm-singh/)

### Dhundkaal - The era of the fog

```ruby
date = Nanakshahi.from_gregorian(1468,1,1)
date.to_s
=> "19 Poh, 2 Dhundkaal"
```

For a complete list of all the methods, check out [the documentation](https://www.rubydoc.info/gems/nanakshahi).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/akaltakht/nanakshahi.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
