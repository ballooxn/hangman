require_relative "display"
require_relative "player"
require_relative "data_manager"

class Game
  include Display
  include DataManager
  include Player

  MAX_GUESSES = 7

  def initialize
    @dictionary = File.read("dictionary.txt").split
    @dictionary.select! { |w| w.length >= 5 && w.length <= 12 }

    @secret_word = []
    @guessed_word = []
    @guessed_letters = []
    @game_loaded = false
    @rounds_won = 0
  end

  def start_game
    Display.intro # load game or new?
    answer = ""
    answer = gets.chomp until answer == "new" || DataManager.valid_file_name?(answer)

    unless answer == "new"
      @game_loaded = true
      variables = DataManager.load_game(answer)[0]

      load_variables(variables)
    end

    game_loop
  end

  def load_variables(variables)
    @secret_word = variables.instance_variable_get(:@secret_word)
    @guessed_word = variables.instance_variable_get(:@guessed_word)
    @guessed_letters = variables.instance_variable_get(:@guessed_letters)
    @rounds_won = variables.instance_variable_get(:@rounds_won)
    @wrong_guesses_remaining = variables.instance_variable_get(:@wrong_guesses_remaining)
    Display.print_guessed_word(@guessed_word)
  end

  protected

  def game_loop
    game_over = false
    until game_over
      reset_words unless @game_loaded
      @game_loaded = false

      # Loop through guesses until secret word is guessed OR run out of tries
      until guessed_secret_word?
        guess = Player.choose_guess(@guessed_letters)
        if guess == "save"
          DataManager.save_game(self)
          return
        end

        @guessed_letters.push(guess)
        correct_guess = process_guess(guess)

        if correct_guess
          Display.print_guessed_word(@guessed_word)
        else
          @wrong_guesses_remaining -= 1
          if @wrong_guesses_remaining.zero?
            game_over = true
            break
          end
          Display.incorrect_guess(@wrong_guesses_remaining)
        end
      end

      unless game_over
        @rounds_won += 1
        Display.round_won(@rounds_won)
      end
    end

    Display.game_over(@rounds_won)
  end

  def guessed_secret_word?
    @guessed_word == @secret_word
  end

  def reset_words
    @secret_word = @dictionary.sample.chars
    @guessed_word = Array.new(@secret_word.length, "_")
    @guessed_letters = []
    @wrong_guesses_remaining = MAX_GUESSES
  end

  # Add correctly guessed letters to the @guessed_word array
  # If no correct guesses then return false, else return true.
  def process_guess(guess)
    number_correct = 0
    @secret_word.each_with_index do |v, i|
      if v == guess
        @guessed_word[i] = guess
        number_correct += 1
      end
    end
    number_correct > 0 # rubocop:disable Style/NumericPredicate
  end
end
