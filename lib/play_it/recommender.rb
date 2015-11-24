require 'probability'

module PlayIt
  class Recommender
    attr_reader :cluster_index, :ring, :cluster_set, :ring_music,
                :chance_to_inner_ring, :chance_to_outer_ring

    def initialize(cluster_set)
      @cluster_set = cluster_set
      @cluster_index = rand cluster_set.size
      @ring = 0
      @played_music = []
      @chance_to_inner_ring = PlayIt::Configuration.inner_ring_chance
      @chance_to_outer_ring = PlayIt::Configuration.outer_ring_chance
    end

    def recommend(last_action)
      change_ring if last_action == :skip
      try_change_ring

      change_ring while ring_music.empty?

      available_music = ring_music - @played_music.last(10)
      music = available_music.sample || ring_music.sample

      @played_music << music

      music
    end

    private

    def ring_music
      @ring_music ||= update_ring_music
    end

    def change_ring
      ring < 2 ? change_to_outer_ring : next_cluster
    end

    def try_change_ring
      chance_to_inner_ring.in(100) { change_to_inner_ring if ring > 0 }
      chance_to_outer_ring.in(100) { change_to_outer_ring if ring < 0 }
    end

    def change_to_inner_ring
      @ring -= 1
      update_ring_music
    end

    def change_to_outer_ring
      @ring += 1
      update_ring_music
    end

    def update_ring_music
      cluster = cluster_set.cluster(cluster_index)
      @ring_music = cluster ? cluster.ring(ring) : []
    end

    def next_cluster
      @cluster_index += 1
      @cluster_index = 0 if @cluster_index > cluster_set.size - 1

      @ring = 0

      update_ring_music
    end

    def played?(music)
      @played_music.include? music
    end
  end
end
