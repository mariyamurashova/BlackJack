# frozen_string_literal: true

class Deck
  attr_accessor :names, :new_deck

  def initialize
    @cards_names = ['2♣', '2♦', '2♥', '2♣', '3♣', '3♦', '3♥', '3♣', '4♣', '4♦', '4♥', '4♣', 
                    '5♣', '5♦', '5♥', '5♣', '6♣', '6♦', '6♥', '6♣', '7♣', '7♦', '7♥', '7♣', 
                    '8♣', '8♦', '8♥', '8^', '9♣', '9♦', '9♥', '9♣', '10♣', '10♦', '10♥', '10^',
                    'J♣', 'J♦', 'J♥', 'J^', 'Q♣', 'Q♦', 'Q♥', 'Q♣', 'K♣', 'K♦', 'K♥', 'K♣',
                    'A♣','A♦', 'A♥', 'A♣']
    @new_deck = []
  end

  def create
    @cards_names.each do |name|
      name_letter = name.split
      card_value = name_letter[0].to_i.zero? ? 10 : name_letter[0].to_i
      card_value = 11 if name_letter[0].include?('A')
      card = Card.new(name, card_value)
      @new_deck << card
    end
  end

  def shuffle
    @new_deck = @new_deck.shuffle
  end
end
