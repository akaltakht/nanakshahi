# Nanakshahi

Nanakshahi is a ruby gem for Nanakshahi Calendar based on the [original work](http://www.purewal.biz/Gurbani_and_Nanakshahi_Calendar.pdf) by [Pal Singh Purewal](http://purewal.biz/).

It provides helper methods to convert a Gregorian or Common Era(CE) date into Nanakshahi date and vice versa.

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

For a complete list of all the methods, check out the documentation.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/punjab/nanakshahi.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
