# frozen_string_literal: true

require 'yaml'
require 'fileutils'



# to house methods for saving and loading game state
class Database
  def save_game(game, filename)
    FileUtils.mkdir_p 'save_files'
    yaml = YAML.dump(game)
    File.open("save_files/#{filename}.yaml", 'w') { |f| f.puts yaml }
  end

  def load_game(filename)
    yaml = File.open("save_files/#{filename}", 'r', &:read)
    YAML.load(yaml)
  end
end
