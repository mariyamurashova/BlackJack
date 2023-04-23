# frozen_string_literal: true

class Card
  attr_accessor :deck, :name, :value

  def initialize(name, value)
    @name = name
    @value = value
  end
end
