# :nocov:

module PlayIt
  module Player
    class Controller
      attr_reader :view, :library, :cluster_set, :streamer, :recommender

      def initialize
        @view = View.new(self)
        @streamer = Streamer.new(self)

        @library = PlayIt::Library.new.tap(&:load)
        @cluster_set = PlayIt::Clusterer.load
        @recommender = PlayIt::Recommender.new(cluster_set)

        PlayIt::Extraction.delegate = self
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
        cluster_set.dump

        Gtk.main_quit
      end

      ##
      # Called by the view when the play (or pause) icon is clicked.
      #
      def on_play_icon_view_item_activated(*_args)
        played = if streamer.paused? || streamer.playing?
                   streamer.toggle
                 else
                   (streamer.next_track = next_track(:start)) && streamer.play
                 end

        view.toggle_play_icon if played
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
      def on_confirm_file_selection(folders)
        hide_message

        folders.each do |folder|
          Dir["#{folder}/**/*.mp3"].each do |path|
            music = PlayIt::Music.new(path)
            PlayIt::Extraction.push(music) if library.add(music)
          end
        end

        PlayIt::Extraction.start
      end

      ##
      # Called by the view when the skip icon is clicked.
      #
      def on_skip_icon_view_item_activated(*_args)
        return unless streamer.playing?

        streamer.next_track = next_track(:skip)
        streamer.play
      end

      ##
      # Called by the streamer when the stream is about to finish.
      #
      def stream_about_to_finish
        streamer.next_track = next_track(:finish)
        streamer.play(true)
      end

      ##
      # Called by the extractor when the extraction is finished.
      #
      def extraction_finished
        hide_message
        invoke_clusterer
      end

      ##
      # Called by the extractor when there is an update in the extraction.
      #
      def extraction_queue_size_changed(remaining)
        pluralizer, verb, possessive =
          (remaining += 1) > 1 ? %w(s are their) : ['', 'is', 'its']

        display_message "#{remaining} song#{pluralizer} #{verb} telling #{possessive} story"
      end

      private

      def invoke_clusterer
        display_message 'Songs are making friends'

        @cluster_set.clusters = PlayIt::Clusterer.make_clusters(
          library.music,
          PlayIt::Configuration.k,
          PlayIt::Configuration.clustering_runs * library.music.size
        ).clusters

        hide_message
      end

      def display_message(message)
        view.label.text = message.to_s
        view.revealer.set_reveal_child true
      end

      def hide_message
        view.revealer.set_reveal_child false
      end

      def next_track(event)
        if library.music.empty?
          display_message "You haven't added songs"

          false
        elsif streamer.repeat
          streamer.next_track
        elsif cluster_set.clusters.empty?
          library.sample
        else
          recommender.recommend(event)
        end
      end
    end
  end
end
