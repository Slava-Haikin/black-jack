# frozen_string_literal: true

# Класс Interface представляет текстовый интерфейс и вводом пользовательского выбора.
#
class Interface
  USER_MENU = [
    { command: :skip, title: '[S]kip turn', input: ['s', 'skip turn', 'skip']},
    { command: :open, title: '[O]pen cards', input: ['o', 'open cards', 'open']},
    { command: :add, title: '[A]dd card', input: ['a', 'add card', 'add']},
].freeze

  def show_menu(menu)
    separator = '==============='
    puts "\n\n#{separator}"
    menu.each_with_index { |item, index| puts "#{index + 1}. #{item[:title]}"}
    puts "#{separator}\n\n"
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

  def show_user_score(score)
    puts "Your score is: #{score}"
  end

  def show_user_card(user)
    puts user.hand
  end

  def ask_user_move(full_hand, user_name)
    user_menu = USER_MENU.dup
    user_menu.reject! { |menu_item| menu_item[:command] == :add } if full_hand  
    show_menu(user_menu)
    # available_option = full_hand ? %s[skip open add] : %s[ skip open]
    # user_choice = nil

    # while user_choice.nil?
    #   answer = prompt


    # end


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
