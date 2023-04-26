# frozen_string_literal: true

class Player
  attr_accessor :hand, :money, :name, :turn, :sum_hand, :has_A

  def initialize(name, money = 100)
    @name = name
    @hand = []
    @money = money
    @turn = false
    @ace = false
    @sum_hand = 0
  end

  def show_cards
    @hand.each { |card| print "#{card.name}   " }
    print "  - #{@sum_hand}  points\n\n"
  end

  def deal_card(deck, num)
    num.times do
      card_hand = deck.sample
      deck.delete(card_hand)
      has_Ace(card_hand)
      @sum_hand += card_hand.value
      @hand << card_hand
    end
  end

  def has_Ace(card)
    return unless card.name.include?('A')

    if @ace == false && @sum_hand < 11
      card.value = 11
      @ace = true
    else
      card.value = 1
    end
  end

  def skip
    @turn = true
  end

  def calculate_money
    puts "#{@name}'s amount - #{@money}$"
  end

  def place_bet
    if @money >= 10
      @money -= 10
    else
      puts "Oops #{@name} hasn't enaugh money!"
    end
  end
end
