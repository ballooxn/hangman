require_relative "display"

module Player
  include Display

  def self.choose_guess
    guess = ""
    until valid_guess?(guess)
      Display.choose_guess
      guess = gets.chomp.downcase
    end
    guess
  end

  def self.valid_guess(guess)
    return true if guess == "save"

    return unless guess.length == 1
    return unless guess.match?(/[a-z]/)

    true
  end
end
