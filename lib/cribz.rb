require_relative 'cribz/hand'
class Cribz
  def self.expected_values(cards)
    cards.combination(4).map do |potential_hand|
      hand = Hand.from_array(potential_hand)
      [hand, hand.expected_value(cards - potential_hand)]
    end
  end
end
