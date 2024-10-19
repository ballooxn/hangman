module Display
  def self.intro
    puts "Welcome to Hangman!"
    puts ""
  end

  def self.choose_guess
    puts "\nGuess a letter from a-z! Or type 'save' to save the game!"
  end

  def self.print_guessed_word(guessed_word)
    puts " "
    guessed_word.each do |v|
      print "#{v} "
    end
  end

  def self.incorrect_guess(wrong_guesses_remaining)
    puts "That guess was incorrect! You now have #{wrong_guesses_remaining} guesses left."
  end

  def self.round_won(rounds_won)
    puts "\nCongrats, you guessed the word! You have won #{rounds_won} rounds."
  end

  def self.game_over(rounds_won)
    puts "Game over! You won #{rounds_won} rounds."
  end
end
