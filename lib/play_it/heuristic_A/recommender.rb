module PlayIt
  module Heuristic_A
    class Recommender
      attr_reader :list

      def initialize(music_set, music_seed)
        @list = []
        build_list(music_set, music_seed)

        order_list
      end

      def recommend

      end

      private

      def build_list(music_set, music_seed)
        music_set.each do |music|
          distance = euclidian_distance(music_seed.features, music.features)
          @list << Heuristic_A::Music.new(music, distance)
        end
      end

      def euclidian_distance(seed_features, music_features)
        sum = 0

        music_features.each do |key, value|
          sum += (seed_features[key] - value)**2
        end

        Math.sqrt sum
      end

      def order_list
        @list.sort_by!(&:distance_to_seed)
        @list = @list.map { |msc| msc.music }
      end
    end
  end
end
