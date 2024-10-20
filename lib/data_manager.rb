require "yaml"

module Data_Manager
  WORD_ONE = %w[Swift Clever Bold Glowing Dancing Mysterious Racing Curious Fearless Jumping].freeze
  WORD_TWO = %w[Fox Panda Eagle Wolf Koala Otter Lion Owl Tiger Hawk].freeze

  def self.save_game(game_class)
    Dir.mkdir("saves") unless Dir.exist?("saves") # rubocop:disable Lint/NonAtomicFileOperation
    name = [WORD_ONE.sample, WORD_TWO.sample].join
    puts name

    game_class.instance_variable_set(:@dictionary, nil)

    File.open("saves/#{name}.yml", "w") { |f| YAML.dump([] << game_class, f) }
  end

  def self.load_game
  end

  def self.valid_file_name?(name)
    File.exist?("saves/#{name}.yml")
  end
end
