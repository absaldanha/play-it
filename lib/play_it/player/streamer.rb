module PlayIt
  module Player
    class Streamer
      attr_reader :playlist
      attr_accessor :current_track

      def initialize
        @playbin = Gst::ElementFactory.make 'playbin'
        @playlist = Dir['*.mp3'].to_enum
      end

      def play
        return unless next_track? && not_playing?

        self.current_track = playlist.next
        play_current_track
      end

      def pause
        @playbin.pause
      end

      def toggle
        if playing?
          pause
        elsif paused?
          resume
        else
          play
        end
      end

      def playing?
        !not_playing?
      end

      def cover_art
      end

      def tags
        @playbin.get_audio_tags(0)
      end

      private

      def not_playing?
        @playbin.get_state(0)[1] != Gst::State::PLAYING
      end

      def next_track?
        playlist.peek
      rescue StopIteration
        false
      end

      def play_current_track
        @playbin.ready
        @playbin.uri = Gst.filename_to_uri(current_track)
        @playbin.play
      end

      def resume
        @playbin.play
      end

      def paused?
        @playbin.get_state(0)[1] == Gst::State::PAUSED
      end
    end
  end
end
