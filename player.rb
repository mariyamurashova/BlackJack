# frozen_string_literal: true

class Player
  attr_accessor :hand, :money, :name, :turn, :sum_hand, :has_A

  def initialize(name, money = 100)
    @name = name
    @hand = []
    @money = money
    @turn = false
    @has_A = false
  end

  def show_cards
    @hand.each { |card| print "#{card.name}   " }
    puts ''
  end

  def deal_card(deck, num)
    num.times do
      card_hand = deck.sample
      deck.delete(card_hand)
      has_Ace(card_hand)
      @hand << card_hand
    end
  end

  def has_Ace(card)
    return unless card.name.include?('A')

    if @has_A == false
      card.value = 11
      @has_A = true
    else
      card.value = 1
    end
  end

  def calculate_amount
    @sum_hand = 0
    @hand.each { |card| @sum_hand += card.value }
    puts "#{name} your sum is #{@sum_hand}"
  end

  def skip
    @turn = true
  end

  def current_amount
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
