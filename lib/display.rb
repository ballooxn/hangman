module Display
  def self.intro
    puts "Welcome to Hangman!"
    puts ""
    puts "If you would like to load in a previous game, then type in the name of the save file."
    puts "Else, type 'new'"
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
    print "\nThat guess was incorrect! You now have #{wrong_guesses_remaining} guesses left."
  end

  def self.guessed_letters(arr)
    print "\nLetters guessed: [ "
    arr.each do |v|
      print "#{v} "
    end
    print "]"
  end

  def self.round_won(rounds_won)
    puts "\n\nCongrats, you guessed the word! You have won #{rounds_won} rounds."
  end

  def self.game_over(rounds_won)
    puts "\nGame over! You won #{rounds_won} rounds."
  end
end
