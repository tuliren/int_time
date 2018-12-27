class IntTime
  attr_reader :hour, :minute

  MAX_HOUR = 24
  MAX_MINUTE = 60

  def initialize(hour, minute)
    @hour = hour
    @minute = minute
  end

  def +(other)
    new_minute = @minute + other.minute
    new_hour = @hour + other.hour + new_minute / MAX_MINUTE
    IntTime.new(new_hour % MAX_HOUR, new_minute % MAX_MINUTE)
  end

  def add_minute(minute)
    new_minute = @minute + minute
    new_hour = @hour + new_minute / MAX_MINUTE
    IntTime.new(new_hour % MAX_HOUR, new_minute % MAX_MINUTE)
  end

  def add_hour(hour)
    new_hour = @hour + hour
    IntTime.new(new_hour % MAX_HOUR, @minute)
  end

  def to_i
    @hour * 100 + @minute
  end

  def to_s
    format('%02d:%02d', @hour, @minute)
  end

  def inspect
    "IntTime #{self}"
  end

  def self.valid?(number)
    number.is_a?(Integer) &&
        number >= 0
        valid_hour?(number % 10_000 / 100) &&
        valid_minute?(number % 100)
  end

  def self.from(number)
    raise "Input #{number} is not a valid int time" unless valid?(number)
    IntTime.new(number % 10_000 / 100 % MAX_HOUR, number % 100 % MAX_MINUTE)
  end

  def self.to_readable(number)
    from(number).to_s
  end

  def self.valid_hour?(number)
    number.is_a?(Integer) && number < MAX_HOUR && number >= 0
  end
  private_class_method :valid_hour?

  def self.valid_minute?(number)
    number.is_a?(Integer) && number < MAX_MINUTE && number >= 0
  end
  private_class_method :valid_minute?
end
