require 'yaml'
class Crib
  include Cardable
  def self.build_expected_values
    expected_values = {}
    Card.deck.combination(2).each do |crib_cards|
      crib = Crib.new
      crib_cards.sort!
      crib.cards = crib_cards
      expected_values[crib.cards] = crib.expected_value
    end
    p expected_values
    File.open("expected_values.yml", "w") do |file|
        file.write expected_values.to_yaml
    end
  end
  def expected_value
    original_cards = self.cards
    possible_rest_of_hand = Card.deck - original_cards
    all_results = possible_rest_of_hand.combination(2).map do |rest_of_hand|
      self.cards = original_cards + rest_of_hand
      possible_starters = Card.deck - cards
      results = possible_starters.map do |starter|
        self.score(starter)
      end
      results.reduce(:+) / results.size.to_f
    end
    all_results.reduce(:+) / all_results.size.to_f
  end
end

