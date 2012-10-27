require 'ruby-prof'
require_relative '../test_helper'
class CribTest < Test::Unit::TestCase
# def test_expected_value
#   crib = Crib.from_array(["AD", "AC"])
#   crib.expected_value
# end
  def test_to_s
    crib = Crib.from_array(["JH", "2H"])
    assert_equal '[JH, 2H]', crib.to_s
  end
  def test_equality
    crib1 = Hand.from_array(["JH", "2H"])
    crib2 = Hand.from_array(["JH", "2H"])
    assert_equal crib1, crib2
  end
# def test_build_expected_values
#    Crib.build_expected_values
# end
end
