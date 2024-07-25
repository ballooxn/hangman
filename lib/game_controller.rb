require_relative "display"

# Hangman

class GameController
  include Display
  @@rounds_won = 0
  def initialize
    @selected_word = ""
    @guess = ""
    @file = "dictionary.txt"
    start_game
  end

  def choose_random_line(line)
    result = nil

    File.open(@file, "r") do |f|
      while line.positive?
        line -= 1
        result = f.gets
      end
    end

    result
  end

  def start_game
    game_loop
  end

  def game_loop
    game_over = false
    until game_over

    end
  end

  def guess_letter
  end

  def choose_word
  end
end
