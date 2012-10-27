class Card
  attr_reader :rank, :suit
  RANKS = ['A','2','3','4','5','6','7','8','9','10','J','Q','K']
  SUITS = ['C','D','H','S']
  def initialize(rank_and_suit)
    rank_and_suit_matcher = rank_and_suit.match(/^(10|\d|[JQKA])([CDHS])/)
    raise ArgumentError, "Not a valid card" if rank_and_suit_matcher.nil? 
    @rank, @suit = rank_and_suit_matcher[1,2]
  end
  def value
    @value ||= [self.index,10].min
     #case self.rank
     #         when "A" then 1
     #         when "J","Q","K" then 10
     #         else
     #           self.rank.to_i
     #         end
  end
  def <=>(other)
    if self.index > other.index
      1
    elsif self.index < other.index
      -1
    else
      SUITS.index(self.suit) <=> SUITS.index(other.suit)
    end
  end
  def index
    @index ||= case self.rank
               when "A" then 1
               when "J" then 11
               when "Q" then 12
               when "K" then 13
               else 
                 self.rank.to_i
               end
  end
  def to_s
    @to_s ||= self.rank + self.suit
  end
  def ==(other)
    self.rank == other.rank && self.suit == other.suit
  end
  def Card.deck
    @deck ||= RANKS.map do |rank|
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
