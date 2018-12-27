require 'minitest/autorun'
require 'int_time'

class IntTimeTest < Minitest::Test
  RANDOM = Random.new

  def test_valid?
    refute IntTime.valid?(-1)
    refute IntTime.valid?(concat_number(10, 60)) # invalid minute
    refute IntTime.valid?(concat_number(24, 30)) # invalid hour

    assert IntTime.valid?(concat_number(0, 0))
    assert IntTime.valid?(concat_number(10, 30))
    assert IntTime.valid?(concat_number(23, 59))
  end

  def test_from
    hour = RANDOM.rand(24)
    minute = RANDOM.rand(60)
    int_time = IntTime.from(concat_number(hour, minute))
    assert_equal hour, int_time.hour
    assert_equal minute, int_time.minute

    str_time = IntTime.from(format('%02d:%02d', hour, minute))
    assert_equal hour, str_time.hour
    assert_equal minute, str_time.minute
  end

  def test_to_readable
    assert_equal "12:34", IntTime.to_readable(concat_number(12, 34))
  end

  def test_valid_hour?
    refute IntTime.send(:valid_hour?, -1)
    refute IntTime.send(:valid_hour?, 24)

    10.times do
      assert IntTime.send(:valid_hour?, RANDOM.rand(24))
    end
  end

  def test_valid_minute?
    refute IntTime.send(:valid_minute?, -1)
    refute IntTime.send(:valid_minute?, 60)

    10.times do
      assert IntTime.send(:valid_minute?, RANDOM.rand(60))
    end
  end

  private

  def concat_number(num1, num2)
    num1 * 100 + num2
  end
end
