module PlayIt
  module Heuristic_A
    class Music
      attr_reader :music, :distance_to_seed

      def initialize(music, distance_to_seed)
        @music = music
        @distance_to_seed = distance_to_seed
      end
    end
  end
end
