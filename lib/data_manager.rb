require "json"

module DataManager
  def self.save_game(number_rounds_won)
    serialized_data = JSON.dump(rounds_won: number_rounds_won)
    File.open("saves/game_data.json", "w") do |file| # rubocop:disable Style/FileWrite
      file.write(serialized_data)
    end
  end

  def self.load_game
    unless File.exist?("saves/game_data.json")
      puts "No saved game found. Starting a new game."
      return
    end

    deserialized_data = JSON.parse File.read("saves/game_data.json")
    p deserialized_data
    deserialized_data["rounds_won"]
  end
end
