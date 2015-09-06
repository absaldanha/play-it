module PlayIt
  module Clusterer
    class Cluster
      attr_reader :music

      ##
      # Initializes the new cluster object with the given +music+ or
      # with an empty array.
      #
      # @param music [Array] the array of Musics of this cluster.
      #
      def initialize(music = nil)
        @music = music || []
      end

      ##
      # Adds the music +msc+ to the cluster
      #
      # @param [Music] the new music that will be added.
      #
      def add(msc)
        @music << msc
      end
    end
  end
end
