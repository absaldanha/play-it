module PlayIt
  module Clusterer
    ##
    # Class that represents a cluster.
    #
    class Cluster
      attr_reader :music, :radius

      ##
      # Initializes the new cluster object with the given +music+ or
      # with an empty array.
      #
      # @param music [Array] the array of Musics of this cluster.
      #
      def initialize(music)
        @music = []
        @radius = 0

        music.each do |msc|
          @music << msc.label
          calc_radius msc.centroid_distance
        end
      end

      private

      def calc_radius(value)
        @radius = value if value > @radius
      end
    end
  end
end
