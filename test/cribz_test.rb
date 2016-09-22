require_relative 'test_helper'
class CribzTest < Test::Unit::TestCase
  def test_expected_values
    expected_values = Cribz.expected_values(["AH", "AS", "AD", "AC", "2H", "2S"])

    assert_equal 15, expected_values.size
    assert_equal Hand.from_array(["AH", "AS", "AD", "AC"]), expected_values.first.first
    assert_equal 12, expected_values.first[1]
  end
end
