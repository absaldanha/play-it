module PlayIt
  module Clusterer
    class Ring
      attr_reader :music

      def initialize
        @music = []
      end

      def <<(music)
        @music << music
      end
    end
  end
end
