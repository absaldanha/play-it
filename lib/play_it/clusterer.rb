require 'play_it/clusterer/cluster'
require 'play_it/clusterer/cluster_set'

module PlayIt
  module Clusterer
    ##
    # Build the clusters with the given +music_set+
    #
    # @param music_set [Set] the collection of music to build the clusters
    #
    # @return [ClusterSet] the set of clusters
    #
    def self.make_clusters(music_set)
      music = music_set.each_with_object({}) do |msc, hash|
        hash[msc.path] = msc.features
      end

      kmeans = Kmeans::Cluster.new(music, loop_max: 20)
      kmeans.make_cluster

      music_set = music_set.to_a

      cluster_set = ClusterSet.new

      kmeans.cluster.values.each do |cls|
        cluster = Cluster.new
        cls.each do |path|
          cluster.add(music_set.find { |msc|  msc.path == path })
        end

        cluster_set.add(cluster)
      end

      cluster_set
    end
  end
end
