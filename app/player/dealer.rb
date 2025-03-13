# frozen_string_literal: true

# Класс Dealer представляет компьютерного игрока в блэкджеке.
#
class Dealer < Player
  MAX_SCORE = 17

  def initialize
    super('Dealer')
  end

  def make_move(dealer_score)
    dealer_score >= MAX_SCORE ? :skip : :add
  end
end
