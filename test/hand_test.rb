require_relative 'test_helper'
class HandTest < Test::Unit::TestCase
  def test_score_19
    hand = Hand.from_array(["8S", "9S", "JH", "QH"])
    starter = Card.new("4S")
    assert_equal 0, hand.score(starter)
  end
  def test_score_doesnt_modify_cards
    hand = Hand.from_array(["8S", "9S", "JH", "QH"])
    expected_hand = hand.cards.dup
    starter = Card.new("4H")
    hand.score(starter)
    assert_equal expected_hand, hand.cards
  end
  def test_score_nobs
    hand = Hand.from_array(["8S", "9S", "JH", "QH"])
    starter = Card.new("4H")
    assert_equal 1, hand.score(starter)
  end
  def test_score_pairs
    hand = Hand.from_array(["8S", "9S", "9H", "QH"])
    starter = Card.new("4S")
    assert_equal 2, hand.score(starter)
  end

  def test_pair_points
    hand = Hand.from_array(["9C", "9S", "9H", "QH"])
    starter = Card.new("4S")
    assert_equal 6, hand.pair_points(starter)
  end

  def test_pair_points_uses_starter
    hand = Hand.from_array(["4C", "9S", "9H", "QH"])
    starter = Card.new("4S")
    assert_equal 4, hand.pair_points(starter)
  end

  def test_fifteen_points
    hand = Hand.from_array(["5S", "8S", "9H", "10H"])
    starter = Card.new("4S")
    assert_equal 2, hand.fifteen_points(starter)
  end

  def test_fifteen_points_can_use_3_cards
    hand = Hand.from_array(["4S", "8S", "9H", "10H"])
    starter = Card.new("3S")
    assert_equal 2, hand.fifteen_points(starter)
  end

  def test_fifteen_points_can_use_4_cards
    hand = Hand.from_array(["AS", "2S", "5H", "7H"])
    starter = Card.new("4S")
    assert_equal 2, hand.fifteen_points(starter)
  end

  def test_fifteen_points_uses_starter
    hand = Hand.from_array(["4S", "8S", "9H", "10H"])
    starter = Card.new("5S")
    assert_equal 2, hand.fifteen_points(starter)
  end
end
