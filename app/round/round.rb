# frozen_string_literal: true

# Класс Round управляет раундами игры.
#
class Round
  def initialize(user, dealer, interface)
    @deck = Deck.new
    @user = user
    @dealer = dealer
    @interface = interface
    @player_max_hand_size = 3
    @user_score = 0
    @dealer_score = 0
    @score_limit = 21
    @stake_amount = 10
  end

  def start
    winner = nil

    make_stakes
    deal_cards

    @interface.show_user_score(@user_score)

    while winner.nil?

      user_move
      dealer_move
      winner = check_result
    end

    puts @user.hand, @dealer.hand, @user.name
  end

  def deal_cards
    2.times do
      user_card = @deck.draw_card
      dealer_card = @deck.draw_card
      user_card_score = @deck.calculate_card_value(@user_score, user_card)
      dealer_card_score = @deck.calculate_card_value(@dealer_score, dealer_card)

      @user_score += user_card_score
      @dealer_score += dealer_card_score
      @user.take_card(user_card)
      @dealer.take_card(dealer_card)
    end
  end

  def make_stakes
    @user.balance -= @stake_amount
    @dealer.balance -= @stake_amount
  end

  def withdraw_money(target_player)
    target_player.balance += @stake_amount * 2
  end

  def check_result
    @user.hand.size
    @dealer_score > @score_limit
  end

  def user_move
    full_hand = @user.hand.size >= @player_max_hand_size
    @interface.ask_user_move(full_hand, @user.name)
  end

  def dealer_move; end
end
