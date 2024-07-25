module Display
  def self.introduction
    puts "Welcome to Hangman!"
    puts "A random word will be chosen for you."
    puts "You must guess letters to complete the word."
    puts "You will have 6 attempts to guess the word."
    puts "Good luck!"
  end

  def self.display_number_of_letters(guessed_word)
    puts guessed_word.join("")
  end

  def self.choose_letter
    puts "Choose a letter:"
  end

  def self.display_feedback(guessed_word)
    puts "Current progress: #{guessed_word}"
  end

  def self.incorrect_guess(guesses_remaining)
    puts "Incorrect guess. You have #{guesses_remaining} guesses remaining."
  end

  def self.congrats_message(rounds_won)
    rounds_won == 1 ? (puts "Congratulations! You won your first round!") : (puts "Congratulations! You won #{rounds_won} rounds.")
  end

  def self.game_over_message(rounds_won)
    (puts "Game over! You won #{rounds_won} rounds.")
    puts "Would you like to play again? (y/n)"
  end
end
