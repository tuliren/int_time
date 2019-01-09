class IntTime
  attr_reader :hour, :minute

  MAX_HOUR = 24
  MAX_MINUTE = 60
  TIME_PATTERN = /(\d{2}):(\d{2})/

  def initialize(hour, minute)
    @hour = hour
    @minute = minute
  end


  ##########################
  ##   Instance Methods   ##
  ##########################

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


  #######################
  ##   Class Methods   ##
  #######################

  def self.valid?(number)
    number.is_a?(Integer) &&
      number >= 0 &&
      valid_hour?(number % 10_000 / 100) &&
      valid_minute?(number % 100)
  end

  def self.from(token)
    if token.class <= Integer
      from_int(token)
    elsif token.class <= String
      from_str(token)
    elsif token.class <= Time
      from_time(token)
    else
      raise "Invalid input: #{token}; expect integer or string"
    end
  end

  def self.from_int(time)
    raise "Input #{time} is not a valid int time" unless valid?(time)
    IntTime.new(time % 10_000 / 100 % MAX_HOUR, time % 100 % MAX_MINUTE)
  end
  private_class_method :from_int

  def self.from_str(time)
    match = TIME_PATTERN.match(time)
    if match.nil? || match.size != 3
      raise "Input #{time} is not a valid string time"
    end
    IntTime.new(match[1].to_i, match[2].to_i)
  end
  private_class_method :from_str

  def self.from_time(time)
    IntTime.new(time.hour, time.min)
  end
  private_class_method :from_time

  def self.to_str(time)
    from(time).to_s
  end

  def self.to_int(time)
    from(time).to_i
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
