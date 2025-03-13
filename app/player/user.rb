# frozen_string_literal: true

# Класс User представляет компьютерного игрока в блэкджеке.
#
class User < Player
  def make_move(max_hand_size, interface)
    full_hand = @hand.size >= max_hand_size
    interface.ask_user_move(full_hand, @name)
  end
end
