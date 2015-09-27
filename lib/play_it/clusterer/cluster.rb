module PlayIt
  module Clusterer
    class Cluster
      attr_reader :music
      attr_reader :centroid

      ##
      # Initializes the new cluster object with the given +music+ or
      # with an empty array.
      #
      # @param music [Array] the array of Musics of this cluster.
      #
      def initialize(music = nil, centroid = nil)
        if music
          @music = music
          @centroid = centroid
        else
          @music = []
          @centroid = {}
        end
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
