module PlayIt
  module Clusterer
    ##
    # Class that represents a cluster.
    #
    class Cluster
      attr_reader :music, :centroid

      ##
      # Initializes the new cluster object with the given +music+ or
      # with an empty array.
      #
      # @param music [Array] the array of Musics of this cluster.
      # @param centroid [Array] the centroid of the cluster.
      #
      def initialize(music = nil, centroid = nil)
        @music = music || []
        @centroid = centroid || []
      end

      ##
      # Adds the music +msc+ to the cluster
      #
      # @param msc [Music] the new music that will be added.
      #
      def add(msc)
        @music << msc
      end
    end
  end
end
