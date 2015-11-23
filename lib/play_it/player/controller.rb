module PlayIt
  module Player
    class Controller
      attr_reader :view, :library, :streamer, :recommender

      def initialize
        @view = View.new(self)
        @streamer = Streamer.new(self)

        @library = PlayIt::Library.new.tap(&:load)
        @recommender = PlayIt::Recommender.new(library)
      end

      ##
      # Runs the controller, showing the view and initializing the main loop.
      #
      def run
        view.show_all
        Gtk.main
      end

      ##
      # Quits the player.
      #
      def quit
        library.dump
        Gtk.main_quit
      end

      ##
      # Called by the view when the play (or pause) icon is clicked.
      #
      def on_play_icon_view_item_activated(*_args)
        unless streamer.paused? || streamer.playing?
          streamer.next_track = recommender.recommend
        end

        view.toggle_play_icon if streamer.toggle
      end

      ##
      # Called by the view when the replay icon is clicked.
      #
      def on_replay_icon_view_item_activated(*_args)
        streamer.repeat = !streamer.repeat
        view.toggle_replay_icon
      end

      ##
      # Called by the view when files are selected to be added.
      #
      def on_confirm_file_selection(paths)
        paths.each { |path| library.add PlayIt::Music.new(path) }
      end

      ##
      # Called by the view when the skip icon is clicked.
      #
      def on_skip_icon_view_item_activated(*_args)
        return unless streamer.playing?

        streamer.next_track = recommender.recommend unless streamer.repeat
        streamer.play
      end

      ##
      # Called by the streamer when the stream is about to finish.
      #
      def stream_about_to_finish
        streamer.next_track = recommender.recommend unless streamer.repeat
        streamer.play(true)
      end
    end
  end
end
