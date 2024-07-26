class Player
  def initialize
    @guessed_letters = []
    @guess = nil
  end

  def choose_guess
    @guess = gets.chomp.downcase until valid?
    @guessed_letters << @guess
    @guess
  end

  def valid?
    if @guess.nil? || @guess.length != 1 || !("a".."z").include?(@guess) || @guessed_letters.include?(@guess)
      return false
    end

    true
  end
end
