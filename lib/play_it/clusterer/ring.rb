module PlayIt
  module Clusterer
    ##
    # Class that represents a ring of a cluster
    #
    class Ring
      attr_reader :music

      ##
      # Initializes a new Ring object with an empty array of music
      #
      def initialize
        @music = []
      end

      ##
      # Adds the given +music+ to the array of music
      #
      # @param music [Music] the music to be added
      #
      def <<(music)
        @music << music
      end
    end
  end
end
