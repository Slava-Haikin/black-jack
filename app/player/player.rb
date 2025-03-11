# frozen_string_literal: true

# Класс Player представляет игрока в блэкджеке.
#
class Player
  attr_accessor :name, :balance
  attr_reader :hand

  def initialize
    @name = nil
    @balance = 100
    @hand = []
  end

  def take_card(card)
    @cards << card
  end

  def drop_cards
    @cards = []
  end
end
