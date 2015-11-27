require 'kmeans-clusterer'
require 'play_it/clusterer/cluster'
require 'play_it/clusterer/cluster_set'
require 'play_it/clusterer/ring'

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
        kmeans = best_clusters(
          data(music_set),
          labels(music_set),
          max_clusters(music_set)
        )

        cluster_set = ClusterSet.new

        kmeans.sorted_clusters.each do |cls|
          cluster = Cluster.new cls.points
          cluster_set.add cluster unless cls.points.empty?
        end

        cluster_set
      end

      ##
      # Loads the cluster set from the configured path.
      #
      # @return [ClusterSet] the cluster set.
      #
      def load
        ClusterSet.new.tap(&:load)
      end

      private

      def best_clusters(data_set, label_set, max)
        runs = 2.upto(max).map do |k|
          KMeansClusterer.run k, data_set, labels: label_set, runs: 30
        end

        runs.min_by(&:error)
      end

      def data(music_set)
        music_set.map { |music| music.features.values }
      end

      def labels(music_set)
        music_set.map { |music| music }
      end

      def max_clusters(music)
        max = Math.sqrt(music.size).floor
        max < 2 ? 2 : max
      end
    end
  end
end
