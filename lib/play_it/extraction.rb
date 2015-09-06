require 'cocaine'
require 'tempfile'
require 'shellwords'
require 'play_it/extraction/extractor'
require 'play_it/extraction/parser'

module PlayIt
  module Extraction
    class << self
      def extract(music_path)
        Extractor.extract_features music_path
      end
    end
  end
end
