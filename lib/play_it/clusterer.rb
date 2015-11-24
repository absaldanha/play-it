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
      # @param clusters [Integer] the number of clusters to generate
      # @param runs [Integer] the number of times to run (end point)
      #
      # @return [ClusterSet] the set of clusters
      #
      def make_clusters(music_set, clusters, runs)
        kmeans = KMeansClusterer.run clusters, data(music_set), labels: labels(music_set), runs: runs

        cluster_set = ClusterSet.new

        kmeans.clusters.each do |cls|
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

      def data(music_set)
        music_set.map { |music| music.features.values }
      end

      def labels(music_set)
        music_set.map { |music| music }
      end
    end
  end
end
