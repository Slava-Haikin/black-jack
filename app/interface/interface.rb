# frozen_string_literal: true

# Класс Interface представляет текстовый интерфейс и вводом пользовательского выбора.
#
class Interface
  USER_MENU = [
    { command: :skip, title: '[S]kip turn', input: ['s', 'skip turn', 'skip'] },
    { command: :open, title: '[O]pen cards', input: ['o', 'open cards', 'open'] },
    { command: :add, title: '[A]dd card', input: ['a', 'add card', 'add'] }
  ].freeze

  def show_menu(menu)
    separator = '==============='
    puts "\n\n#{separator}"
    menu.each_with_index { |item, index| puts "#{index + 1}. #{item[:title]}" }
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

  def show_player_result(player, score)
    puts "\n"
    puts "#{player.name} cards are:"
    player.hand.each { |card| puts card }
    show_user_score(score, player)
    puts "\n"
  end

  def show_user_score(score, player = nil)
    puts "#{player ? player.name : 'Your'} score is: #{score}"
  end

  def show_winner_message(winner)
    winner_message = winner.is_a?(Array) ? 'It is a draw.' : "#{winner.name} has won! Congratulions."
    puts winner_message
  end

  def ask_user_move(full_hand, _user_name)
    user_menu = filtered_user_menu(full_hand)
    show_menu(user_menu)
    get_user_choice(user_menu)
  end

  def ask_player_name
    print 'What is your name, player? My name is: '
    prompt.capitalize
  end

  def ask_exit_game
    print 'Do you want to continue the game, Yes/No? My answer is: '
    answer = prompt.strip.downcase
    answer == 'no'
  end

  private

  def filtered_user_menu(full_hand)
    menu = USER_MENU.dup
    menu.reject! { |item| item[:command] == :add } if full_hand
    menu
  end

  def get_user_choice(user_menu)
    loop do
      answer = prompt.strip.downcase
      choice = user_menu.each_with_index.find do |(item, index)|
        item[:input].include?(answer) || index + 1 == answer.to_i
      end&.first
      return choice[:command] if choice

      puts 'Invalid choice. Try again.'
    end
  end

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
