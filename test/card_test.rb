require_relative 'test_helper'
class CardTest < Test::Unit::TestCase
  def test_new_card
    card = Card.new("AH")
    assert_equal "A", card.rank
    assert_equal "H", card.suit
  end
  def test_good_cards
    assert_good_card("AH")
    assert_good_card("10C")
    assert_good_card("8S")
    assert_good_card("QD")
  end
  def test_bad_cards
    assert_bad_card("11C")
    assert_bad_card("BH")
    assert_bad_card("AJ")
  end
  def test_10
    card = Card.new("10H")
    assert_equal "10", card.rank
    assert_equal "H", card.suit
  end
  def test_A_value
    card = Card.new("AH")
    assert_equal 1, card.value
  end
  def test_2_value
    card = Card.new("2H")
    assert_equal 2, card.value
  end
  def test_J_value
    card = Card.new("JH")
    assert_equal 10, card.value
  end
  def test_spaceship
    card1 = Card.new("AH") 
    card2 = Card.new("2H") 
    card3 = Card.new("JH") 
    card4 = Card.new("JS") 
    assert_equal -1, card1 <=> card2
    assert_equal 1, card2 <=> card1
    assert_equal 0, card3 <=> card4
  end
  def test_index
    assert_equal 1, Card.new("AH").index
    assert_equal 2, Card.new("2H").index
    assert_equal 11, Card.new("JH").index
    assert_equal 11, Card.new("JS").index
  end 

private

  def assert_good_card(card)
    assert_nothing_raised ArgumentError do
      card = Card.new(card)
    end
  end
  def assert_bad_card(card)
    assert_raise ArgumentError do
      card = Card.new(card)
    end
  end

end

