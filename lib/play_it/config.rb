module PlayIt
  class Config
    class << self
      attr_accessor :library_path

      def configure
        yield self
      end
    end
  end
end
