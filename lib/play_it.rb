require 'set'
require 'json'
require 'tempfile'
require 'shellwords'
require 'kmeans-clusterer'
require 'cocaine'
require 'play_it/config'
require 'play_it/clusterer'
require 'play_it/music'
require 'play_it/library'
require 'play_it/extraction'
require 'play_it/logger'

require_relative File.expand_path('./../../config/config.rb', __FILE__)
