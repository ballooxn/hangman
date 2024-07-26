require "rainbow"

module Display
  def self.introduction
    puts Rainbow("Welcome to Hangman!").red
    puts "A random word will be chosen for you."
    puts "You must guess letters to complete the word."
    puts "You will have 6 attempts to guess the word."
    puts "Good luck!"
  end

  def self.display_number_of_letters(guessed_word)
    puts guessed_word.join
  end

  def self.choose_letter
    puts Rainbow("Choose a letter:").bright
  end

  def self.guessed_letters(guessed_letters)
    puts Rainbow("Letters guessed: #{guessed_letters}").blue
  end

  def self.display_feedback(guessed_word)
    puts Rainbow("Current progress: #{guessed_word}").green
  end

  def self.incorrect_guess(guesses_remaining)
    puts Rainbow("Incorrect guess. You have #{guesses_remaining} guesses remaining.").red
  end

  def self.congrats_message(rounds_won)
    rounds_won == 1 ? (puts "Congratulations! You won your first round!") : (puts "Congratulations! You won #{rounds_won} rounds.")
  end

  def self.game_over_message(rounds_won)
    (puts "Game over! You won #{rounds_won} rounds.")
    puts "Would you like to play again? (y/n)"
  end
end
