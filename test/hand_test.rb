require_relative 'test_helper'
class HandTest < Test::Unit::TestCase
  def test_expected_value
    hand = Hand.from_array(["AD", "AC", "AH", "AS"])
    assert_equal 12, hand.expected_value
  end
  def test_expected_value_with_seen_cards
    hand = Hand.from_array(["KD", "KC", "KH", "KS"])
    seen_cards = ["5D", "5C", "5H", "5S"]
    assert_equal 12, hand.expected_value(seen_cards)
  end
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

  def test_score_double_run
    hand = Hand.from_array(["8S", "9S", "9H", "10H"])
    starter = Card.new("4S")
    assert_equal 8, hand.score(starter)
  end

  def test_score_royal_flush
    hand = Hand.from_array(["10S", "JS", "QS", "KS"])
    starter = Card.new("AS")
    assert_equal 10, hand.score(starter)
  end

  def test_score_29
    hand = Hand.from_array(["5D", "5C", "5H", "JS"])
    starter = Card.new("5S")
    assert_equal 29, hand.score(starter)
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

  def test_fifteen_points_can_use_5_cards
    hand = Hand.from_array(["AS", "2S", "4H", "5H"])
    starter = Card.new("3S")
    assert_equal 2, hand.fifteen_points(starter)
  end

  def test_fifteen_points_uses_starter
    hand = Hand.from_array(["4S", "8S", "9H", "10H"])
    starter = Card.new("5S")
    assert_equal 2, hand.fifteen_points(starter)
  end

  def test_run_points_with_5_cards
    hand = Hand.from_array(["AS", "2S", "4H", "5H"])
    starter = Card.new("3S")
    assert_equal 5, hand.run_points(starter)
  end

  def test_run_points_with_4_cards
    hand = Hand.from_array(["JS", "2S", "4H", "5H"])
    starter = Card.new("3S")
    assert_equal 4, hand.run_points(starter)
  end

  def test_run_points_with_3_card_double_run
    hand = Hand.from_array(["JS", "2S", "4H", "4S"])
    starter = Card.new("3S")
    assert_equal 6, hand.run_points(starter)
  end

  def test_run_points_without_run
    hand = Hand.from_array(["JS", "2S", "8H", "9H"])
    starter = Card.new("QS")
    assert_equal 0, hand.run_points(starter)
  end

  def test_flush_points_without
    hand = Hand.from_array(["JS", "2H", "8H", "9H"])
    starter = Card.new("QH")
    assert_equal 0, hand.flush_points(starter)
  end
  def test_flush_points
    hand = Hand.from_array(["JH", "2H", "8H", "9H"])
    starter = Card.new("QS")
    assert_equal 4, hand.flush_points(starter)
  end
  def test_to_s
    hand = Hand.from_array(["JH", "2H", "8H", "9H"])
    assert_equal '[JH, 2H, 8H, 9H]', hand.to_s
  end
  def test_equality
    hand1 = Hand.from_array(["JH", "2H", "8H", "9H"])
    hand2 = Hand.from_array(["JH", "2H", "8H", "9H"])
    assert_equal hand1, hand2
  end
end
