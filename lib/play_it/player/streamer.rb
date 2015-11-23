module PlayIt
  module Player
    class Streamer
      attr_accessor :current_track, :next_track, :repeat

      def initialize(controller)
        @controller = controller
        configure_playbin
      end

      ##
      # Plays the streamer's next_track.
      #
      # @param ready [Boolean] true if the streamer is ready (does not need to
      #                        go back to ready state) or false otherwise.
      #
      def play(ready = false)
        return unless next_track

        @playbin.ready unless ready

        self.current_track = next_track
        self.next_track = nil unless repeat

        @playbin.uri = Gst.filename_to_uri(current_track.path)
        @playbin.play
      end

      ##
      # Toggle the state of the streamer between playing and paused.
      #
      def toggle
        if playing?
          @playbin.pause
        elsif paused?
          @playbin.play
        else
          play
        end
      end

      ##
      # Set the repeat flag of the streamer. If true, sets the next_track to
      # the current track.
      #
      # @param repeat [Boolean] whether or not to repeat the current track.
      #
      def repeat=(repeat)
        @repeat = repeat
        self.next_track = current_track if repeat
      end

      ##
      # Returns whether the streamer is in the 'playing' state.
      #
      # @return [Boolean] true if the streamer is playing, false otherwise.
      #
      def playing?
        @playbin.get_state(0)[1] == Gst::State::PLAYING
      end

      ##
      # Returns whether the streamer is in the 'paused' state.
      #
      # @return [Boolean] true if the streamer is paused, false otherwise.
      #
      def paused?
        @playbin.get_state(0)[1] == Gst::State::PAUSED
      end

      private

      def configure_playbin
        @playbin = Gst::ElementFactory.make 'playbin'
        @playbin.signal_connect('about-to-finish') do
          @controller.stream_about_to_finish
        end
      end
    end
  end
end
