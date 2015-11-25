module PlayIt
  module Extraction
    class Controller
      attr_accessor :queue, :delegate

      def initialize
        @queue = []
      end

      ##
      # Pushes a song to the extraction queue.
      #
      # @param music [Music] Music to have its features extracted.
      #
      def push(music)
        queue << music
        delegate.extraction_queue_size_changed(queue.size)
      end

      ##
      # Starts the extraction in a new thread.
      # Returns if the extraction is already running.
      #
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

      private

      def running?
        @running
      end
    end
  end
end
