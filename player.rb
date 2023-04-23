# frozen_string_literal: true

class Player
  attr_accessor :hand, :money, :name

  def initialize(name, money = 100)
    @name = name
    @hand = []
    @money = money
    @next_step = false
  end

  def show_cards
    @hand.each { |card| print "#{card.name}   " }
    puts ''
  end

  def deal_card(deck, num)
    num.times do
      choosen_card = deck.sample
      deck.delete(choosen_card)
      @hand << choosen_card
    end
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
