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

  def self.calculate_card_value(hand)
    total, aces_count = hand.reduce([0, 0]) do |(sum, aces), card|
      case card[1..]
      when 'A' then [sum, aces + 1]
      when 'K', 'Q', 'J' then [sum + 10, aces]
      else [sum + card[1..].to_i, aces]
      end
    end

    aces_count.times { total += total + 11 <= 21 ? 11 : 1 }
    total
  end

  def initialize
    @deck = CARDS.dup.shuffle
  end

  def draw_card
    @deck.pop
  end
end
