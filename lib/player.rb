require_relative "display"

module Player
  include Display

  def self.choose_guess(guessed_letters)
    guess = "test"
    until valid_guess?(guess, guessed_letters)
      Display.choose_guess
      guess = gets.chomp.downcase
    end
    guess
  end

  def self.valid_guess?(guess, guessed_letters)
    return true if guess == "save"

    return false unless guess.length == 1
    return false unless guess.match?(/[a-z]/)

    return false if guessed_letters.include?(guess)

    true
  end
end
