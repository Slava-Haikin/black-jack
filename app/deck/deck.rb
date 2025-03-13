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
    values = hand.map do |card|
      case card[1..]
      when 'A' then 11
      when 'K', 'Q', 'J' then 10
      else card[1..].to_i
      end
    end

    total = values.sum
    values.count(11).times { total -= 10 if total > 21 }

    total
  end

  def initialize
    @deck = CARDS.dup.shuffle
  end

  def draw_card
    @deck.pop
  end
end
