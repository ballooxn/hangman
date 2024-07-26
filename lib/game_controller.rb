require_relative "display"
require_relative "data_manager"
require_relative "player"

class GameController
  include Display
  include DataManager
  def initialize
    @selected_word = []
    @guessed_word = []
    @guessed_letters = []
    @file = "dictionary.txt"
    @rounds_won = 0
    start_game
  end

  def choose_random_line
    result = ["_"]
    until result.length >= 5 && result.length <= 12
      line = rand(1..10_000)
      File.open(@file, "r") do |f|
        line.times do
          result = f.gets.chars
          result.pop
        end
      end
    end
    result
  end

  def start_game
    puts "Would you like to load a previous game? (y/n)"
    load_game = gets.chomp.downcase
    @rounds_won = DataManager.load_game if load_game == "y"
    game_loop
  end

  def game_loop
    first_game = true
    Display.introduction
    game_over = false
    guesses_remaining = 6
    until game_over
      unless first_game == true
        endputs "Do you wish to save your progress? (y/n)"
        save_progress = gets.chomp.downcase
        DataManager.save_game(@rounds_won) if save_progress == "y"
      end
      first_game = false

      @selected_word = choose_random_line
      @guessed_word = Array.new(@selected_word.length, "-")
      Display.display_number_of_letters(@guessed_word)

      player = Player.new
      until selected_word_guessed?
        Display.guessed_letters(@guessed_letters) unless @guessed_letters.empty?
        Display.choose_letter
        guess_letter = player.choose_guess
        @guessed_letters << guess_letter
        correct = make_feedback(guess_letter)
        if correct
          Display.display_feedback(@guessed_word)
        else
          guesses_remaining -= 1
          Display.incorrect_guess(guesses_remaining) unless guesses_remaining.zero?
        end

        next unless guesses_remaining.zero?

        game_over = true
        break

      end
      # Word has been guessed
      @rounds_won += 1
      Display.congrats_message(@rounds_won)
    end
    # The game is over
    Display.game_over_message(@rounds_won)
    play_again = gets.chomp.downcase
    GameController.new if play_again == "y"
  end

  def make_feedback(guess_letter)
    letter_correct = false
    @selected_word.each_with_index do |letter, i|
      if letter == guess_letter
        @guessed_word[i] = guess_letter
        letter_correct = true
      end
    end
    letter_correct
  end

  def selected_word_guessed?
    @guessed_word == @selected_word
  end
end
