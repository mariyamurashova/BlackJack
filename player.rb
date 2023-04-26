# frozen_string_literal: true

class Player
  attr_accessor :hand, :money, :name, :turn, :sum_hand, :has_A

  def initialize(name, money = 100)
    @name = name
    @hand = []
    @money = money
    @turn = false
    @has_A = false
    @sum_hand = 0
  end

  def show_cards
    @hand.each { |card| print "#{card.name}   " }
    # calculate_amount
    print "  #{@name},you have  #{@sum_hand}  points"
    puts ''
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

    if @has_A == false && @sum_hand < 11
      card.value = 11
      @has_A = true
    else
      card.value = 1
    end
  end

  def calculate_amount
    @hand.each { |card| @sum_hand += card.value }
    print "  #{@name},you have  #{@sum_hand}  points"
  end

  def skip
    @turn = true
  end

  def calculate_money
    puts "#{@name} amount - #{@money}$"
  end

  def place_bet
    if @money >= 10
      @money -= 10
    else
      puts "Oops #{@name} hasn't enaugh money!"
    end
  end
end
