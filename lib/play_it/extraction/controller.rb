module PlayIt
  module Extraction
    class Controller
      attr_accessor :queue, :delegate

      def initialize
        @queue = []
      end

      def push(music)
        queue << music
        delegate.extraction_queue_size_changed(queue.size)
      end

      def start
        return if running?
        @running = true

        Thread.new do
          while (music = queue.pop)
            delegate.extraction_queue_size_changed(queue.size)
            music.features = Extractor.extract_features(music.path)
          end

          @running = false
          delegate.extraction_finished
        end
      end

      def running?
        @running
      end
    end
  end
end
