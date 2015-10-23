require 'play_it/extractor/extract'

module PlayIt
  module Extractor
    class << self
      def extract(music_path)
        Extract.extract_features music_path
      end
    end
  end
end
