require_relative 'cribz/hand'
require_relative 'cribz/crib'
class Cribz
  def self.expected_values(cards)
    cards.combination(4).map do |potential_hand|
      other_cards = cards - potential_hand
      hand = Hand.from_array(potential_hand)
      crib = Crib.from_array(other_cards)
      [hand, hand.expected_value(other_cards), crib.expected_value]
    end
  end
end
