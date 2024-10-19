require_relative "display"
require_relative "player"
require_relative "data_manager"

class Game
  include Display
  include Data_Manager
  include Player

  MAX_GUESSES = 5

  def initialize
    @dictionary = File.read("dictionary.txt").split
    @dictionary.select! { |w| w.length >= 5 && w.length <= 12 }

    @secret_word = []
    @guessed_word = []
    @guessed_letters = []

    @rounds_won = 0
  end

  def start_game
    Display.intro
    game_loop
  end

  protected

  def game_loop
    game_over = false
    until game_over
      @wrong_guesses_remaining = MAX_GUESSES

      reset_words
      # Loop through guesses until secret word is guessed OR run out of tries
      until guessed_secret_word?
        game_over = true if @wrong_guesses_remaining.zero?
        guess = Player.choose_guess(@guessed_letters)
        @guessed_letters.push(guess)

        if guess == "save"
          Data_Manager.save_game(@guessed_letters, @guessed_word, @secret_word, @wrong_guesses_remaining, @rounds_won)
          return
        end

        correct_guess = check_guess(guess)
        if correct_guess
          Display.print_guessed_word(@guessed_word)
        else
          @wrong_guesses_remaining -= 1
          Display.incorrect_guess(@wrong_guesses_remaining)
        end
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
    @secret_word = @dictionary.sample.chars
    p @secret_word
    @guessed_word = Array.new(@secret_word.length, "_")
  end

  # Add correctly guessed letters to the @guessed_word array
  # If no correct guesses then return false, else return true.
  def check_guess(guess)
    number_correct = 0
    @secret_word.each_with_index do |v, i|
      if v == guess
        @guessed_word[i] = guess
        number_correct += 1
      end
    end

    return if number_correct.zero?

    true
  end
end
