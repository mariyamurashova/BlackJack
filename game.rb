# frozen_string_literal: true

require_relative 'bank'
require_relative 'cards'
require_relative 'player'
require_relative 'deler'
require_relative 'deck'

MENU_START = [{ index: 1, title: 'New game', action: :new_game },
              { index: 0, title: 'EXIT', action: :quit }].freeze

MENU_GAME = [{ index: 1, title: 'Skip_turn', action: :skip_turn },
             { index: 2, title: 'Take 3-d card', action: :add_card },
             { index: 3, title: 'Open cards', action: :open_cards }].freeze

MENU_END = [{ index: 1, title: 'New_round', action: :new_round },
            { index: 2, title: 'Finish the Game and exit', action: :quit }].freeze

class Game
  def new_game
    create_bank
    add_player
    add_deler
    start
  end

  def show_menu(menu)
    puts ''
    menu.each.each { |item| puts "#{item[:index]} - #{item[:title]}" }
    mark = gets.to_i
    find_item = menu.find { |item| item[:index] == mark }
    send(find_item[:action]) unless find_item.nil?
  end

  protected

  def new_round
    clear_data
    start
  end

  def start
    create_shuffle_deck
    deal_cards
    place_bets
    show_menu(MENU_GAME)
    take_decision
    who_is_winner
    open_cards
    show_menu(MENU_END)
  end

  def who_is_winner
    if draw?
      halve_money
      puts "It's DRAW\n\n"
    elsif player_winner?
      @player.get_money(@bank)
      puts "#{@player.name} You are the WINNER\n\n"
    else
      @deler.get_money(@bank)
      puts "#{@player.name} You LOSE\n\n"
    end
  end

  def halve_money
    @player.money += 10
    @deler.money += 10
    @bank.money = 0
  end

  def draw?
    (@player.sum_hand - @deler.sum_hand).zero?
  end

  def player_winner?
    (@player.sum_hand == 21 && @deler.sum_hand != 21) ||
      (@player.sum_hand < 21 && @deler.sum_hand > 21) ||
      ((@player.sum_hand - @deler.sum_hand).positive? && @player.sum_hand < 21) ||
      ((@player.sum_hand - @deler.sum_hand).negative? && @player.sum_hand > 21)
  end

  def clear_data
    @player.sum_hand = 0
    @deler.sum_hand = 0
    @player.hand = []
    @deler.hand = []
    @player.has_A = false
    @deler.has_A = false
    @player.turn = false
    @deler.turn = false
  end

  def difference_21?
    @player.sum_hand - 21 > @deler.sum_hand - 21
  end

  def take_decision
    if @deler.sum_hand < 17
      add_card(@deler)
      puts "DELER's cards:"
      puts " *    *    *\n\n"
    else
      skip_turn(@deler)
      puts "DELER's cards:"
      puts "*    * \n\n"
    end
  end

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
    puts "\n\nDELER's cards:"
    puts "*    *\n\n"
    @deler.deal_card(@deck.new_deck, 2)
    puts "#{@player.name}, your cards:"
    @player.deal_card(@deck.new_deck, 2)
    @player.show_cards
  end

  def add_card(player = @player)
    if player.player_moved?
      player.deal_card(@deck.new_deck, 1)
    else
      puts "It's impossible take more cards."
    end
  end

  def place_bets
    @player.place_bet
    @deler.place_bet
    @bank.recieve_money
  end

  def skip_turn(player = @player)
    if player.player_moved?
      player.skip
    else
      puts 'Choose another action'
    end
  end

  def open_cards
    if !@deler.player_moved?
      print "#{@player.name}:  "
      @player.show_cards
      print 'DELER:  '
      @deler.show_cards
      game_result
      show_menu(MENU_END)
    else
      take_decision
    end
  end

  def game_result
    who_is_winner
    @player.calculate_money
    @deler.calculate_money
  end

  def quit
    puts 'GoodBye!'
    exit(0)
  end
end

game = Game.new
game.show_menu(MENU_START)
