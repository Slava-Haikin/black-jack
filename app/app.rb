# frozen_string_literal: true

# Класс App управляет всем приложением: Начинает и завершает игру.

require_relative 'round/round'

require_relative 'player/player'
require_relative 'player/dealer'
require_relative 'player/human_player'

require_relative 'interface/interface'
require_relative 'deck/deck'

class App
  def initialize
    @player = nil
    @dealer = Dealer.new
    @interface = Interface.new
  end

  def play_game
    create_player
    @interface.show_welcome_message(@player.name, @dealer.name, @player.balance, @dealer.balance)

    loop do
      should_exit = play_round
      return if should_exit
    end
  end

  private

  def create_player
    player_name = @interface.ask_player_name
    @player = HumanPlayer.new(player_name)
  end

  def play_round
    Round.new(@player, @dealer, @interface).start

    game_over = @player.balance.zero?
    want_exit = @interface.ask_exit_game

    return false unless want_exit || game_over

    @interface.show_exit_message(@player.name, @dealer.name, @player.balance, @dealer.balance)
    true
  end
end

game = App.new
game.play_game
