module PlayIt
  class Configuration
    class << self
      attr_accessor :library_path, :command_path, :profile_path,
                    :inner_ring_chance, :outer_ring_chance,
                    :view_structure_path, :view_css_path

      def configure
        yield self
      end
    end
  end
end
