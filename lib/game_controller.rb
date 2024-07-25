require_relative "display"

# Hangman

class GameController
  include Display
  @@rounds_won = 0
  def initialize
    @selected_word = []
    @guessed_word = []
    @file = "dictionary.txt"
    start_game
  end

  def choose_random_line
    result = ["oh yeah"]
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
    game_loop
  end

  def game_loop
    game_over = false
    guesses_remaining = 6
    until game_over
      p @selected_word = choose_random_line
      @guessed_word = Array.new(@selected_word.length, "-")
      Display.display_number_of_letters(@guessed_word)
      until selected_word_guessed?
        Display.choose_letter
        guess_letter = gets.chomp.downcase
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
      @@rounds_won += 1
      Display.congrats_message(@@rounds_won)
    end
    # The game is over
    Display.game_over_message(@@rounds_won)
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
