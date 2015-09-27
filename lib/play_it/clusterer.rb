require 'play_it/clusterer/cluster'
require 'play_it/clusterer/cluster_set'

module PlayIt
  module Clusterer
    class << self
      ##
      # Build the clusters with the given +music_set+
      #
      # @param music_set [Set] the collection of music to build the clusters
      #
      # @return [ClusterSet] the set of clusters
      #
      def make_clusters(music_set)
        kmeans = Kmeans::Cluster.new(musics(music_set), loop_max: 20)
        kmeans.make_cluster

        cluster_set = ClusterSet.new

        kmeans.cluster.values.each do |cls|
          cluster_set.add(Cluster.new(cls)) unless cls.empty?
        end

        cluster_set
      end

      private

      def musics(music_set)
        music_set.each_with_object({}) do |music, hash|
          hash[music] = music.features
        end
      end
    end
  end
end
