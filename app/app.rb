# frozen_string_literal: true

# Класс App управляет всем приложением.
#
class App
  def initialize
    @player = HumanPlayer.new
    @dealer = Dealer.new
    @interface = Interface.new
  end

  def start_game
    # Основная логика игры
    print 'Game started!'
  end
end

App.start_game
