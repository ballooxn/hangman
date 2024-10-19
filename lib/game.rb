require_relative "display"
require_relative "player"
require_relative "data_manager"

class Game
  include Display
  include Data_Manager
  include Player

  MAX_GUESSES = 7

  def initialize
    @dictionary = File.read("dictionary.txt").split
    @dictionary.select! { |w| w.length >= 5 && w.length <= 12 }

    @secret_word = []
    @guessed_word = []

    @rounds_won = 0
    @guesses_remaining = MAX_GUESSES
  end

  def start_game
    Display.intro
    round_loop
  end

  protected

  def game_loop
    game_over = false
    until game_over
      @guesses_remaining = MAX_GUESSES

      reset_words
      # Loop through guesses until secret word is guessed OR run out of tries
      until guessed_secret_word?
        game_over = true if @guesses_remaining.zero?
        guess = Player.choose_guess

        if guess == "save"
          Data_Manager.save_game(binding)
          return
        end

        check_guess
        Display.print_guessed_word(@guessed_word)
      end
      @rounds_won += 1
      Display.round_won(@rounds_won)

    end
    Display.game_over(@rounds_won)
  end
  
  def guessed_secret_word?
    @guessed_word == @secret_word
  end

  def reset_words
    @secret_word = @dictionary.sample
    @guessed_word = Array.new(@secret_word.length, "_")
  end

  # Add correctly guessed letters to the @guessed_word array
  # If no correct guesses,
  def check_guess
end
