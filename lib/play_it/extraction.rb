require 'play_it/extraction/extractor'

module PlayIt
  module Extraction
    class << self
      def extract(music_path)
        Extractor.extract_features music_path
      end
    end
  end
end
