# frozen_string_literal: true

# Класс Round управляет раундами игры.
# 
class Round
  def initialize(interface)
    @interface = interface
  end

  def start_first_round
    puts 'First round started.'
  end

  def start_new_round
    puts 'New round started.'
  end
end