# frozen_string_literal: true

# Класс Interface представляет текстовый интерфейс и вводом пользовательского выбора.
#
class Interface
  # Здесь будут инициализированы разные типы меню

  def show_menu(_type)
    puts
  end

  def prompt_choice
    gets.chomp
  end
end
