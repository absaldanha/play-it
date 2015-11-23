module PlayIt
  class Recommender
    def initialize(library)
      @library = library
    end

    def recommend
      @library.music.to_a.sample
    end
  end
end
