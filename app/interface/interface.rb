# frozen_string_literal: true

# Класс Interface представляет текстовый интерфейс и вводом пользовательского выбора.
#
class Interface
  # Здесь будут инициализированы разные типы меню

  def show_menu(_menu_type)
    puts
  end

  def show_welcome_message(player_name, dealer_name, player_balance, dealer_balance)
    puts "
      Welcome to the Black Jack Game!

      #{player_name} is playing vs #{dealer_name}

      #{player_name} score is #{player_balance}
      #{dealer_name} score is #{dealer_balance}
      "
  end

  def show_exit_message(player_name, dealer_name, player_balance, dealer_balance)
    puts "
      It was a nice match, bye!

      The final score is:
      #{player_name} final score is #{player_balance}
      #{dealer_name} final score is #{dealer_balance}
      "
  end

  def ask_player_name
    print 'What is your name, player? My name is: '
    prompt.capitalize
  end

  def ask_exit_game
    print 'Do you want to continue the game, Yes/No? My answer is: '
    answer = prompt.capitalize

    answer.downcase != 'yes'
  end

  private

  def prompt(prompt_number: false)
    loop do
      input_string = gets.chomp

      return input_string unless prompt_number

      begin
        return Integer(input_string)
      rescue ArgumentError
        puts 'This is not a number! Try again.'
      end
    end
  end
end
