module PlayIt
  module Player
    class View
      extend Forwardable

      attr_accessor :controller

      def_delegators :@controller,
                     :on_play_icon_view_item_activated,
                     :on_replay_icon_view_item_activated,
                     :on_skip_icon_view_item_activated

      def initialize(controller)
        @controller = controller
        configure
        provide
        build
        style
      end

      def show_all
        window.show_all
      end

      ##
      # Toggles the play icon to either play or pause.
      #
      def toggle_play_icon
        if play_icon_view.model == play_list_store
          play_icon_view.model = pause_list_store
        else
          play_icon_view.model = play_list_store
        end
      end

      ##
      # Toggles the replay icon to either enabled or disabled.
      #
      def toggle_replay_icon
        if replay_icon_view.model == replay_list_store
          replay_icon_view.model = disabled_replay_list_store
        else
          replay_icon_view.model = replay_list_store
        end
      end

      private

      def configure
        @structure_path = PlayIt::Configuration.view_structure_path
        @css_path = PlayIt::Configuration.view_css_path
      end

      def build
        @builder = Gtk::Builder.new
        @builder.add_from_file(@structure_path)
        @builder.connect_signals { |handler| method(handler) }

        icon_views.each { |icon_view| icon_view.pixbuf_column = 0 }
      end

      def provide
        @provider = Gtk::CssProvider.new
        @provider.load_from_data(File.read(@css_path))
      end

      def style(widget = window)
        widget.style_context.add_provider(@provider, GLib::MAXUINT)
        widget.each_all { |child| style(child) } if widget.is_a? Gtk::Container
      end

      def icon_views
        @builder.objects.select { |obj| obj.class == Gtk::IconView }
      end

      def quit
        controller.quit
      end

      def recursive_set_state(widget = window, state)
        widget.set_state_flags state, true
        widget.each { |child| recursive_set_state(child, state) } if
          widget.is_a? Gtk::Container
      end

      def on_window_enter_notify_event
        recursive_set_state :active
      end

      def on_window_leave_notify_event
        recursive_set_state :normal
      end

      def on_add_icon_view_item_activated
        file_chooser.run
      end

      def cancel_file_selection
        file_chooser.hide
      end

      def confirm_file_selection
        file_chooser.hide
        controller.on_confirm_file_selection(file_chooser.filenames)
      end

      def on_add_icon_view_enter_notify_event
        puts 'ENTER ADD'
      end

      def method_missing(meth, *_args)
        @builder.get_object(meth.to_s) || super
      end
    end
  end
end
