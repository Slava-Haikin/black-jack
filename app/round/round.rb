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
      user_move_choice = @user.make_move(@player_max_hand_size, @interface)
      players_move(user_move_choice)

      calculate_scores
      puts @user_score, @dealer_score
      winner = check_winner
      puts winner
    end

    @interface.show_winner_message(winner)
    @user.drop_cards
    @dealer.drop_cards
  end

  def deal_cards
    2.times do
      user_card = @deck.draw_card
      dealer_card = @deck.draw_card
      user_card_score = Deck.calculate_card_value(@user_score, user_card)
      dealer_card_score = Deck.calculate_card_value(@dealer_score, dealer_card)

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

  def calculate_scores
    @user_score = @user.hand.sum { |card| Deck.calculate_card_value(@user_score, card) }
    @dealer_score = @dealer.hand.sum { |card| Deck.calculate_card_value(@dealer_score, card) }
  end

  def check_winner
    if @user_score > @score_limit
      @dealer
    elsif @dealer_score > @score_limit
      @user
    elsif @user.hand.size == @player_max_hand_size && @dealer.hand.size == @player_max_hand_size
      @user_score > @dealer_score ? @user : @dealer
    end
  end

  def players_move(choice)
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
      return
    end
  end

  def process_dealer_move(choice)
    return if choice == :skip
  
    new_card = @deck.draw_card
    @dealer.take_card(new_card)
  end
end
