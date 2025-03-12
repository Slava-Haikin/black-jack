# frozen_string_literal: true

# Класс Deck создает колоду и выдает карты.
#
class Deck
  CARDS = [
    '♠A', '♠2', '♠3', '♠4', '♠5', '♠6', '♠7', '♠8', '♠9', '♠10', '♠J', '♠Q', '♠K',
    '♥A', '♥2', '♥3', '♥4', '♥5', '♥6', '♥7', '♥8', '♥9', '♥10', '♥J', '♥Q', '♥K',
    '♦A', '♦2', '♦3', '♦4', '♦5', '♦6', '♦7', '♦8', '♦9', '♦10', '♦J', '♦Q', '♦K',
    '♣A', '♣2', '♣3', '♣4', '♣5', '♣6', '♣7', '♣8', '♣9', '♣10', '♣J', '♣Q', '♣K'
  ].freeze

  def initialize
    @deck = CARDS.dup.shuffle
  end

  def draw_card
    @deck.pop
  end

  def calculate_card_value(current_score, card)
    value = card[1..]
  
    case value
    when 'A'
      current_score + 11 > 21 ? 1 : 11
    when 'K', 'Q', 'J'
      10
    else
      value.to_i
    end
  end
end
