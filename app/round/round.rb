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
    make_stakes
    deal_cards

    loop do
      @interface.show_user_score(@user_score)
      user_move_choice = @user.make_move(@player_max_hand_size, @interface)
      process_players_move(user_move_choice)

      calculate_scores
      winner = check_winner

      max_cards_amount_reached = @user.hand.size >= 3 && @dealer.hand.size >= 3
      next unless user_move_choice == :open || max_cards_amount_reached

      @interface.show_winner_message(winner)
      withdraw_money(winner)
      @user.drop_cards
      @dealer.drop_cards
      return
    end
  end

  def deal_cards
    2.times do
      @user.take_card(@deck.draw_card)
      @dealer.take_card(@deck.draw_card)
      calculate_scores
    end
  end

  def make_stakes
    @user.balance -= @stake_amount
    @dealer.balance -= @stake_amount
  end

  def withdraw_money(target_player)
    if target_player.is_a?(Array)
      target_player.each { |player| player.balance += @stake_amount }
    else
      target_player.balance += @stake_amount * 2
    end
  end

  def calculate_scores
    @user_score = Deck.calculate_card_value(@user.hand)
    @dealer_score = Deck.calculate_card_value(@dealer.hand)
  end

  def check_winner
    if @user_score > @score_limit && @dealer_score > @score_limit
      [@user, @dealer]
    elsif @user_score > @score_limit
      @dealer
    elsif @dealer_score > @score_limit
      @user
    else
      @user_score > @dealer_score ? @user : @dealer
    end
  end

  def process_players_move(choice)
    case choice
    when :skip
      dealer_choice = @dealer.make_move(@dealer_score)
      process_dealer_move(dealer_choice)
    when :add
      new_card = @deck.draw_card
      @user.take_card(new_card)

      dealer_choice = @dealer.make_move(@dealer_score)
      process_dealer_move(dealer_choice)
    when :open
      nil
    end
  end

  def process_dealer_move(choice)
    return if choice == :skip

    return unless @dealer.hand.size <= 2

    new_card = @deck.draw_card
    @dealer.take_card(new_card)
  end
end
