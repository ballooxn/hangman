require "display"

# Hangman

class GameController
  include Display
  @@rounds_won = 0
  def initialize
    @word = ""
  end

  def start_game
  end

  def game_loop
  end

  def guess_letter
  end

  def choose_word
  end
end
