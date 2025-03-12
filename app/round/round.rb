# frozen_string_literal: true

# Класс Round управляет раундами игры.
#
class Round
  def initialize(player, dealer, interface)
    @player = player
    @dealer = dealer
    @deck = Deck.new
    @interface = interface
    @player_score = 0
    @dealer_score = 0
  end

  def start
    deal_cards
    puts @player.hand, @dealer.hand, @player.name
  end

  def deal_cards
    2.times do
      player_card = @deck.draw_card
      dealer_card = @deck.draw_card
      player_card_score = @deck.calculate_card_value(@player_score, player_card)
      dealer_card_score = @deck.calculate_card_value(@dealer_score, dealer_card)

      @player_score += player_card_score
      @player_score += dealer_card_score
      @player.take_card(player_card)
      @dealer.take_card(dealer_card)
    end
  end
end
