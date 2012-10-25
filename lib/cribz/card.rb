class Card
  attr_reader :rank, :suit
  RANKS = ['A','2','3','4','5','6','7','8','9','10','J','Q','K']
  SUITS = ['D','C','H','S']
  def initialize(rank_and_suit)
    rank_and_suit_matcher = rank_and_suit.match(/^(10|\d|[JQKA])([DCHS])/)
    raise ArgumentError, "Not a valid card" if rank_and_suit_matcher.nil? 
    @rank, @suit = rank_and_suit_matcher[1,2]
  end
  def value
    [self.index, 10].min
  end
  def <=>(other)
    self.index <=> other.index
  end
  def index
    RANKS.index(self.rank) + 1
  end
  def to_s
    self.rank + self.suit
  end
  def ==(other)
    self.rank == other.rank && self.suit == other.suit
  end
  def Card.deck
    RANKS.map do |rank|
      SUITS.map do |suit|
        Card.new(rank + suit)
      end
    end.flatten
  end
  def hash
    (rank+suit).hash
  end
  def eql?(other)
    self == other
  end
end
