require 'cribz/card'
class Hand
  attr_accessor :cards
  def self.from_array(cards)
    hand = Hand.new
    hand.cards = cards.collect do |card|
      Card.new(card)
    end
    return hand
  end

  def score(starter)
    nob_points(starter) + pair_points(starter)
  end

  def nob_points(starter)
    if cards.any?{|card| card.rank == "J" && card.suit == starter.suit}
      1
    else
      0
    end
  end
  def pair_points(starter)
    points = hand_with(starter).combination(2).map do |pair|
      pair[0].rank == pair[1].rank ? 2 : 0
    end
    points.reduce(:+)
  end

  def fifteen_points(starter)
    points = all_combinations_of_hand_with(starter).map do |combo|
      total_value_of(combo) == 15 ? 2 : 0
    end
    points.reduce(:+)
  end
private
  def hand_with(starter)
    cards + [starter]
  end
  def all_combinations_of_hand_with(starter)
    combinations = (2..5).map do |number_of_cards|
      hand_with(starter).combination(number_of_cards).to_a 
    end
    combinations.reduce(:+)
  end
  def total_value_of(combo)
    total = combo.inject(0) do |memo, card|
      memo + card.value
    end
  end
end
