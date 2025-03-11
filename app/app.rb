class App
  def initialize
    @player = HumanPlayer.new
    @dealer = Dealer.new
    @interface = Interface.new
  end

  def startGame
    # Основная логика игры
    print 'Game started!'
  end
end

App.startGame