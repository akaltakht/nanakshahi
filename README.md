# ਨਾਨਕਸ਼ਾਹੀ (Nanakshahi)

ਨਾਨਕਸ਼ਾਹੀ ਇੱਕ ਰੂਬੀ ਪਰੋਗਰਾਮਿੰਗ ਭਾਸ਼ਾ ਚ ਲਿਖਿਆ ਗਿਆ gem ਹੈ ਜੋ ਕਿ [ਪਾਲ ਸਿੰਘ ਪੁਰੇਵਾਲ](http://purewal.biz/) ਦੁਆਰਾ ਲਿਖੇ ਗਏ [ਮੂਲ ਨਾਨਕਸ਼ਾਹੀ ਕਲੰਡਰ]((http://www.purewal.biz/Gurbani_and_Nanakshahi_Calendar.pdf) ਤੇ ਅਧਾਰਿਤ ਹੈ।

ਇਹ ਆਮ/ਗਰਿਗੋਰੀਅਨ ਕਲੰਡਰ ਦੀਆਂ ਤਰੀਕਾਂ ਤੋਂ ਨਾਨਕਸ਼ਾਹੀ ਤੇ ਵਾਪਸ ਬਦਲਣ ਦੇ ਤਰੀਕੇ ਮੁਹੱੲੀਆ ਕਰਵਾਉਂਦਾ ਹੈ। ਤੁਸੀਂ ਇਸ ਨੂੰ ਕਿਸੇ ਵੀ ਰੂਬੀ ਪਰੋਗਰਾਮ ਵਿੱਚ ਨਾਨਕਸ਼ਾਹੀ ਤਰੀਕਾਂ ਵਰਤਣ ਲੲੀ ਵਰਤ ਸਕਦੇ ਹੋ।

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
date = Nanakshahi.new(550)
date = Nanakshahi.new(550, 10)
date = Nanakshahi.new(550, 10, 5)
```

### Using common calendar/gregorian date

```ruby
date = Nanakshahi.from_gregorian(2019,1,8)
```

### Nanakshahi date today

```ruby
date = Nanakshahi.today
```

### Converting date object to Nanakshahi

Nankshahi gem monkey-patches `Date` class to provide it `to_nanakshahi` method

```ruby
date = Date.new(2019-2-18)
p date.to_nanakshahi
```

### Printing Nanakshahi date

`to_s` method prints Nanakshahi date either Nanakshahi or Dhundkaal suffix (pre-Guru Nanak). To take care of 0 year correction, like gregorian, it is assumed that 1 Dhundkaal precedes 1 Nanakshahi when printed with suffix.

```ruby
date = Nanakshahi.new(1400-2-18)
puts date
```

### To Gurmukhi

`to_gurmukhi` prints the date in Gurmukhi characters, complete with Gurmukhi numerals.

```ruby
date = Nanakshahi.new(1400-2-18)
puts date.to_gurmukhi
```

For a complete list of all the methods, check out the documentation.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/punjab/nanakshahi.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
