module PlayIt
  ##
  # Class for the configurations
  #
  class Config
    class << self
      attr_accessor :library_path

      def configure
        yield self
      end
    end
  end
end
