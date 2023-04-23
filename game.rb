# frozen_string_literal: true

require_relative 'bank'
require_relative 'cards'
require_relative 'player'
require_relative 'deler'
require_relative 'deck'

class Game
  def new_game
    create_bank
    add_player
    add_deler
    create_shuffle_deck
    deal_cards
    place_bets
  end

  def new_round
    puts 'new_round'
  end

  protected

  def create_bank
    @bank = Bank.new
  end

  def add_player
    puts 'Enter your name'
    name = gets.chomp
    @player = Player.new(name)
  end

  def add_deler
    @deler = Deler.new
  end

  def create_shuffle_deck
    @deck = Deck.new
    @deck.create
    @deck.shuffle
  end

  def deal_cards
    puts "DELER's cards:"
    puts ' *    *'
    @deler.deal_card(@deck.new_deck, 2)
    puts "#{@player.name}, your cards:"
    @player.deal_card(@deck.new_deck, 2)
    @player.show_cards
  end

  def place_bets
    @player.place_bet
    @deler.place_bet
    @bank.recieve_money
    puts "Now in bank #{@bank.money}"
  end
end

game = Game.new

menu_hash = [{ index: 1, title: 'New game', action: :new_game },
             { index: 2, title: 'New_round', action: :new_round }]
menu_hash.each.each { |item| puts "#{item[:index]} - #{item[:title]}" }

loop do
  mark = gets.to_i
  find_item = menu_hash.find { |item| item[:index] == mark }
  game.send(find_item[:action]) unless find_item.nil?
  break if mark.zero?
end
