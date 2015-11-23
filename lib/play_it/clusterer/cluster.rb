module PlayIt
  module Clusterer
    ##
    # Class that represents a cluster.
    #
    class Cluster
      attr_reader :radius

      ##
      # Initializes the new cluster object with the given +music+ or
      # with an empty array.
      #
      # @param music [Array] the array of Musics of this cluster.
      #
      def initialize(music)
        @rings = Array.new(3) { Ring.new }

        calc_radius music
        build_rings music
      end

      ##
      # Gets the music the cluster contains
      #
      # @return [Array] the music of the cluster
      #
      def music
        @rings.map(&:music).flatten
      end

      private

      def calc_radius(music)
        @radius = music.max_by(&:centroid_distance).centroid_distance
      end

      def build_rings(music)
        music.each do |msc|
          ring = right_ring_of msc
          add_to_ring ring, msc
        end
      end

      def right_ring_of(music)
        return 0 if music.centroid_distance <= @radius / 3
        return 1 if music.centroid_distance <= 2 * @radius / 3
        2
      end

      def add_to_ring(ring, music)
        @rings[ring] << music.label
      end
    end
  end
end
