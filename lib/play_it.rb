require 'play_it/configuration'
require 'play_it/player'
require 'play_it/clusterer'
require 'play_it/music'
require 'play_it/library'
require 'play_it/extraction'
require 'play_it/logger'

require_relative File.expand_path('./../../config/config.rb', __FILE__)

module PlayIt
  def self.run
    Player.run
  end

  def self.ci_env?
    ENV['ENV'] == 'CI'
  end
end

unless PlayIt.ci_env?
  require 'gtk3'
  require 'gst'
end
require 'cocaine'
