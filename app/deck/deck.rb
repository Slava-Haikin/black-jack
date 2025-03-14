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
    aces_count = 0
    total = 0

    hand.each do |card|
      value = card[1..]
      case value
      when 'A'
        aces_count += 1
      when 'K', 'Q', 'J'
        total += 10
      else
        total += value.to_i
      end
    end

    aces_count.times do
      total += total + 11 <= 21 ? 11 : 1
    end

    total
  end

  def initialize
    @deck = CARDS.dup.shuffle
  end

  def draw_card
    @deck.pop
  end
end
