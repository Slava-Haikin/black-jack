class Interface
  # Здесь будут инициализированы разные типы меню

  def show_menu(type)
    puts
  end

  def prompt_choice
    choice = gets.chomp
  end
end