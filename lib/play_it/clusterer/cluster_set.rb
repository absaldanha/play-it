module PlayIt
  module Clusterer
    ##
    # Class that represents a set of clusters
    #
    class ClusterSet
      attr_accessor :clusters
      attr_reader :dump_path

      ##
      # Creates a new array of clusters.
      #
      def initialize
        @clusters = []
        @dump_path = PlayIt::Configuration.cluster_set_path
      end

      ##
      # Adds the new cluster +cluster+ to the set.
      #
      # @param cluster [Cluster] the new cluster that will be added.
      #
      def add(cluster)
        fail(ArgumentError) unless cluster.is_a? Cluster
        @clusters << cluster
      end

      ##
      # Returns the cluster at +index+.
      #
      # @param index [Integer] the index of the cluster.
      #
      # @return [Cluster] the cluster of the given +index+ or nil.
      #
      def cluster(index)
        clusters[index]
      end

      ##
      # Returns the number of elements of this cluster set.
      #
      # @return [Integer] the number of elements.
      #
      def size
        clusters.size
      end

      ##
      # Loads the file containing the cluster set into self.
      # Returns false if the file doesn't exist.
      #
      def load
        return unless File.exist?(dump_path)
        File.open(dump_path, 'rb') { |file| @clusters = Marshal.load(file.read) }
      end

      ##
      # Creates a file containing the current state of the cluster set.
      #
      def dump
        File.open(dump_path, 'wb') { |file| file.write(Marshal.dump(@clusters)) }
      end
    end
  end
end
