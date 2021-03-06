Int Time
====

[![Build Status](https://github.com/tuliren/int_time/workflows/build/badge.svg)](https://github.com/tuliren/int_time/actions)
[![Gem Version](https://badge.fury.io/rb/int_time.svg)](https://badge.fury.io/rb/int_time)

## Overview
This gem provides a value class, `IntTime`, that represents a 24-hour format time.

## Installation
```Gemfile
gem 'int_time'
```

## Examples

### Load `IntTime`
```ruby
require 'int_time'
```

### Create an `IntTime` object
```ruby
# from integer
IntTime.from(1435)
# => #<IntTime @hour=14, @minute=35>

# from string
IntTime.from("14:35")
# => #<IntTime @hour=14, @minute=35>
```

### Convert between integer and string
```ruby
IntTime.to_str(1435)
# => 14:35

IntTime.to_int("14:35")
# => 1435
```
