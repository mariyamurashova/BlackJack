# frozen_string_literal: true

require_relative 'bank'
require_relative 'cards'
require_relative 'player'
require_relative 'deler'
require_relative 'deck'
#require 'pry'


class Game
  def new_game
    create_bank
    add_player
    add_deler
    create_shuffle_deck
    deal_cards
    place_bets
    choose_next_step
    take_decision
    who_is_winner
    @player.calculate_money
    @deler.calculate_money
    next_step_menu

      end

  def new_round
    @player.sum_hand = 0
    @deler.sum_hand = 0
    @player.hand = []
    @deler.hand = []
    @player.has_A = false
    @deler.has_A = false
    create_shuffle_deck
    deal_cards
    place_bets
    choose_next_step
    take_decision
    who_is_winner
    @player.calculate_money
    @deler.calculate_money
    next_step_menu
    puts 'new_round'
  end

  def who_is_winner
    if draw? 
      halve_money
      puts "It's DRAW"
    else 
      if player_winner? 
        gives_money_winner(@player)
        puts "#{@player.name} You are the WINNER\n\n"
      else 
        gives_money_winner(@deler)
        puts"#{@player.name} You LOSE\n\n"
      end
    end
  end

   def gives_money_winner(player)
    player.money += @bank.money
    @bank.money = 0
   end

   def halve_money
    @player.money += 10
    @deler.money += 10
    @bank.money = 0
   end


  def draw?
      @player.sum_hand - @deler.sum_hand == 0   
  end

  def player_winner?
    (@player.sum_hand == 21 &&  @deler.sum_hand !=21) ||
    (@player.sum_hand < 21 &&  @deler.sum_hand > 21) ||
    (@player.sum_hand - @deler.sum_hand > 0 &&  @player.sum_hand < 21) ||
    (@player.sum_hand - @deler.sum_hand < 0 &&  @player.sum_hand > 21) 
end
   
  protected

     def difference_21?
      @player.sum_hand - 21 > @deler.sum_hand-21
    end


  def take_decision
    if @deler.sum_hand < 17
      @deler.deal_card(@deck.new_deck, 1)
    else
      @deler.skip
    end
    @deler.show_cards
   
  end

  def create_bank
    @bank = Bank.new
  end

  def add_player
    puts "Enter your name"
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
    # puts ' *    *'
    @deler.deal_card(@deck.new_deck, 2)
    @deler.show_cards
    puts "#{@player.name}, your cards:\n\n"
    @player.deal_card(@deck.new_deck, 2)
    @player.show_cards
  end

  def add_card(player = @player)
    player.deal_card(@deck.new_deck, 1)
    player.show_cards
  end

  def place_bets
    @player.place_bet
    @deler.place_bet
    @bank.recieve_money
    puts "Now in bank #{@bank.money}"
  end

  def skip_turn(player = @player)
    player.skip
  end

  def quit
    puts 'GoodBye!'
    exit(0)
  end

  def next_step_menu
    #loop do
    menu_hash = [{ index: 1, title: 'New_round', action: :new_round },
                 { index: 2, title: 'Finish the Game and exit', action: :quit}]
    menu_hash.each.each { |item| puts "#{item[:index]} - #{item[:title]}" }
    mark = gets.to_i
    #break if mark.zero?
    find_item = menu_hash.find { |item| item[:index] == mark }
    send(find_item[:action]) unless find_item.nil?
  #end
  end

  def choose_next_step

    menu_hash = [{ index: 1, title: 'Skip_turn', action: :skip_turn },
                 { index: 2, title: 'Take 3-d card', action: :add_card }]
    menu_hash.each.each { |item| puts "#{item[:index]} - #{item[:title]}" }
    mark = gets.to_i
    find_item = menu_hash.find { |item| item[:index] == mark }
    send(find_item[:action]) unless find_item.nil?
  end
end

game = Game.new


#loop do
menu_hash = [{ index: 1, title: 'New game', action: :new_game},
             {index: 0, title: 'EXIT', action: :quit}]
menu_hash.each.each { |item| puts "#{item[:index]} - #{item[:title]}" }

mark = gets.to_i
#break if mark.zero?
    find_item = menu_hash.find { |item| item[:index] == mark }
    game.send(find_item[:action]) unless find_item.nil?
end


