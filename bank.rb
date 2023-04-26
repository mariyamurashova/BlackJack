# frozen_string_literal: true

class Bank
  attr_accessor :money

  def initialize
    @money = 0
  end

  def recieve_money
    @money += 20
  end

  def gives_money_winner
    @money = 0
  end
end
