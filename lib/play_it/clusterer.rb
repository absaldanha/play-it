require 'kmeans-clusterer'
require 'play_it/clusterer/cluster'
require 'play_it/clusterer/cluster_set'

module PlayIt
  ##
  # Module for the clustering procedures.
  #
  module Clusterer
    class << self
      ##
      # Build the clusters with the given +music_set+
      #
      # @param music_set [Set] the collection of music to build the clusters
      #
      # @return [ClusterSet] the set of clusters
      #
      def make_clusters(music_set, clusters, runs)
        kmeans = KMeansClusterer.run clusters, data(music_set), labels: labels(music_set), runs: runs

        cluster_set = ClusterSet.new

        kmeans.clusters.each do |cls|
          cluster = Cluster.new(cls.points.map(&:label), cls.centroid.data.to_a)
          cluster_set.add(cluster) unless cls.points.empty?
        end

        cluster_set
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
