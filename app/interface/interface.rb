# frozen_string_literal: true

# Класс Interface представляет текстовый интерфейс и вводом пользовательского выбора.
#
class Interface
  # Здесь будут инициализированы разные типы меню

  def show_menu(menu_type)
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

  def show_exit_message
    puts "
      Bye! 

      The final score is:
        Player score is #{@player.bank}
        Dealer score is #{@dealer.bank}
      "
  end

  def ask_player_name
    print 'What is your name, player?'
    player_name = prompt().capitalize
  end

  private
  def prompt(prompt_number = false)
    loop do
      input_string = gets.chomp

      if prompt_number
        begin
          return Integer(input_string)
        rescue ArgumentError
          puts 'This is not a number! Try again.'
        end
      else
        return input_string
      end
    end
  end
end
