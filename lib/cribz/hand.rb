require_relative 'card'
require_relative 'scorable'
class Hand
  include Scorable

  def expected_value(seen_cards = [])
    seen_cards = Hand.build_card_array(seen_cards)
    possible_starters = Card.deck - cards - seen_cards
    results = possible_starters.map do |starter|
      self.score(starter)
    end
    results.reduce(:+) / results.size.to_f
  end
end
