require_relative 'card'
class Hand
  attr_accessor :cards
  def self.from_array(cards)
    hand = Hand.new
    hand.cards = build_card_array(cards)
    return hand
  end
  def self.build_card_array(cards)
    cards.collect do |card|
      Card.new(card)
    end
  end
  def to_s
    "[#{cards.join ', '}]"
  end
  def ==(other)
    self.cards == other.cards
  end

  def expected_value(seen_cards = [])
    seen_cards = Hand.build_card_array(seen_cards)
    possible_starters = Card.deck - cards - seen_cards
    results = possible_starters.map do |starter|
      self.score(starter)
    end
    results.reduce(:+) / results.size.to_f
  end

  def score(starter)
    nob_points(starter) + pair_points(starter) + run_points(starter) + fifteen_points(starter) + flush_points(starter)
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

  def run_points(starter)
    [5,4,3].each do |number_of_cards|
      points = hand_with(starter).combination(number_of_cards).map do |combo|
        run?(combo) ? combo.size : 0
      end
      total_points = points.reduce(:+)
      return total_points if total_points > 0
    end
    return 0
  end
  
  def flush_points(starter)
    if same_values_in(hand_with(starter).map{|card|card.suit}) 
      5
    elsif same_values_in(cards.map{|card|card.suit})
      4
    else
      0
    end
  end

private

  def run?(combo)
    indexes = combo.sort{|a,b| b<=>a }.each_with_index.collect do |card, index|
      card.index + index
    end
    same_values_in(indexes)
  end

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
    combo.inject(0) do |memo, card|
      memo + card.value
    end
  end

  def same_values_in(array)
    array.uniq.size == 1
  end
end
