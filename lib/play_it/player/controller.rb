module PlayIt
  module Player
    class Controller
      attr_reader :view, :library, :streamer

      def initialize
        @view = View.new(self)
        # @library = PlayIt::Library.new
        @streamer = Streamer.new
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
        Gtk.main_quit
      end

      ##
      # Called by the view when the play icon is clicked.
      #
      def on_play_icon_view_item_activated(*_args)
        streamer.toggle
        view.toggle_play_icon
      end

      def on_replay_icon_view_item_activated(*_args)
        view.toggle_replay_icon
      end
    end
  end
end
